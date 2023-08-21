import 'package:bdix_ftps/app/modules/home/server_model.dart';
import 'package:flutter/material.dart';

import 'package:super_ui_kit/super_ui_kit.dart';

class ServerView extends GetView {
  final Server server;
  final void Function()? onTap;
  const ServerView(this.server, {Key? key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CSCard(
      children: [
        Expanded(
          flex: 5,
          child: Align(
            alignment: Alignment.center,
            child: CSText.title(server.name ?? ''),
          ),
        ),
        Expanded(
          flex: 2,
          child: CSText.label(
            server.url ?? '',
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: CSButton.outline(
              title: "Open",
              onTap: onTap,
            ),
          ),
        )
      ],
    );
  }
}
