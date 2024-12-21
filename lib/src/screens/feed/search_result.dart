import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/feed_controller.dart';
import '../../widgets/listitems/feed_list_item.dart';

class FeedSearchResult extends StatefulWidget {
  final String keyword;
  const FeedSearchResult(this.keyword, {super.key});

  @override
  State<FeedSearchResult> createState() => FeedSearchResultState();
}

class FeedSearchResultState extends State<FeedSearchResult> {
  final FeedController feedController = Get.put(FeedController());
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    feedController.searchIndex(widget.keyword);
  }

  Future<void> _onRefresh() async {
    _currentPage = 1;
    await feedController.searchIndex(widget.keyword);
  }

  bool _onNotification(ScrollNotification scrollInfo) {
    if (scrollInfo is ScrollEndNotification &&
        scrollInfo.metrics.extentAfter == 0) {
      feedController.searchIndex(widget.keyword, page: ++_currentPage);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.keyword),
      ),
      body: Column(
        children: [
          // 중고거래 목록
          Expanded(
            child: Obx(() {
              if (feedController.searchList.isEmpty) {
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
                      itemCount: feedController.searchList.length,
                      itemBuilder: (context, index) {
                        return FeedListItem(feedController.searchList[index]);
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
