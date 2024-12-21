import 'package:carrot_flutter/src/controllers/file_controller.dart';
import 'package:carrot_flutter/src/widgets/buttons/feed_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/feed_controller.dart';
import '../../models/feed_model.dart';
import '../../widgets/forms/label_textfield.dart';

class FeedEdit extends StatefulWidget {
  final FeedModel model; // 추가
  const FeedEdit(this.model, {super.key}); // 생성자 추가
  @override
  State<FeedEdit> createState() => _FeedEditState();
}

class _FeedEditState extends State<FeedEdit> {
  final feedController = Get.put(FeedController());
  final fileContorller = Get.put(FileController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  _submit() async {
    print('BBBBBBefore entering feedUpdate>>>>>>>>>');
    final result = await feedController.feedUpdate(
      widget.model.id,
      _titleController.text,
      _priceController.text,
      _contentController.text,
      fileContorller.imageId.value,
    );
    print('<<<<< edit >>>>>>>>');
    print('result = ${result.toString()}');
    if (result) {
      Get.back();
    }
  }

  @override
  void initState() {
    super.initState();
// 초기화 이후 TextField에 값을 채워주기 위한 작업
    _titleController.text = widget.model.title;
    _priceController.text = widget.model.price.toString();
    _contentController.text = widget.model.content;
    fileContorller.imageId.value = widget.model.imageId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('물건정보 수정')), // 제목 변경
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  InkWell(
                    onTap: fileContorller.upload,
                    child: Obx(
                        () => FeedImage(fileContorller.imageUrl),
                    ),
                  ),
                  const SizedBox(height: 16),
                  LabelTextField(
                    label: '제목',
                    hintText: '제목',
                    controller: _titleController,
                  ),
                  LabelTextField(
                    label: '가격',
                    hintText: '가격을 입력해주세요.',
                    controller: _priceController,
                  ),
                  LabelTextField(
                    label: '자세한 설명',
                    hintText: '자세한 설명을 입력하세요',
                    controller: _contentController,
                    maxLines: 6,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: _submit,
                child: const Text('수정 완료'), // 버튼 텍스트 변경
              ),
            ),
          ],
        ),
      ),
    );
  }
}
