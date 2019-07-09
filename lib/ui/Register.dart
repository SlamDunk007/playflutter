import 'package:flutter/material.dart';
import 'package:playflutter/colors/CustomColors.dart';
import 'package:playflutter/utils/Toast.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RegisterState();
  }
}

class RegisterState extends State<Register> {
  // 用户名监听
  TextEditingController _userEditingController = new TextEditingController();

  // 密码监听
  TextEditingController _passwordEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "注册",
        ),
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            // 用户名
            Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 40),
                child: TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      hintMaxLines: 1,
                      hintText: "用户名或邮箱",
                      labelText: "用户名",
                      prefixIcon: Icon(Icons.person)),
                  maxLines: 1,
                  controller: _userEditingController,
                )),
            // 密码
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                decoration: InputDecoration(
                    hintMaxLines: 1,
                    hintText: "密码",
                    labelText: "密码",
                    prefixIcon: Icon(Icons.lock)),
                obscureText: true,
                maxLines: 1,
                controller: _passwordEditingController,
              ),
            ),
            // 注册
            Padding(
              padding: EdgeInsets.only(top: 25),
              child: FlatButton(
                color: Colors.blue,
                highlightColor: Colors.blue[700],
                colorBrightness: Brightness.dark,
                splashColor: Colors.grey,
                child: Text(
                  "注册",
                  style: TextStyle(fontSize: 15),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                clipBehavior: Clip.antiAlias,
                onPressed: () => {
                  if(_userEditingController.text.isEmpty || _passwordEditingController.text.isEmpty){
                    Toast.toast(context, "用户名或密码不能为空")
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
