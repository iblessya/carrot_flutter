import 'provider.dart';

class FeedProvider extends Provider {
  Future<Map> index(int page, {String? keyword}) async {
    final query = {'page': '$page'};

    if (keyword != null) query['keyword'] = keyword;

    final response = await get('/api/feed', query: query);
    return response.body;
  }

  Future<Map> myIndex(int page) async {
    final response = await get('/api/user/my/feed', query: {'page': '$page'});
    return response.body;
  }

  Future<Map> favoriteIndex(int page) async {
    final response = await get('/api/feed/favorite', query: {'page': '$page'});
    return response.body;
  }

  Future<Map> store(
      String title, String price, String content, int? image) async {
    final Map<String, dynamic> body = {
      'title': title,
      'price': price,
      'content': content,
    };

    if (image != null) {
      body['image'] = image.toString();
    }

    final response = await post('/api/feed', body);
    return response.body;
  }

  Future<Map> show(int id) async {
    final response = await get('/api/feed/$id');
    return response.body;
  }

  Future<Map> update(
      int id, String title, String price, String content, int? image) async {
    final Map<String, dynamic> body = {
      'title': title,
      'price': price,
      'content': content,
    };

    if (image != null) {
      body['image'] = image.toString();
    }

    final response = await put('/api/feed/$id', body);
    return response.body;
  }

  Future<Map> destroy(int id) async {
    final response = await delete('/api/feed/$id');
    return response.body;
  }

  // 즐겨찾기 토글 함수 추가
  Future<Map> toggleFavorite(int feedId) async {
    final response = await put('/api/feed/$feedId/favorite', {});
    return response.body;
  }
}
