import 'package:get/get.dart';

import '../models/feed_model.dart';
import '../providers/feed_provider.dart';

class FeedController extends GetxController {
  final feedProvider = Get.put(FeedProvider());
  final RxList<FeedModel> feedList = <FeedModel>[].obs;
  final RxList<FeedModel> searchList = <FeedModel>[].obs;
  final RxList<FeedModel> myFeedList = <FeedModel>[].obs;
  final RxList<FeedModel> favoriteList = <FeedModel>[].obs;
  final Rx<FeedModel?> currentFeed = Rx<FeedModel?>(null);

  feedIndex({int page = 1}) async {
    Map json = await feedProvider.index(page);
    List<FeedModel> tmp =
    json['data'].map<FeedModel>((m) => FeedModel.parse(m)).toList();
    (page == 1) ? feedList.assignAll(tmp) : feedList.addAll(tmp);
  }

  searchIndex(String keyword, {int page = 1}) async {
    Map json = await feedProvider.index(page, keyword: keyword);
    List<FeedModel> tmp =
    json['data'].map<FeedModel>((m) => FeedModel.parse(m)).toList();
    (page == 1) ? searchList.assignAll(tmp) : searchList.addAll(tmp);
  }

  myIndex({int page = 1}) async {
    Map json = await feedProvider.myIndex(page);
    List<FeedModel> tmp =
    json['data'].map<FeedModel>((m) => FeedModel.parse(m)).toList();
    (page == 1) ? myFeedList.assignAll(tmp) : myFeedList.addAll(tmp);
  }

  favoriteIndex({int page = 1}) async {
    Map json = await feedProvider.favoriteIndex(page);
    List<FeedModel> tmp =
    json['data'].map<FeedModel>((m) => FeedModel.parse(m)).toList();
    (page == 1) ? favoriteList.assignAll(tmp) : favoriteList.addAll(tmp);
  }

  Future<bool> feedCreate(
      String title, String price, String content, int? image) async {
    Map body = await feedProvider.store(title, price, content, image);
    if (body['result'] == 'ok') {
      await feedIndex();
      return true;
    }
    Get.snackbar('생성 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  feedUpdate(int id, String title, String priceString, String content,
      int? image) async {
    // price와 image를 적절한 타입으로 변환
    int price = int.tryParse(priceString) ?? 0; // price를 int로 변환, 실패 시 0

    Map body =
    await feedProvider.update(id, title, priceString, content, image);
    if (body['result'] == 'ok') {
      // ID를 기반으로 리스트에서 해당 요소를 찾아 업데이트
      int index = feedList.indexWhere((feed) => feed.id == id);
      if (index != -1) {
        // 찾은 인덱스 위치의 요소를 업데이트
        FeedModel updatedFeed = feedList[index].copyWith(
          title: title,
          price: price,
          content: content,
          imageId: image,
        );
        feedList[index] = updatedFeed; // 특정 인덱스의 요소를 새로운 모델로 교체
      }
      return true;
    }
    Get.snackbar('수정 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  Future<void> feedShow(int id) async {
    Map body = await feedProvider.show(id);
    if (body['result'] == 'ok') {
      currentFeed.value = FeedModel.parse(body['data']);
      return;
    }
    Get.snackbar('피드 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    currentFeed.value = null; // 에러 발생 시 null로 설정
  }

  Future<bool> feedDelete(int id) async {
    Map body = await feedProvider.destroy(id);
    if (body['result'] == 'ok') {
      // 삭제 성공 시 리스트에서 해당 피드 제거
      feedList.removeWhere((feed) => feed.id == id);
      return true;
    }
    Get.snackbar('삭제 에러', body['message'], snackPosition: SnackPosition.BOTTOM);
    return false;
  }

  Future<void> toggleFavorite(int feedId) async {
    Map response = await feedProvider.toggleFavorite(feedId);
    if (response['result'] == 'ok') {
      FeedModel updatedFeed = currentFeed.value!.copyWith(
        isFavorite: response['action'] == 'added',
      );
      currentFeed.value = updatedFeed;
    } else {
      Get.snackbar('즐겨찾기 에러', response['message'],
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
