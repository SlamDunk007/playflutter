import 'package:flutter/material.dart';
///
/// 搜索
///
class Search extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new SearchState();
  }
}

class SearchState extends State<Search>{
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Text("搜索"),
    );
  }

}