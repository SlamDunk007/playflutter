import 'package:flutter/material.dart';
import 'package:playflutter/colors/CustomColors.dart';
import 'package:playflutter/ui/Register.dart';

/**
 * 我的页面
 */
class Personal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new PersonalState();
  }
}

class PersonalState extends State<Personal> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "我的",
        ),
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Row(
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Image.asset(
                    "images/sicon_personal_user.png",
                    width: 52,
                  ),
                ),
                new Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: OutlineButton(
                    textColor: Colors.blue[700],
                    child: Text(
                      "注册",
                      style: TextStyle(fontSize: 15),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(
                            color: Colors.blue,
                            style: BorderStyle.solid,
                            width: 2)),
                    onPressed: () => {
                      Navigator.push(context,
                          new MaterialPageRoute(builder: (context) {
                        return new Register();
                      }))
                    },
                  ),
                ),
                new Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: FlatButton(
                    color: Colors.blue,
                    highlightColor: Colors.blue[700],
                    colorBrightness: Brightness.dark,
                    splashColor: Colors.grey,
                    child: Text(
                      "登陆",
                      style: TextStyle(fontSize: 15),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    clipBehavior: Clip.antiAlias,
                    onPressed: () => {},
                  ),
                ),
              ],
            ),
            color: Colors.white70,
          ),
          // 我的收藏
          new Padding(
            padding: EdgeInsets.only(top: 10),
            child: new Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ListTile(
                title: new Text(
                  "文章列表",
                  style:
                      TextStyle(fontSize: 16, color: CustomColors.color_333333),
                ),
                leading: Icon(Icons.collections),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              color: Colors.white70,
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(top: 10),
            child: new Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ListTile(
                title: new Text(
                  "站内文章",
                  style:
                      TextStyle(fontSize: 16, color: CustomColors.color_333333),
                ),
                leading: Icon(Icons.collections),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              color: Colors.white70,
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(top: 10),
            child: new Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ListTile(
                title: new Text(
                  "站外文章",
                  style:
                      TextStyle(fontSize: 16, color: CustomColors.color_333333),
                ),
                leading: Icon(Icons.collections),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              color: Colors.white70,
            ),
          )
        ],
      ),
    );
  }
}
