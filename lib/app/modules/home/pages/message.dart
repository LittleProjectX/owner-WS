import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ownerwaroengsederhana/app/firebases/firestore_service.dart';
import 'package:ownerwaroengsederhana/app/models/user.dart';
import 'package:ownerwaroengsederhana/app/routes/app_pages.dart';
import 'package:ownerwaroengsederhana/app/utils/loading.dart';
import 'package:ownerwaroengsederhana/colors.dart';

class Message extends StatelessWidget {
  Message({
    super.key,
  });
  final FirestoreService fireC = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: fireC.getAllUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final snap = snapshot.data!.docs;
          List<UserModel> users = snap.map((doc) {
            return UserModel.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Get.toNamed(Routes.chat, arguments: {
                  'uId': users[index].uId,
                  'name': users[index].name,
                  'image': users[index].profilPict
                }),
                child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: whiteColor,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(users[index].profilPict),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          users[index].name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.message,
                          color: Colors.green,
                        )
                      ],
                    )),
              );
            },
          );
        }
        return const LoadingView();
      },
    );
  }
}
