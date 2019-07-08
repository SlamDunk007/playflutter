import 'package:flutter/material.dart';
import 'package:playflutter/ui/Home.dart';
import 'package:playflutter/ui/Personal.dart';
import 'package:playflutter/ui/System.dart';
import 'package:playflutter/ui/Wechat.dart';

void main() => runApp(MyApp());

/**
 * 首页
 */
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(homeTitle: 'Play Flutter'),
    );
  }
}

/**
 * 首页（包括玩android的首页、项目、公众号）
 */
class HomePage extends StatefulWidget {
  String homeTitle;

  HomePage({Key key, this.homeTitle}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int currentIndex = 0;

  // 定义PageController用于切换不同的界面
  final PageController _pageController =
      new PageController(initialPage: 0, viewportFraction: 1);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: new Scaffold(
          body: PageView(
            controller: _pageController,
            children: <Widget>[
              // 首页
              new Home(),
              // 体系
              new SystemPage(),
              // 公众号
              new WechatPage(),
              // 个人中心
              new Personal()
            ],
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          // 底部导航栏
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text("首页"),
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  title: Text("体系"),
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.phone_android),
                  title: Text("公众号"),
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text("我的"),
                  backgroundColor: Colors.blue)
            ],
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            fixedColor: Colors.blue,
            onTap: _onBottomTab,
          ),
        ),
        onWillPop: _doubleExit);
  }

  int _lastClickTime = 0;

  Future<bool> _doubleExit() {
    int nowTime = new DateTime.now().microsecondsSinceEpoch;
    if (_lastClickTime != 0 && nowTime - _lastClickTime > 1500) {
      return new Future.value(true);
    } else {
      _lastClickTime = new DateTime.now().microsecondsSinceEpoch;
      new Future.delayed(const Duration(milliseconds: 1500), () {
        _lastClickTime = 0;
      });
    }
    return new Future.value(false);
  }

  /**
   * 当底部tab被点击的时候
   */
  void _onBottomTab(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    setState(() {
      currentIndex = index;
    });
  }
}
