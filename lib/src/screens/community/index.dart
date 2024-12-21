import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/community_controller.dart';
import '../../widgets/listitems/community_list_item.dart';
import 'create.dart';

class CommunityIndex extends StatefulWidget {
  const CommunityIndex({super.key});

  @override
  State<CommunityIndex> createState() => _CommunityIndexState();
}

class _CommunityIndexState extends State<CommunityIndex> {
  final controller = Get.put(CommunityController());
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    controller.communityIndex();
  }

  Future<void> _onRefresh() async {
    _currentPage = 1;
    await controller.communityIndex();
  }

  bool _onNotification(info) {
    if (info is ScrollEndNotification && info.metrics.extentAfter == 0) {
      controller.communityIndex(page: ++_currentPage);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('동네'),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'community',
        onPressed: () {
          Get.to(() => const CommunityCreate());
        },
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Obx(() {
        return NotificationListener<ScrollNotification>(
          onNotification: _onNotification,
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: controller.itemList.length,
              itemBuilder: (context, index) {
                return CommunityListItem(controller.itemList[index]);
              },
            ),
          ),
        );
      }),
    );
  }
}
