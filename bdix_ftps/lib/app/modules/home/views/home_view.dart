import 'package:bdix_ftps/app/modules/home/server_model.dart';
import 'package:bdix_ftps/app/modules/home/views/server_view.dart';
import 'package:flutter/material.dart';

import 'package:super_ui_kit/super_ui_kit.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CSHomeWidget(
      bottomNavigationBar: Obx(
        () => ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
          child: WaterDropNavBar(
            bottomPadding: 20,
            backgroundColor: Get.theme.colorScheme.onBackground,
            waterDropColor: Colors.red,
            onItemSelected: (int index) {
              try {
                controller.selectedIndex.value = index;
                controller.pageController.animateToPage(
                    controller.selectedIndex.value,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutQuad);
              } catch (e) {
                printError(info: "HomeView>>> bottomNavBar ${e.toString()}");
              }
            },
            selectedIndex: controller.selectedIndex.value,
            barItems: <BarItem>[
              BarItem(
                  filledIcon: Icons.web_sharp,
                  outlinedIcon: Icons.web_outlined),
              BarItem(
                  filledIcon: Icons.movie_sharp,
                  outlinedIcon: Icons.movie_outlined),
            ],
          ),
        ),
      ),
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: _AllServers(),
          ),
          Container(
            alignment: Alignment.center,
            child: _MovieServers(),
          ),
        ],
      ),
    );
  }

  _AllServers() => Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: kpHorizontalPadding),
          children: [
            verticalSpaceLarge,
            Padding(
              padding: const EdgeInsets.only(
                  left: kmCardMarginS + kmTextExtraMargin),
              child: CSText.title('BDIX FTP SERVERS'),
            ),
            Obx(
              () => LiveGrid.options(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                options: kAnimationOptions,
                itemBuilder: animationItemBuilder((index) => ServerView(
                    controller.serverLsit[index],
                    onTap: (() =>
                        controller.openServer(controller.serverLsit[index])))),
                itemCount: controller.serverLsit.length,
                gridDelegate: kGridDelegate,
              ),
            )
          ],
        ),
      );

  _MovieServers() => ListView();
}
