import 'package:flutter/material.dart';
import 'package:playflutter/event/UserLoggedInEvent.dart';
import 'package:playflutter/models/RegisterData.dart';
import 'package:playflutter/utils/NetTools.dart';
import 'package:playflutter/utils/SpUtil.dart';
import 'package:playflutter/utils/Toast.dart';

/// 登陆页面
class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginState();
  }
}

class LoginState extends State<Login> {
  // 账号
  TextEditingController accountEdtController = new TextEditingController();

  // 密码
  TextEditingController pwdEdtController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("登陆"),
        centerTitle: true,
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
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      contentPadding: EdgeInsets.all(10)),
                  maxLines: 1,
                  controller: accountEdtController,
                )),
            // 密码
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15,top: 15),
              child: TextField(
                decoration: InputDecoration(
                    hintMaxLines: 1,
                    hintText: "密码",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    contentPadding: EdgeInsets.all(10)),
                obscureText: true,
                maxLines: 1,
                controller: pwdEdtController,
              ),
            ),
            // 登陆
            Padding(
              padding: EdgeInsets.only(top: 25),
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
                onPressed: () => {
                  if (accountEdtController.text.isEmpty ||
                      pwdEdtController.text.isEmpty)
                    {Toast.toast(context, "用户名或密码不能为空")}
                  else
                    {_login(accountEdtController.text, pwdEdtController.text)}
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  ///
  /// 登陆
  ///
  void _login(String account, String password) {
    Map<String, String> params = new Map();
    params["username"] = account;
    params["password"] = password;
    NetTools.post("https://www.wanandroid.com/user/login", (data) {
      RegisterData registerData = RegisterData.fromJson(data);
      if (registerData != null) {
        // 保存登陆的昵称和登陆状态
        SpUtil.setString(SpUtil.NICK_NAME, registerData.data.nickname);
        SpUtil.setBool(SpUtil.LOGIN_STATE, true);
        eventBus.fire(registerData);
        Navigator.pop(context);
      }
    }, params: params, errorCallBack: (msg) {});
  }
}
