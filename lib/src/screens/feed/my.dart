import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/feed_controller.dart';
import '../../widgets/listitems/feed_list_item.dart';

class FeedMy extends StatefulWidget {
  const FeedMy({super.key});

  @override
  State<FeedMy> createState() => _FeedMyState();
}

class _FeedMyState extends State<FeedMy> {
  final FeedController feedController = Get.put(FeedController());
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    feedController.myIndex();
  }

  Future<void> _onRefresh() async {
    _currentPage = 1;
    await feedController.myIndex();
  }

  bool _onNotification(ScrollNotification scrollInfo) {
    if (scrollInfo is ScrollEndNotification &&
        scrollInfo.metrics.extentAfter == 0) {
      feedController.myIndex(page: ++_currentPage);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('판매 내역'),
      ),
      body: Column(
        children: [
          // 중고거래 목록
          Expanded(
            child: Obx(() {
              if (feedController.myFeedList.isEmpty) {
                return const Center(
                  child: Text(
                    '결과가 없습니다.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              } else {
                return NotificationListener<ScrollNotification>(
                  onNotification: _onNotification,
                  child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      itemCount: feedController.myFeedList.length,
                      itemBuilder: (context, index) {
                        return FeedListItem(feedController.myFeedList[index]);
                      },
                    ),
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
