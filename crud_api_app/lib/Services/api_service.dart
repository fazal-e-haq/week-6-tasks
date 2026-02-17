import 'dart:convert';
import 'package:crud_api_app/Models/post_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String _url = "https://jsonplaceholder.typicode.com/posts";
  // CREATE NEW POST
  Future<UserModel> postRequest(UserModel userpost) async {
    final responce = await http.post(
      Uri.parse(_url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userpost.toJson()),
    );
    if (responce.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(responce.body));
    } else {
      throw Exception('Created field');
    }
  }

  // DELETE DATA BY ID
  Future<void> deleteRequest(int id) async {
    final responce = await http.delete(
      Uri.parse('$_url/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    if (responce.statusCode != 200) {
      throw Exception('Filed to deleted');
    }
  }

  // UPDATE DATA NY ID
  Future<UserModel> putRequest(UserModel user, int id) async {
    final responce = await http.put(
      Uri.parse('$_url/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
    if (responce.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(responce.body));
    } else {
      throw Exception('Updated Field');
    }
  }

  // GETTING ALL DATA IN THIS API
  Future<List<UserModel>> fetchData() async {
    final responce = await http.get(Uri.parse(_url));

    if (responce.statusCode == 200) {
      List<dynamic> data = jsonDecode(responce.body);
      return data.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception('Field to load');
    }
  }
}
