import 'package:flutter/material.dart';
import 'package:playflutter/colors/CustomColors.dart';
import 'package:playflutter/models/AuthorContentData.dart';
import 'package:playflutter/models/AuthorData.dart';
import 'package:playflutter/ui/NewsWebPage.dart';
import 'package:playflutter/utils/NetTools.dart';

class WechatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new WechatPageState();
  }
}

class WechatPageState extends State<WechatPage> {
  /**
   * 作者列表
   */
  List<AuthorItem> authorList = new List();

  /**
   * 文章列表的初始页码
   */
  int page = 1;

  /**
   * 当前选中的作者id
   */
  int currentId = 408;

  /**
   * 作者文章列表
   */
  List<AuthorContentItem> authorContentList = new List();
  Widget divider = new Divider(
    height: 0.33,
    color: CustomColors.color_e5e6f2,
  );

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _getAuthor();
    _getAuthorContent(currentId, page);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        page++;
        _getAuthorContent(currentId, page);
      }
    });
  }

  /**
   * 获取作者
   */
  void _getAuthor() {
    NetTools.get("https://wanandroid.com/wxarticle/chapters/json", (data) {
      AuthorData authorData = AuthorData.fromJson(data);
      if (authorData != null) {
        setState(() {
          authorList = authorData.data;
        });
      }
    }, errorCallBack: (msg) {});
  }

  /**
   * 获取相应作者的文章
   */
  void _getAuthorContent(int chapterId, int page) {
    NetTools.get(
        "https://wanandroid.com/wxarticle/list/" +
            chapterId.toString() +
            "/" +
            page.toString() +
            "/json", (data) {
      AuthorContentData authorContentData = AuthorContentData.fromJson(data);
      setState(() {
        if (page == 1) {
          authorContentList.clear();
        }
        authorContentList.addAll(authorContentData.data.datas);
      });
    }, errorCallBack: (msg) {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text("公众号",),
      ),
      body: new Row(
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  AuthorItem authorItem = authorList[index];
                  return _getAuthorLayout(authorItem);
                },
                separatorBuilder: (context, index) {
                  return divider;
                },
                itemCount: authorList.length),
          ),
          new Container(
            width: 0.33,
            color: CustomColors.color_e5e6f2,
          ),
          new Expanded(
            flex: 2,
            child: ListView.separated(
              itemBuilder: (context, index) {
                if (index == authorContentList.length) {
                  return _buildProgressIndicator();
                } else {
                  AuthorContentItem authorContentItem =
                      authorContentList[index];
                  return _getAuthorContentLayout(authorContentItem);
                }
              },
              separatorBuilder: (context, index) {
                return divider;
              },
              itemCount: authorContentList.length + 1,
              controller: _scrollController,
            ),
          )
        ],
      ),
    );
  }

  /**
   * 获取作者布局
   */
  Widget _getAuthorLayout(AuthorItem authorItem) {
    return new GestureDetector(
      onTap: () {
        currentId = authorItem.id;
        page = 1;
        _getAuthorContent(authorItem.id, page);
      },
      child: ListTile(
        title: new Text(
          authorItem.name,
          style: TextStyle(color: CustomColors.color_131313,fontSize: 18),
        ),
      ),
    );
  }

  /**
   * 获取作者文章列表布局
   */
  Widget _getAuthorContentLayout(AuthorContentItem authorContentItem) {
    return new GestureDetector(
      onTap: () {
        Navigator.push(context, new MaterialPageRoute(builder: (context) {
          return new NewsWebPage(
              authorContentItem.link, authorContentItem.title);
        }));
      },
      child: ListTile(
        title: new Text(authorContentItem.title),
      ),
    );
  }

  /**
   * 加载更多的菊花
   */
  Widget _buildProgressIndicator() {
    return new Container(
      padding: EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: new SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }
}
