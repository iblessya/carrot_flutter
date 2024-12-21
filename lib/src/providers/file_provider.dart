import 'package:carrot_flutter/src/providers/provider.dart';
import 'package:get/get.dart';

class FileProvider extends Provider {
  imageUpload(String name, String path) async {
    final form = FormData({'file': MultipartFile(path, filename: name)});

    Response response = await post('/file', form);
    return response.body;
  }
}