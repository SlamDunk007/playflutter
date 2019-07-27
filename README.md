# playflutter

一款基于wanandroid.com网站接口实现的Flutter练习项目，项目会持续优化和丰富，欢迎star!!!!!!!!!!

## 注意事项
1.打Release包的时候，发现无法访问网络，在app/src/profile下面的清单文件中已经有网络权限，但是在profile同级的目录main中的清单文件也要加上网络权限，然后重新打包即可通过。
2.不知道如何打Release包，可以参考这篇文章[Flutter打包流程](https://www.jianshu.com/p/f00d8722203c)
- [安卓Apk体验下载地址](https://github.com/KM-BUG/playflutter/blob/master/android/app-release.apk)

## App截图
<image src="https://github.com/KM-BUG/playflutter/raw/master/images/home.png" width="250">   <image src="https://github.com/KM-BUG/playflutter/raw/master/images/wechat.png" width="250">   <image src="https://github.com/KM-BUG/playflutter/raw/master/images/personal.png" width="250">   <image src="https://github.com/KM-BUG/playflutter/raw/master/images/search.png" width="250">   <image src="https://github.com/KM-BUG/playflutter/raw/master/images/detail.png" width="250">
## 项目用的的知识点
1.首页轮播图使用的是Swiper（flutter_swiper: ^1.1.6），这个Widget真是特别的强大，各种样式都有，基本满足日常需要，而且使用简单。
2.项目中带分割线的列表基本都使用ListView.separated（带分割线的ListView）.
3.正文页使用的WebView（flutter_webview_plugin: ^0.3.5）。
4.搜索页面使用的TextField,Wrap组成的流式布局已经ListView展示的搜索列表结果。
5.公众号部分使用的是Row嵌套两个ListView的结构。
6.体系使用的是ExpansionPanelList，不熟悉的可以自行查阅。
7.网络框架使用的是dio
8.其余简单的Widget（button,Text,Padding,Expanded,Icon,Column,Row,Container等不具体的介绍，详细可参考底部文档学习Flutter基础内容）。

## 感受
这个项目是基于wanandroid开放的接口进行开发的，感谢鸿洋大神为开源社区所做的贡献！！！
Flutter对于有Java或者js基础的可能更容易上手一些，当然语言的本质都是互通的，有过开发经验当然可以很轻松就入手Flutter。
Flutter使用代码来组建布局，这不同于Android的XML，使用代码写布局，会出现很深的嵌套，这就需要我们对一些常用Widget进行封装抽取，写布局之前一定要想好基本样式。
本项目纯粹个人学习Flutter使用，欢迎大家沟通交流！！！

## 参考资料
1.[Flutter基础](https://book.flutterchina.club/chapter1/dart.html)
2.[Dart语言简介和Flutter基础](https://guoshuyu.cn/home/wx/Flutter-1.html)
3.[Dart基础](https://www.jianshu.com/p/3d927a7bf020?tdsourcetag=s_pcqq_aiomsg)
4.[Dio使用介绍](https://www.jianshu.com/p/e010041f0ec0/)
5.[好用的JSON to Dart工具](https://javiercbk.github.io/json_to_dart/)

