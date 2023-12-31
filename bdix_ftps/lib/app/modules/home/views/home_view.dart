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
            backgroundColor: Get.theme.colorScheme.secondary,
            waterDropColor: Colors.white,
            onItemSelected: (int index) {
              try {
                controller.serverList.value = [];
                // Get.showLoader();
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
                filledIcon: Icons.topic_sharp,
                outlinedIcon: Icons.topic_outlined,
              ),
              BarItem(
                filledIcon: Icons.swap_horizontal_circle_sharp,
                outlinedIcon: Icons.swap_horizontal_circle_outlined,
              ),
            ],
          ),
        ),
      ),
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        onPageChanged: (value) => controller.pageChanged(value),
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
          padding: EdgeInsets.symmetric(
              horizontal: Get.width > 1024
                  ? 120
                  : Get.width > 768
                      ? 60
                      : Get.width > 425
                          ? 30
                          : kpHorizontalPadding),
          children: [
            verticalSpaceLarge,
            Padding(
              padding: const EdgeInsets.only(
                  left: kmCardMarginS + kmTextExtraMargin),
              child: Obx(
                () => CSText.title(controller.title.value),
              ),
            ),
            Obx(
              () => controller.serverList.isNotEmpty
                  ? LiveGrid.options(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      options: const LiveOptions(
                        showItemInterval: Duration.zero,
                        showItemDuration: Duration(milliseconds: 100),
                        visibleFraction: 0.05,
                        reAnimateOnVisibility: false,
                      ),
                      itemBuilder: animationItemBuilder((index) => ServerView(
                          controller.serverList[index],
                          onTap: (() => controller
                              .openServer(controller.serverList[index])))),
                      itemCount: controller.serverList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Get.width ~/ 250,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        childAspectRatio: 1,
                      ),
                    )
                  : const Center(child: CircularProgressIndicator()),
            )
          ],
        ),
      );

  _MovieServers() => ListView();
}
