import 'package:crud_api_app/Models/post_model.dart';
import 'package:flutter/material.dart';

import '../Services/api_service.dart';

class PostFormScreen extends StatefulWidget {
  const PostFormScreen({super.key, this.post});
  final UserModel? post;
  @override
  State<PostFormScreen> createState() => _PostFormScreenState();
}

class _PostFormScreenState extends State<PostFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final ApiService api = ApiService();

  @override
  void initState() {
    super.initState();
    if (widget.post != null) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _bodyController.dispose();
  }

  void submit() async {
    if (!_formKey.currentState!.validate()) return;

    final userModel = UserModel(
      id: widget.post?.id ?? 0,
      title: _titleController.text,
      body: _bodyController.text,
    );
    try {
      if (widget.post == null) {
        await api.postRequest(userModel);
        showSnack('Post Created');
      } else {
        await api.putRequest(userModel, widget.post!.id);
        showSnack('Post Updated');
      }
      Navigator.pop(context);
    } catch (e) {
      showSnack('Operation Field');
    }
  }

  void showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post == null ? 'Add Post' : 'Edit Post'),
      ),
      body: SafeArea(
        child: Padding(
          padding: .symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                  decoration: InputDecoration(
                    label: Text('Title'),
                    border: OutlineInputBorder(borderRadius: .circular(12)),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _bodyController,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                  decoration: InputDecoration(
                    label: Text('Body'),
                    border: OutlineInputBorder(borderRadius: .circular(12)),
                  ),
                ),
                SizedBox(height: 100),
                ElevatedButton(onPressed: submit, child: Text('S u b m i t')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
