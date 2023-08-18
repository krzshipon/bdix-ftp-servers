import 'package:bdix_ftps/app/modules/home/server_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  late PageController pageController;

  final selectedIndex = 0.obs;

  final serverLsit = <Server>[].obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: selectedIndex.value);
    serverLsit.add(Server(name: "Sam", url: "http://172.16.50.4/"));
    serverLsit.add(Server(name: "Sam", url: "http://172.16.50.4/"));
    serverLsit.add(Server(name: "Sam", url: "http://172.16.50.4/"));
    serverLsit.add(Server(name: "Sam", url: "http://172.16.50.4/"));
    serverLsit.add(Server(name: "Sam", url: "http://172.16.50.4/"));
    serverLsit.add(Server(name: "Sam", url: "http://172.16.50.4/"));
    serverLsit.add(Server(name: "Sam", url: "http://172.16.50.4/"));
    serverLsit.add(Server(name: "Sam", url: "http://172.16.50.4/"));
    serverLsit.add(Server(name: "Sam", url: "http://172.16.50.4/"));
    serverLsit.add(Server(name: "Sam", url: "http://172.16.50.4/"));
    serverLsit.add(Server(name: "Sam", url: "http://172.16.50.4/"));
    serverLsit.add(Server(name: "Sam", url: "http://172.16.50.4/"));
    serverLsit.add(Server(name: "Sam", url: "http://172.16.50.4/"));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
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
