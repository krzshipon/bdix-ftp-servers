import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../server_model.dart';

const baseFtpUrl = 'krzshipon.github.io';

class ServerProvider extends GetConnect {
  Future<List<Server>?> getFtpServers(String path) async {
    var url = Uri.https(
      baseFtpUrl,
      '/bdix-ftp-servers/$path',
    );

    var response = await http.get(url);

    if (response.statusCode == 200) {
      response.body.printInfo();
      final List<dynamic> jsonList = json.decode(response.body);
      final List<Server> serverList =
          jsonList.map((json) => Server.fromJson(json)).toList();
      return serverList;
    } else {
      response.statusCode.printInfo();
      return [];
    }
  }
}
