import 'package:flutter/material.dart';
import 'package:playflutter/ui/Home.dart';
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
  final PageController _pageController = new PageController(initialPage: 0);

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
              new WechatPage()
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
                  icon: Icon(Icons.home), title: Text("首页")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.school), title: Text("体系")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.phone_android), title: Text("公众号"))
            ],
            currentIndex: currentIndex,
            onTap: _onBottomTab,
          ),
        ),
        onWillPop: _onWillPop);
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
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
