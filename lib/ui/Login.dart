import 'package:flutter/material.dart';

/**
 * 登陆页面
 */
class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginState();
  }
}

class LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("登陆"),
        centerTitle: true,
      ),
      body: new Column(
        children: <Widget>[

        ],
      ),
    );
  }
}
