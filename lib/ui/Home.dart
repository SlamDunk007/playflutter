import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:playflutter/colors/CustomColors.dart';
import 'package:playflutter/models/HomeData.dart';
import 'package:playflutter/ui/NewsWebPage.dart';
import 'package:playflutter/utils/NetTools.dart';

/**
 * 首页
 */
class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  List lists = <Datas>[];
  List bannerLists = <String>[];
  int page = 0;
  ScrollController _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print("Home----------initState");
    _getBannerList();
    _getHomePageList(page, false);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("滑动中");
        page++;
        _getHomePageList(page, true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /**
   * 获取轮播图列表
   */
  void _getBannerList() {
    bannerLists.add(
        "https://wanandroid.com/blogimgs/fbed8f14-1043-4a43-a7ee-0651996f7c49.jpeg");
    bannerLists.add(
        "https://www.wanandroid.com/blogimgs/50c115c2-cf6c-4802-aa7b-a4334de444cd.png");
    bannerLists.add(
        "https://www.wanandroid.com/blogimgs/ab17e8f9-6b79-450b-8079-0f2287eb6f0f.png");
    bannerLists.add(
        "https://www.wanandroid.com/blogimgs/fb0ea461-e00a-482b-814f-4faca5761427.png");
    bannerLists.add(
        "https://www.wanandroid.com/blogimgs/62c1bd68-b5f3-4a3c-a649-7ca8c7dfabe6.png");
    bannerLists.add(
        "https://www.wanandroid.com/blogimgs/00f83f1d-3c50-439f-b705-54a49fc3d90d.jpg");
  }

  /**
   * 获取列表数据
   */
  void _getHomePageList(int page, bool isLoadMore) {
    NetTools.get(
        "https://www.wanandroid.com/article/list/" + page.toString() + "/json",
        (data) {
      HomeData homePageData = HomeData.fromJson(data);
      setState(() {
        if (page == 0 && !isLoadMore) {
          lists.clear();
        }
        lists.addAll(homePageData.data.datas);
      });
    }, errorCallBack: (msg) {
      print("错误信息：" + msg);
    });
  }

  /**
   * 下拉刷新
   */
  Future<Null> _onRefreshHomePage() async {
    page = 0;
    _getHomePageList(page, false);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Widget divider = new Divider(
      color: CustomColors.color_e5e6f2,
      height: 0.33,
    );
    return new RefreshIndicator(
      child: new ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            // 轮播图
            return _swiperHeader(context);
          } else if (index == lists.length + 1) {
            // 上拉加载的菊花
            return _buildProgressIndicator();
          } else {
            Datas datasItem = lists[index - 1];
            return _getListViewItem(datasItem);
          }
        },
        itemCount: lists.length + 2,
        physics: const AlwaysScrollableScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) {
          return divider;
        },
        controller: _scrollController,
      ),
      onRefresh: _onRefreshHomePage,
    );
  }

  /**
   * 创建listView的item
   */
  Widget _getListViewItem(Datas datasItem) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 7, 10, 7),
        child: new GestureDetector(
          onTap: () {
            Navigator.push(context, new MaterialPageRoute(builder: (context) {
              return new NewsWebPage(datasItem.link, datasItem.title);
            }));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.only(bottom: 22),
                child: new Text(
                  datasItem.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: new TextStyle(
                      color: CustomColors.color_333333, fontSize: 16),
                ),
              ),
              new Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Expanded(
                    flex: 1,
                    child: Text(
                      "日期：" + datasItem.niceDate,
                      style: new TextStyle(
                          color: CustomColors.color_9a9ead, fontSize: 11),
                    ),
                  ),
                  new Expanded(
                    flex: 1,
                    child: Text(
                      "作者：" + datasItem.author,
                      style: new TextStyle(
                          color: CustomColors.color_9a9ead, fontSize: 11),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  new Expanded(
                    flex: 1,
                    child: new Image(
                      image: new AssetImage("images/sicon_create.png"),
                      width: 31,
                      height: 15,
                    ),
                  )
                ],
              )
            ],
          ),
        ));
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

  /**
   * 顶部轮播图
   */
  Widget _swiperHeader(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Swiper(
        itemCount: bannerLists.length,
        itemBuilder: (context, index) {
          return Image.network(
            bannerLists[index],
            fit: BoxFit.fill,
          );
        },
        autoplay: false,
        pagination: new SwiperPagination(
            builder: DotSwiperPaginationBuilder(
          color: Colors.black54,
          activeColor: Colors.white,
        )),
      ),
    );
  }
}
