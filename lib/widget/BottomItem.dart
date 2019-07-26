import 'package:flutter/material.dart';
import 'package:playflutter/colors/CustomColors.dart';
import 'package:playflutter/event/UserLoggedInEvent.dart';
import 'package:playflutter/models/HotKeyData.dart';
import 'package:playflutter/ui/NewsWebPage.dart';
import 'package:playflutter/utils/CustomRoute.dart';

class ButtonItem extends StatelessWidget {
  ButtonItem({
    Key key,
    @required this.hotKeyItem,
  }) : super(key: key);

  final HotKeyItem hotKeyItem;

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      child: Text(
        this.hotKeyItem.name,
        style: TextStyle(color: CustomColors.color_9a9ead, fontSize: 13),
      ),
      borderSide: BorderSide(color: CustomColors.color_9a9ead, width: 0.33),
      onPressed: () {
        eventBus.fire(hotKeyItem.name);
      },
    );
  }
}
