import 'package:flutter/material.dart';
import 'package:playflutter/colors/CustomColors.dart';

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
                  child: FlatButton(
                    color: Colors.blue,
                    highlightColor: Colors.blue[700],
                    colorBrightness: Brightness.dark,
                    splashColor: Colors.grey,
                    child: Text("登陆"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    onPressed: () => {},
                  ),
                ),
              ],
            ),
            color: Colors.white70,
          ),
          // 我的收藏
          new Padding(
            padding: EdgeInsets.only(top: 15),
            child: new Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ListTile(
                title: new Text(
                  "收藏文章列表",
                  style:
                      TextStyle(fontSize: 20, color: CustomColors.color_333333),
                ),
                leading: Icon(Icons.collections),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              color: Colors.white70,
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(top: 15),
            child: new Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ListTile(
                title: new Text(
                  "收藏站内文章",
                  style:
                      TextStyle(fontSize: 20, color: CustomColors.color_333333),
                ),
                leading: Icon(Icons.collections),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
              color: Colors.white70,
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(top: 15),
            child: new Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ListTile(
                title: new Text(
                  "收藏站外文章",
                  style:
                      TextStyle(fontSize: 20, color: CustomColors.color_333333),
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
