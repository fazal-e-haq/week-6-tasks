import 'package:flutter/material.dart';
import 'package:users_app/Model/user_model.dart';
import 'package:users_app/Services/api_service.dart';

class UserProvider extends ChangeNotifier {
  final ApiService apiServeice = ApiService();
  List<UserModel> users = [];
  bool isloading = false;
  String? error;
  int page = 1;
  final int limit = 5;
  bool hasMore = true;
  String _search = '';
  List<UserModel> get filter => _search.isEmpty
      ? users
      : users
            .where(
              (element) =>
                  element.name.toLowerCase().contains(_search.toLowerCase()),
            )
            .toList();

  void searching(String value) {
    _search = value;
    notifyListeners();
  }

  Future fetchUsers({bool refresh = false}) async {
    if (isloading) return;
    if (refresh) {
      page = 1;
      users.clear();
      hasMore = true;
      isloading = true;
      error = null;
      notifyListeners();
    }
    try {
      final newUsers = await apiServeice.fetchUsers(page, limit);
      if (newUsers.length < limit) hasMore = false;
      users.addAll(newUsers);
      page++;
    } catch (e) {
      error = e.toString();
    }

    isloading = false;
    notifyListeners();
  }
}
