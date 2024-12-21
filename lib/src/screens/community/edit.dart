import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/community_controller.dart';
import '../../controllers/file_controller.dart';
import '../../widgets/basic/image_box.dart';
import '../../widgets/forms/commu_dropdown.dart';
import '../../widgets/forms/commu_textfield.dart';

class CommunityEdit extends StatefulWidget {
  final int id;
  const CommunityEdit(this.id, {super.key});

  @override
  State<CommunityEdit> createState() => _CommunityEditState();
}

class _CommunityEditState extends State<CommunityEdit> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final controller = Get.put(CommunityController());
  final fileController = Get.put(FileController());
  String? _selectedCategory;

  submit() async {
    if (_selectedCategory == null) {
      Get.snackbar('오류', '분류를 골라주세요', snackPosition: SnackPosition.BOTTOM);
    }

    final result = await controller.communityUpdate(
      widget.id,
      _selectedCategory!,
      titleController.text,
      contentController.text,
      fileController.imageId.value,
    );
    if (result) {
      Get.back();
      Get.back();
    }
  }

  @override
  void initState() {
    super.initState();
    final item = controller.currentItem.value!;

    titleController.text = item.title;
    contentController.text = item.content;
    fileController.imageId.value = item.imageId;
    _selectedCategory = item.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('동네생활 수정'),
        actions: [TextButton(onPressed: submit, child: const Text('완료'))],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Divider(),
            CommuDropdown(
              selectedValue: _selectedCategory,
              items: controller.categories,
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
            ),
            const Divider(),
            CommuTextField(
              hint: '제목을 입력하세요',
              controller: titleController,
              fontSize: 18,
            ),
            Expanded(
              child: CommuTextField(
                hint: '동네 근처 이웃과 러닝, 헬스, 테니스 등 운동 이야기를 나눠보세요',
                controller: contentController,
                maxLines: null,
              ),
            ),
            Obx(
                  () => Visibility(
                visible: fileController.imageUrl != null,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      ImageBox(fileController.imageUrl),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(),
            Row(
              children: [
                InkWell(
                  onTap: fileController.upload,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.image_outlined),
                        SizedBox(width: 5),
                        Text('사진'),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
