import 'package:almarry_ex/app/modules/users_module/users_controller.dart';
import 'package:almarry_ex/app/views/views.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class usersPage extends GetView<usersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المستخدمين'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.addUser(),
        child: Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: controller.users.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Error(action: () {});
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              var use = User.fromJson(document.data()! as Map<String, dynamic>);
              return ListTile(
                title: Text(use.name!),
                onTap: () => controller.updateUser(use, document.id),
                subtitle: Text(
                  use.phone!,
                  style: Get.textTheme.button,
                ),
                trailing: Text(use.isAdmin! ? 'مدير' : 'مستخدم'),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
