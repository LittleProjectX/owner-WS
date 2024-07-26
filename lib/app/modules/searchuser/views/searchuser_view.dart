import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ownerwaroengsederhana/app/firebases/firestore_service.dart';
import 'package:ownerwaroengsederhana/app/models/user.dart';
import 'package:ownerwaroengsederhana/app/routes/app_pages.dart';
import 'package:ownerwaroengsederhana/app/utils/loading.dart';
import 'package:ownerwaroengsederhana/colors.dart';

class SearchuserView extends StatelessWidget {
  SearchuserView({super.key});
  final FirestoreService fireC = FirestoreService();
  final uId = Get.arguments;

  List<UserModel> _filterUser(String uId, List<UserModel> allUser) {
    return allUser.where((user) => user.uId == uId).toList();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: fireC.getAllUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final snap = snapshot.data!.docs;
          List<UserModel> allUser = snap.map((doc) {
            return UserModel.fromMap(doc.data() as Map<String, dynamic>);
          }).toList();

          List<UserModel> categoryUser = _filterUser(uId, allUser);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'USER ORDER',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: tabColor,
                  fontSize: 26,
                ),
              ),
            ),
            body: ListView.builder(
              itemCount: categoryUser.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.chat, arguments: {
                      'uId': categoryUser[index].uId,
                      'name': categoryUser[index].name,
                      'image': categoryUser[index].profilPict
                    });
                  },
                  child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      color: whiteColor,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(categoryUser[index].profilPict),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            categoryUser[index].name,
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
            ),
          );
        }
        return const LoadingView();
      },
    );
  }
}
