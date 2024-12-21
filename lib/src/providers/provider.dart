import 'package:carrot_flutter/src/shared/global.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Provider extends GetConnect {
  final box = GetStorage();

  @override
  void onInit() {
    allowAutoSignedCert = true;
    httpClient.baseUrl = Global.baseUrl;
    httpClient.addRequestModifier<void>((request) {
      request.headers['Accept'] = 'application/json';
      if(request.url.toString().contains('/api/')) {
        request.headers['Authorization'] = 'Bearer ${box.read('access_token')}';
      }
      return request;
    });
    super.onInit();
  }
}