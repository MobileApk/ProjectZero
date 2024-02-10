class LoginModel {
  Result? result;

  LoginModel({this.result});

  LoginModel.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
}

class Result {
  String? id;
  String? username;
  String? token;

  Result({this.id, this.username, this.token});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    token = json['token'];
  }
}
