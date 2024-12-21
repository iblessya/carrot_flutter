import 'package:carrot_flutter/src/screens/feed/create.dart';
import 'package:carrot_flutter/src/screens/feed/search_form.dart';
import 'package:carrot_flutter/src/widgets/listitems/feed_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/feed_controller.dart';
import '../../widgets/buttons/category_button.dart';

class FeedIndex extends StatefulWidget {
  const FeedIndex({super.key});
  @override
  State<FeedIndex> createState() => _FeedIndexState();
}

class _FeedIndexState extends State<FeedIndex> {
  int _currentPage = 1;
  final FeedController feedController = Get.put(FeedController());

  @override
  void initState() {
    super.initState();
    feedController.feedIndex(page: _currentPage);
  }

  bool _onNotification(ScrollNotification scrollInfo) {
    if (scrollInfo is ScrollEndNotification &&
        scrollInfo.metrics.extentAfter == 0) {
      feedController.feedIndex(page: ++_currentPage);
      return true;
    }
    return false;
  }

  Future<void> _onRefresh() async {
    _currentPage = 1;
    await feedController.feedIndex(page: _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        // onPressed: feedController.addData,
        onPressed: () {
          Get.to(() => const FeedCreate());
        },
        tooltip: '항목 추가',
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        centerTitle: false,
        title: const Text('내 동네'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const FeedSearchForm());
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                CategoryButton(icon: Icons.menu),
                SizedBox(width: 12),
                CategoryButton(icon: Icons.search, title: '알바'),
                SizedBox(width: 12),
                CategoryButton(icon: Icons.home, title: '부동산'),
                SizedBox(width: 12),
                CategoryButton(icon: Icons.car_crash, title: '중고차'),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              return NotificationListener<ScrollNotification>(
                onNotification: _onNotification,
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: ListView.builder(
                    itemCount: feedController.feedList.length,
                    itemBuilder: (context, index) {
                      return FeedListItem(feedController.feedList[index]);
                    },
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
