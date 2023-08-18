import 'package:get/get.dart';

import '../server_model.dart';

class ServerProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Server.fromJson(map);
      if (map is List) return map.map((item) => Server.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Server?> getServer(int id) async {
    final response = await get('server/$id');
    return response.body;
  }

  Future<Response<Server>> postServer(Server server) async =>
      await post('server', server);
  Future<Response> deleteServer(int id) async => await delete('server/$id');
}
