import 'package:bdix_ftps/app/modules/home/providers/server_provider.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ServerProvider>(
      () => ServerProvider(),
    );
  }
}
