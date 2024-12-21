import 'dart:async';
import 'dart:developer';
import 'package:carrot_flutter/src/providers/auth_provider.dart';
import 'package:carrot_flutter/src/shared/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final box = GetStorage();

  final authProvider = Get.put(AuthProvider());
  final RxBool isButtonEnabled = false.obs;
  final RxBool showVerifyForm = false.obs;
  final RxString buttonText = "인증 문자 받기".obs;
  String? phoneNumber;  // requestVerificationCode 함수에서 기록한 폰번호
  Timer? countdownTimer;

  Future<bool> register(String password, String name, int? profile) async {
    Map body =
    await authProvider.register(phoneNumber!, password, name, profile);
    if (body['result'] == 'ok') {
      String token = body['access_token'];
      log('token : $token'); // dart:developer 패키지 내의 log 함수
      await box.write('access_token', token);

      return true;
    }
    Get.snackbar('회원가입 에러', body['message'],
        snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  // 휴대폰 인증 코드를 요청하는 함수
  Future<void> requestVerificationCode(String phone) async {
    Map body = await authProvider.requestPhoneCode(phone);
    if (body['result'] == 'ok') {
      phoneNumber = phone; // 인증 받은 휴대폰 번호를 저장
      DateTime expiryTime = DateTime.parse(body['expired']);
      _startCountdown(expiryTime);
    }
  }

// 사용자가 입력한 코드를 검증하는 함수
  Future<bool> verifyPhoneNumber(String userInputCode) async {
    Map body = await authProvider.verifyPhoneNumber(userInputCode);
    if (body['result'] == 'ok') {
      return true;
    }
    Get.snackbar('인증 번호 에러', body['message'],
        snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  void _startCountdown(DateTime expiryTime) {
    isButtonEnabled.value = false; // 버튼 비활성화
    showVerifyForm.value = true; // 인증 폼 활성화
    countdownTimer?.cancel(); // 기존 타이머가 있다면 취소
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      Duration timeDiff = expiryTime.difference(DateTime.now());
      if (timeDiff.isNegative) {
        buttonText.value = "인증문자 다시 받기";
        isButtonEnabled.value = true;
        timer.cancel(); // 타이머 종료
      } else {
        // 남은 시간을 mm:ss 포맷으로 업데이트
        String minutes = timeDiff.inMinutes.toString().padLeft(2, '0');
        String seconds = (timeDiff.inSeconds % 60).toString().padLeft(2, '0');
        buttonText.value = "인증문자 다시 받기 $minutes:$seconds";
      }
    });
  }
  // 나머지 동일

  void updateButtonState(TextEditingController phoneController) {
    String rawText = phoneController.text;
    String text = rawText.replaceAll('-', ''); // 하이픈 제거
    // 사용자가 모든 내용을 삭제하려 할 때 '010'만 남깁니다.
    if (text.length <= 3 && !rawText.startsWith('010')) {
      text = '010';
    } else if (text.length > 3 && !text.startsWith('010')) {
      // 입력된 텍스트가 '010'으로 시작하지 않으면 '010'을 자동으로 추가합니다.
      text = '010$text';
    }
    // 최대 길이를 11자로 제한합니다.
    if (text.length > 11) {
      text = text.substring(0, 11);
    }
    String formattedText = _formatPhoneNumber(text);
    // 커서 위치 조정
    int cursorPosition = phoneController.selection.baseOffset +
        (formattedText.length - rawText.length);
    // 컨트롤러 값 업데이트 부분에서는 직접 phoneController에 접근합니다.
    phoneController.value = TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
          offset: cursorPosition >= formattedText.length
              ? formattedText.length
              : cursorPosition),
    );
    // 맨 아랫줄에 추가
    isButtonEnabled.value = text.length == 11;
  }

  String _formatPhoneNumber(String text) {
    // 하이픈 자동 삽입 로직
    if (text.length > 3 && text.length <= 7) {
      return '${text.substring(0, 3)}-${text.substring(3)}';
    } else if (text.length > 7) {
      return '${text.substring(0, 3)}-${text.substring(3, 7)}-${text.substring(7)}';
    }
    return text;
  }

  Future<bool> login(String phone, String password) async {
    Map body = await authProvider.login(phone, password);
    if(body['result'] == 'ok') {
      String token = body['access_token'];
      log('token : $token');
      await box.write('access_token', token);
      return true;
    }
    Get.snackbar('로그인 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  Future<void> logout() async {
    await box.remove('access_token');
  }

}
