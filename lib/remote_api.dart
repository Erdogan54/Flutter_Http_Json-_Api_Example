import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'model/user_model.dart';

class RemoteApi extends StatefulWidget {
  const RemoteApi({Key? key}) : super(key: key);

  @override
  State<RemoteApi> createState() => _RemoteApiState();
}

class _RemoteApiState extends State<RemoteApi> {
  late final Future<List<UserModel>> _initUsers;

  @override
  void initState() {
    super.initState();
    _initUsers = _getUserList();
  }

  Future<List<UserModel>> _getUserList() async {
    try {
      var response =
          await Dio().get("https://jsonplaceholder.typicode.com/users");
      List<UserModel> _userList = [];
      if (response.statusCode == 200) {
        print(response.data.toString());

        _userList =
            (response.data as List).map((e) => UserModel.fromMap(e)).toList();
      }
      return _userList;
    } on DioError catch (e) {
      return Future.error(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Remote Api"),
        ),
        body: FutureBuilder<List<UserModel>>(
          future: _initUsers,
          builder: (context, snapshat) {
            if (snapshat.hasData) {
              List<UserModel> userList = snapshat.data!;

              return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  var user = userList[index];

                  return ListTile(
                    title: Text(user.username.toString() +
                        " - " +
                        user.name.toString()),
                    subtitle: Text(user.email.toString() +
                        "\n\n" +
                        user.phone.toString() +
                        "\n\n" +
                        user.website.toString() +
                        "\n\n" +
                        user.address.toString() +
                        "\n\n" +
                        user.company.toString()),
                    leading: CircleAvatar(
                      child: Text(user.id.toString()),
                    ),
                  );
                },
              );
            } else if (snapshat.hasError) {
              return Center(child: Text(snapshat.error.toString()));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
