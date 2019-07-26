import 'package:flutter/material.dart';
import 'package:playflutter/colors/CustomColors.dart';
import 'package:playflutter/event/UserLoggedInEvent.dart';
import 'package:playflutter/models/HotKeyData.dart';
import 'package:playflutter/models/SearchData.dart';
import 'package:playflutter/ui/NewsWebPage.dart';
import 'package:playflutter/utils/CustomRoute.dart';
import 'package:playflutter/utils/NetTools.dart';
import 'package:playflutter/widget/BottomItem.dart';

///
/// 搜索
///
class Search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SearchState();
  }
}

class SearchState extends State<Search> {
  List<HotKeyItem> hotKeyList = new List();
  TextEditingController editingController = TextEditingController();
  List<SearchItem> searchList = new List();
  bool visible = false;
  Widget divider = new Divider(
    height: 0.33,
    color: CustomColors.color_2f323a,
  );

  @override
  void initState() {
    super.initState();
    _getHotKey();
    _setEditingControllerListener();
  }

  /// 监听编辑款的文案变化
  void _setEditingControllerListener() {
    editingController.addListener(() {
      String editText = editingController.text;
      if (editText.isNotEmpty) {
        Map<String, String> params = new Map();
        params["k"] = editText;
        NetTools.post("https://www.wanandroid.com/article/query/0/json",
            (data) {
          SearchData searchData = SearchData.fromJson(data);
          if (searchData != null) {
            setState(() {
              searchList = searchData.data.datas;
              visible = true;
            });
          }
        }, params: params, errorCallBack: (msg) {});
      } else {
        setState(() {
          searchList.clear();
          visible = false;
        });
      }
    });
  }

  /// 获取搜索热词
  void _getHotKey() {
    NetTools.get("https://www.wanandroid.com//hotkey/json", (data) {
      HotKeyData hotKeyData = HotKeyData.fromJson(data);
      if (hotKeyData != null) {
        setState(() {
          hotKeyList = hotKeyData.data;
        });
      }
    }, errorCallBack: (msg) {});
  }

  @override
  Widget build(BuildContext context) {
    eventBus.on<String>().listen((event) {
      setState(() {
        editingController.text = event;
      });
    });

    return new Scaffold(
      backgroundColor: CustomColors.color_1a1b1d,
      body: new SafeArea(
          top: true,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.only(left: 10, top: 8),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      flex: 5,
                      child: ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 31),
                          child: new Container(
                            color: CustomColors.color_242730,
                            child: new TextField(
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: CustomColors.color_9a9ead),
                              decoration: new InputDecoration(
                                hintText: "搜索文章关键词",
                                hintStyle: TextStyle(
                                    color: CustomColors.color_525662,
                                    fontSize: 13),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: CustomColors.color_9a9ead,
                                ),
                                border: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                              ),
                              controller: editingController,
                              autofocus: true,
                            ),
                          )),
                    ),
                    new Expanded(
                        child: new Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: new GestureDetector(
                        child: Text(
                          "取消",
                          style: TextStyle(
                              color: CustomColors.color_9a9ead, fontSize: 13),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ))
                  ],
                ),
              ),
              Offstage(
                offstage: visible,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Padding(
                      padding: EdgeInsets.only(bottom: 20, left: 10, top: 23),
                      child: Text(
                        "大家都在搜",
                        style: TextStyle(
                            color: CustomColors.color_808595, fontSize: 14),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    _buildHotKeyItem(),
                  ],
                ),
              ),
              new Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        SearchItem searchItem = searchList[index];
                        return buildSearchItem(searchItem);
                      },
                      separatorBuilder: (context, index) {
                        return divider;
                      },
                      itemCount: searchList.length))
            ],
          )),
    );
  }

  /// 构建搜索列表的item
  Widget buildSearchItem(SearchItem searchItem) {
    return new GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 14),
            child: Text(
              searchItem.chapterName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: CustomColors.color_9a9ead, fontSize: 16),
            ),
          ),
          new Row(
            children: <Widget>[
              new Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 14, bottom: 14),
                child: Text(
                  searchItem.author,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(color: CustomColors.color_9a9ead, fontSize: 11),
                ),
              ),
              new Padding(
                padding: EdgeInsets.only(left: 10, top: 14, bottom: 14),
                child: Text(
                  searchItem.niceDate,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(color: CustomColors.color_9a9ead, fontSize: 11),
                ),
              ),
            ],
          )
        ],
      ),
      onTap: () {
        Navigator.of(context).push(CustomRoute(
            new NewsWebPage(searchItem.link, searchItem.chapterName)));
      },
    );
  }

  /// 大家都在搜的热词
  Widget _buildHotKeyItem() {
    return Padding(
      child: Wrap(
        children: _generateList(),
        spacing: 10,
        runSpacing: 5,
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.end,
      ),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
    );
  }

  List<Widget> _generateList() {
    return hotKeyList.map((item) => ButtonItem(hotKeyItem: item)).toList();
  }
}
