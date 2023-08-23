import 'dart:async';

import 'package:bdix_ftps/app/modules/home/providers/server_provider.dart';
import 'package:bdix_ftps/app/modules/home/server_model.dart';
import 'package:bdix_ftps/app/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:super_ui_kit/super_ui_kit.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  final ServerProvider _serverProvider = ServerProvider();
  late PageController pageController;

  final selectedIndex = 0.obs;
  final title = kTitleMovieServer.obs;

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

  pageChanged(int value) {
    print("pageChanged");
    Timer(Duration(milliseconds: 500), () async {
    switch (value) {
      case 0:
        serverList.value = movieServerList;
        title.value = kTitleMovieServer;
        break;
      case 1:
        serverList.value = tvServerList;
        title.value = kTitleTvServer;
        break;
      case 2:
        serverList.value = ftpServerList;
        title.value = kTitleFtpServer;
        break;
      case 3:
        serverList.value = torrentServerList;
        title.value = kTitleTorrentServer;
        break;
      default:
        serverList.value = movieServerList;
        title.value = kTitleMovieServer;
    }
    });
    // Get.hideLoader();
  }
}
