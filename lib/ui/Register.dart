import 'package:flutter/material.dart';
import 'package:playflutter/models/RegisterData.dart';
import 'package:playflutter/utils/NetTools.dart';
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

  // 再次输入密码监听
  TextEditingController _pwdConfirmEditingController =
      new TextEditingController();

  /**
   * 注册
   */
  void _register(String name, String password, String rePwd) {
    var params = {
      'username': name,
      'password': password,
      'repassword': rePwd
    };
    NetTools.post("https://www.wanandroid.com/user/register", (data) {
      if(data!=null){
        print(data);
        RegisterData registerData = RegisterData.fromJson(data);
        if(registerData.errorCode == 0){
          // 注册成功
          Toast.toast(context, "注册成功");
          Navigator.pop(context);
        }else
            Toast.toast(context, registerData.errorMsg);
      }
    }, params: params, errorCallBack: (msg) {
          print("异常信息"+msg);
        });
  }


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
                    hintText: "不少于6位的密码",
                    labelText: "密码",
                    prefixIcon: Icon(Icons.lock)),
                obscureText: true,
                maxLines: 1,
                controller: _passwordEditingController,
              ),
            ),
            // 密码
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: TextField(
                decoration: InputDecoration(
                    hintMaxLines: 1,
                    hintText: "不少于6位的密码",
                    labelText: "密码",
                    prefixIcon: Icon(Icons.lock)),
                obscureText: true,
                maxLines: 1,
                controller: _pwdConfirmEditingController,
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
                  if (_userEditingController.text.isEmpty ||
                      _passwordEditingController.text.isEmpty ||
                      _pwdConfirmEditingController.text.isEmpty)
                    {Toast.toast(context, "用户名或密码不能为空")}
                  else
                    {
                      _register(_userEditingController.text,_passwordEditingController.text,_pwdConfirmEditingController.text)
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
