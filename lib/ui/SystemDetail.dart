import 'package:flutter/material.dart';
import 'package:playflutter/colors/CustomColors.dart';
import 'package:playflutter/models/SystemDetailData.dart';
import 'package:playflutter/ui/NewsWebPage.dart';
import 'package:playflutter/utils/NetTools.dart';

/**
 * 体系列表详情页
 */
class SystemDetail extends StatefulWidget {
  int id;

  SystemDetail(this.id);

  @override
  State<StatefulWidget> createState() {
    return new SystemDetailState(id);
  }
}

class SystemDetailState extends State<SystemDetail> {
  int id;
  List<SystemDetailItem> list = new List();

  SystemDetailState(this.id);

  Widget divider = new Divider(
    color: CustomColors.color_e5e6f2,
    height: 0.33,
  );

  @override
  void initState() {
    super.initState();
    _getSystemDetail();
  }

  /**
   * 获取详情页内容
   */
  void _getSystemDetail() {
    String url =
        "https://www.wanandroid.com/article/list/0/json?cid=" + id.toString();
    NetTools.get(url, (data) {
      SystemDetailData systemDetailData = SystemDetailData.fromJson(data);
      setState(() {
        list = systemDetailData.data.datas;
      });
    }, errorCallBack: (msg) {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("体系详情页"),
      ),
      body: new ListView.separated(
          itemBuilder: (context, index) {
            SystemDetailItem systemDetailItem = list[index];
            return _getListItem(systemDetailItem);
          },
          separatorBuilder: (contxt, index) {
            return divider;
          },
          itemCount: list.length),
    );
  }

  Widget _getListItem(SystemDetailItem systemDetailItem) {
    return new GestureDetector(
      onTap: () {
        Navigator.push(context, new MaterialPageRoute(builder: (context) {
          return new NewsWebPage(systemDetailItem.link, systemDetailItem.title);
        }));
      },
      child: new Padding(
        padding: EdgeInsets.all(16),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              systemDetailItem.title,
              style: TextStyle(fontSize: 15, color: CustomColors.color_131313),
              textAlign: TextAlign.left,
            ),
            new Padding(
              padding: EdgeInsets.only(top: 8),
              child: new Row(
                children: <Widget>[
                  new Expanded(
                    child: new Text(
                      systemDetailItem.chapterName,
                      style: TextStyle(
                          fontSize: 12, color: CustomColors.color_8b8b8b),
                      textAlign: TextAlign.left,
                    ),
                    flex: 1,
                  ),
                  new Expanded(
                    child: new Text(
                      systemDetailItem.niceDate,
                      style: TextStyle(
                          fontSize: 12, color: CustomColors.color_8b8b8b),
                      textAlign: TextAlign.right,
                    ),
                    flex: 1,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
