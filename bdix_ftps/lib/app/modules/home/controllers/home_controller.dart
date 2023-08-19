import 'package:bdix_ftps/app/modules/home/providers/server_provider.dart';
import 'package:bdix_ftps/app/modules/home/server_model.dart';
import 'package:bdix_ftps/app/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  final ServerProvider _serverProvider = ServerProvider();
  late PageController pageController;

  final selectedIndex = 0.obs;

  final serverList = <Server>[].obs;

  final movieServerList = <Server>[].obs;
  final tvServerList = <Server>[].obs;
  final torrentServerList = <Server>[].obs;
  final ftpServerList = <Server>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    pageController = PageController(initialPage: selectedIndex.value);
    fetchServerData();
    selectedIndex.listen((value) {
      value.printInfo();
      switch (value) {
        case 0:
          serverList.value = movieServerList;
          break;
        case 1:
          serverList.value = tvServerList;
          break;
        case 2:
          serverList.value = torrentServerList;
          break;
        case 3:
          serverList.value = ftpServerList;
          break;
        default:
          serverList.value = movieServerList;
      }
    });
  }

  Future<void> fetchServerData() async {
    var res = await _serverProvider.getFtpServers(movieServerFileName);
    if (res != null && res.isNotEmpty) {
      movieServerList.value = res;
      serverList.value = res;
    }

    res = await _serverProvider.getFtpServers(tvServerFileName);
    if (res != null && res.isNotEmpty) {
      tvServerList.value = res;
    }

    res = await _serverProvider.getFtpServers(torrentServerFileName);
    if (res != null && res.isNotEmpty) {
      torrentServerList.value = res;
    }

    res = await _serverProvider.getFtpServers(ftpServerFileName);
    if (res != null && res.isNotEmpty) {
      ftpServerList.value = res;
    }
  }

  openServer(Server server) async {
    // Define the URL as a Uri object
    if (server.url?.isBlank ?? true) return;
    var url = Uri.parse(server.url!);

    // Check if the URL can be launched
    if (await canLaunchUrl(url)) {
      // Launch the URL in a new tab
      await launchUrl(
        url,
      );
    } else {
      // Show an error message
      throw 'Could not launch $url';
    }
  }
}
