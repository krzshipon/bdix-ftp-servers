import 'package:bdix_ftps/app/modules/home/server_model.dart';
import 'package:flutter/material.dart';

import 'package:super_ui_kit/super_ui_kit.dart';

class ServerView extends GetView {
  final Server server;
  void Function()? onTap;
  ServerView(this.server, {Key? key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CSCard(children: [
      verticalSpaceMedium,
      CSText(server.name ?? ''),
      CSText('URL: ${server.url}'),
      CSButton.outline(
        title: "Open",
        onTap: onTap,
      )
    ]);
  }
}
