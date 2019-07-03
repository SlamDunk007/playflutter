class BannerData {
  List<BannerItem> _data;
  int _errorCode;
  String _errorMsg;

  BannerData({List<BannerItem> data, int errorCode, String errorMsg}) {
    this._data = data;
    this._errorCode = errorCode;
    this._errorMsg = errorMsg;
  }

  List<BannerItem> get data => _data;

  set data(List<BannerItem> data) => _data = data;

  int get errorCode => _errorCode;

  set errorCode(int errorCode) => _errorCode = errorCode;

  String get errorMsg => _errorMsg;

  set errorMsg(String errorMsg) => _errorMsg = errorMsg;

  BannerData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      var list = json['data'] as List;
      _data = list.map((i)=>BannerItem.fromJson(i)).toList();
    }
    _errorCode = json['errorCode'];
    _errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data.map((v) => v.toJson()).toList();
    }
    data['errorCode'] = this._errorCode;
    data['errorMsg'] = this._errorMsg;
    return data;
  }
}

class BannerItem {
  String _desc;
  int _id;
  String _imagePath;
  int _isVisible;
  int _order;
  String _title;
  int _type;
  String _url;

  BannerItem(
      {String desc,
      int id,
      String imagePath,
      int isVisible,
      int order,
      String title,
      int type,
      String url}) {
    this._desc = desc;
    this._id = id;
    this._imagePath = imagePath;
    this._isVisible = isVisible;
    this._order = order;
    this._title = title;
    this._type = type;
    this._url = url;
  }

  String get desc => _desc;

  set desc(String desc) => _desc = desc;

  int get id => _id;

  set id(int id) => _id = id;

  String get imagePath => _imagePath;

  set imagePath(String imagePath) => _imagePath = imagePath;

  int get isVisible => _isVisible;

  set isVisible(int isVisible) => _isVisible = isVisible;

  int get order => _order;

  set order(int order) => _order = order;

  String get title => _title;

  set title(String title) => _title = title;

  int get type => _type;

  set type(int type) => _type = type;

  String get url => _url;

  set url(String url) => _url = url;

  BannerItem.fromJson(Map<String, dynamic> json) {
    _desc = json['desc'];
    _id = json['id'];
    _imagePath = json['imagePath'];
    _isVisible = json['isVisible'];
    _order = json['order'];
    _title = json['title'];
    _type = json['type'];
    _url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desc'] = this._desc;
    data['id'] = this._id;
    data['imagePath'] = this._imagePath;
    data['isVisible'] = this._isVisible;
    data['order'] = this._order;
    data['title'] = this._title;
    data['type'] = this._type;
    data['url'] = this._url;
    return data;
  }
}
