import 'package:carrot_flutter/src/controllers/file_controller.dart';
import 'package:carrot_flutter/src/widgets/buttons/circle_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../widgets/forms/label_textfield.dart';
import '../../controllers/auth_controller.dart';
import '../home.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final authController = Get.put(AuthController());
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _nameController = TextEditingController();
  final fileController = Get.put(FileController());

  _submit() async {
    bool result = await authController.register(
      _passwordController.text,
      _nameController.text,
      fileController.imageId.value,
    );
    if (result) {
      Get.offAll(() => const Home());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원 가입')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            // 프로필 이미지
            InkWell(
              onTap: fileController.upload,
              child: Obx(
                  () => CircleImage(fileController.imageUrl),
              ),
            ),
            const SizedBox(height: 16),
            // 비밀번호
            LabelTextField(
              label: '비밀번호',
              hintText: '비밀번호를 입력해주세요',
              controller: _passwordController,
              isObscure: true,
            ),
            // 비밀번호 확인
            LabelTextField(
              label: '비밀번호 확인',
              hintText: '비밀번호를 한번 더 입력해주세요',
              controller: _passwordConfirmController,
              isObscure: true,
            ),
            // 닉네임
            LabelTextField(
              label: '닉네임',
              hintText: '닉네임을 입력해주세요',
              controller: _nameController,
              isObscure: false,
            ),
            // 버튼
            ElevatedButton(
              onPressed: _submit,
              child: const Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
