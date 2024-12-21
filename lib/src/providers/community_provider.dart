import 'provider.dart';

class CommunityProvider extends Provider {
  Future<Map> index(int page, {String? keyword}) async {
    final response = await get('/api/community', query: {'page': '$page'});
    return response.body;
  }

  Future<Map> store(
      String title,
      String category,
      String content,
      int? image,
      ) async {
    final body = {'title': title, 'category': category, 'content': content};

    if (image != null) {
      body['image'] = image.toString();
    }

    final response = await post('/api/community', body);
    return response.body;
  }

  Future<Map> show(int id) async {
    final response = await get('/api/community/$id');
    return response.body;
  }

  Future<Map> update(
      int id,
      String category,
      String title,
      String content,
      int? image,
      ) async {
    final body = {'category': category, 'title': title, 'content': content};

    if (image != null) {
      body['image'] = image.toString();
    }

    final response = await put('/api/community/$id', body);
    return response.body;
  }

  Future<Map> destroy(int id) async {
    final response = await delete('/api/community/$id');
    return response.body;
  }
}
