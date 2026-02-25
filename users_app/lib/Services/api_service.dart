import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Model/user_model.dart';

class ApiService {
  final String _url = 'https://jsonplaceholder.typicode.com/users';

  Future<List<UserModel>> fetchUsers(int page, int limit) async {
    final responce = await http.get(
      Uri.parse('$_url?_page=$page&_limit=$limit'),
    );

    if (responce.statusCode == 200) {
      List allUsers = jsonDecode(responce.body);
      return allUsers.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception('Field to Load');
    }
  }
}
