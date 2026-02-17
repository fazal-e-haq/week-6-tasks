class UserModel {
  int id;

  String title;
  String body;

  UserModel({required this.id, required this.title, required this.body});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'], title: json['title'], body: json['body']);
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'body': body};
  }
}
