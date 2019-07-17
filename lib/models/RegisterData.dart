class RegisterData {
  Data data;
  int errorCode;
  String errorMsg;

  RegisterData({this.data, this.errorCode, this.errorMsg});

  RegisterData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }
}

class Data {
  bool admin;
  String email;
  String icon;
  int id;
  String nickname;
  String password;
  String token;
  int type;
  String username;

  Data(
      {this.admin,
        this.email,
        this.icon,
        this.id,
        this.nickname,
        this.password,
        this.token,
        this.type,
        this.username});

  Data.fromJson(Map<String, dynamic> json) {
    admin = json['admin'];
    email = json['email'];
    icon = json['icon'];
    id = json['id'];
    nickname = json['nickname'];
    password = json['password'];
    token = json['token'];
    type = json['type'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admin'] = this.admin;
    data['email'] = this.email;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['nickname'] = this.nickname;
    data['password'] = this.password;
    data['token'] = this.token;
    data['type'] = this.type;
    data['username'] = this.username;
    return data;
  }
}