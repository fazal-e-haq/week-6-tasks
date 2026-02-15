import 'dart:convert';
import 'package:api_basics_app/Model/post_model.dart';
import 'package:http/http.dart' as http;

class PostService {
  final String _url = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<PostModel>> fetchData() async {
    final responce = await http.get(Uri.parse(_url));

    if (responce.statusCode == 200) {
      List<dynamic> data = jsonDecode(responce.body);
      return data.map((e) => PostModel.fromJson(e)).toList();
    } else {
      throw Exception('Field to load');
    }
  }
}
