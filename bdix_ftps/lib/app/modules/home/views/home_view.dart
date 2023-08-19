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
                filledIcon: Icons.movie_sharp,
                outlinedIcon: Icons.movie_outlined,
              ),
              BarItem(
                filledIcon: Icons.tv_sharp,
                outlinedIcon: Icons.tv_outlined,
              ),
              BarItem(
                filledIcon: Icons.leak_remove_sharp,
                outlinedIcon: Icons.leak_remove_outlined,
              ),
              BarItem(
                filledIcon: Icons.topic_sharp,
                outlinedIcon: Icons.topic_outlined,
              ),
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
            child: _ServerView(),
          ),
          Container(
            alignment: Alignment.center,
            child: _ServerView(),
          ),
          Container(
            alignment: Alignment.center,
            child: _ServerView(),
          ),
          Container(
            alignment: Alignment.center,
            child: _ServerView(),
          ),
        ],
      ),
    );
  }

  Widget _ServerView() => Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: kpHorizontalPadding),
          children: [
            verticalSpaceLarge,
            const Padding(
              padding: EdgeInsets.only(left: kmCardMarginS + kmTextExtraMargin),
              child: CSText.title('BDIX FTP SERVERS'),
            ),
            Obx(
              () => LiveGrid.options(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                options: kAnimationOptions,
                itemBuilder: animationItemBuilder((index) => ServerView(
                    controller.serverList[index],
                    onTap: (() =>
                        controller.openServer(controller.serverList[index])))),
                itemCount: controller.serverList.length,
                gridDelegate: kGridDelegate,
              ),
            )
          ],
        ),
      );

  _MovieServers() => ListView();
}
