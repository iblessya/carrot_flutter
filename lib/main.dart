import 'package:carrot_flutter/src/app.dart';
import 'package:carrot_flutter/src/shared/global.dart';
import 'package:carrot_flutter/src/shared/timeutil.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

// 메인
Future<void> main() async {
  await GetStorage.init();
  final box = GetStorage();

  TimeUtil.init();

  String? token = box.read('access_token');
  bool isLogin = (token != null) ? true : false;

  runApp(MyApp(isLogin));
}