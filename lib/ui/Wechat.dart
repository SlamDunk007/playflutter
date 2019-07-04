import 'package:flutter/material.dart';
import 'package:playflutter/colors/CustomColors.dart';

class WechatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new WechatPageState();
  }
}

class WechatPageState extends State<WechatPage> {
  List<String> titleList = new List();
  Widget divider = new Divider(
    height: 0.33,
    color: CustomColors.color_e5e6f2,
  );

  @override
  void initState() {
    super.initState();
    titleList.add("文章");
    titleList.add("内容");
    titleList.add("竞品");
    titleList.add("文章");
    titleList.add("内容");
    titleList.add("竞品");
    titleList.add("文章");
    titleList.add("内容");
    titleList.add("竞品");
    titleList.add("文章");
    titleList.add("内容");
    titleList.add("竞品");
    titleList.add("文章");
    titleList.add("内容");
    titleList.add("竞品");
    titleList.add("文章");
    titleList.add("内容");
    titleList.add("竞品");
    titleList.add("文章");
    titleList.add("内容");
    titleList.add("竞品");
    titleList.add("文章");
    titleList.add("内容");
    titleList.add("竞品");
    titleList.add("文章");
    titleList.add("内容");
    titleList.add("竞品");
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
          flex: 1,
          child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: new Text(
                    titleList[index],
                    style: TextStyle(color: CustomColors.color_131313),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return divider;
              },
              itemCount: titleList.length),
        ),
        new Container(
          width: 0.33,
          color: CustomColors.color_e5e6f2,
        ),
        new Expanded(
          flex: 2,
          child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: new Text(titleList[index]),
                );
              },
              separatorBuilder: (context, index) {
                return divider;
              },
              itemCount: titleList.length),
        )
      ],
    );
  }
}
