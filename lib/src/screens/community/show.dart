import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/community_controller.dart';
import '../../widgets/basic/image_box.dart';
import '../../widgets/listitems/user_list_item.dart';
import '../../widgets/modal/commu_modal.dart';
import 'edit.dart';

class CommunityShow extends StatefulWidget {
  final int id;
  const CommunityShow(this.id, {super.key});

  @override
  State<CommunityShow> createState() => _CommunityShowState();
}

class _CommunityShowState extends State<CommunityShow> {
  final controller = Get.put(CommunityController());

  @override
  void initState() {
    super.initState();
    controller.communityShow(widget.id);
  }

  editButton() {
    Get.to(() => CommunityEdit(widget.id));
  }

  deleteButton() async {
    final result = await controller.communityDelete(widget.id);
    if (result) Get.back();
  }

  moreButton() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CommuBottomModal(onEdit: editButton, onDelete: deleteButton);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: moreButton, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Obx(
            () {
          final model = controller.currentItem.value;
          if (model == null) return const CircularProgressIndicator();
          return ListView(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        model.category,
                        style: const TextStyle().copyWith(
                          fontSize: 12,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              UserListItem(model.writer!),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title,
                      style: const TextStyle().copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      model.content,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    ImageBox(model.imageUrl),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
