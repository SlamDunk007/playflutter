import 'package:flutter/material.dart';
import 'package:playflutter/colors/CustomColors.dart';
import 'package:playflutter/models/SystemData.dart';
import 'package:playflutter/ui/SystemDetail.dart';
import 'package:playflutter/utils/NetTools.dart';

/**
 * 体系
 */
class SystemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SystemPageState();
  }
}

class SystemPageState extends State<SystemPage>
    with AutomaticKeepAliveClientMixin {
  List<Data> systemList = new List();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print("System----------initState");
    NetTools.get("https://www.wanandroid.com/tree/json", (data) {
      SystemData systemData = SystemData.fromJson(data);
      for (int i = 0; i < systemData.data.length; i++) {
        systemData.data[i].isExpanded = false;
      }
      setState(() {
        if (systemData != null) {
          systemList = systemData.data;
        }
      });
    }, errorCallBack: (msg) {});
  }

  @override
  Widget build(BuildContext context) {
    Widget divider = new Divider(
      color: CustomColors.color_e5e6f2,
      height: 0.33,
    );
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text("体系"),
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (int index, bool open) {
            setState(() {
              systemList[index].isExpanded = !open;
            });
          },
          children: systemList.map((Data data) {
            return ExpansionPanel(
                headerBuilder: (context, bol) {
                  return _getHeaderItem(data);
                },
                body: new Container(
                  height: 200,
                  child: new ListView.separated(
                    itemCount: data.children.length,
                    itemBuilder: (context, index) {
                      return _getRowItem(data.children[index]);
                    },
                    separatorBuilder: (context, index) {
                      return divider;
                    },
                  ),
                ),
                isExpanded: data.isExpanded);
          }).toList(),
        ),
      ),
    );
  }

  /**
   * 收缩面板每一条的Header Item
   */
  Widget _getHeaderItem(Data data) {
    return new Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        data.name,
        style: new TextStyle(
            color: data.isExpanded
                ? CustomColors.color_508cee
                : CustomColors.color_131313,
            fontSize: 18),
      ),
    );
  }

  /**
   * 收缩面板更多内容的Item
   */
  Widget _getRowItem(Children children) {
    return new GestureDetector(
      child: new Padding(
        padding: EdgeInsets.fromLTRB(30, 16, 30, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              children.name,
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context, new MaterialPageRoute(builder: (context) {
          return SystemDetail(children.id);
        }));
      },
    );
  }
}
