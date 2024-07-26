import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ownerwaroengsederhana/app/firebases/auth_service.dart';
import 'package:ownerwaroengsederhana/app/firebases/chat_service.dart';
import 'package:ownerwaroengsederhana/app/models/message.dart';
import 'package:ownerwaroengsederhana/app/modules/chat/controllers/chat_controller.dart';
import 'package:ownerwaroengsederhana/app/modules/chat/widgets/message_bubble.dart';
import 'package:ownerwaroengsederhana/app/routes/app_pages.dart';
import 'package:ownerwaroengsederhana/app/utils/loading.dart';
import 'package:ownerwaroengsederhana/colors.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  ChatService chatC = ChatService();
  AuthService authC = AuthService();
  final msgC = Get.put(ChatController());
  final userId = Get.arguments['uId'];
  final username = Get.arguments['name'];
  final userImage = Get.arguments['image'];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: chatC.getMessage(authC.auth.currentUser!.uid, userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final snap = snapshot.data!.docs;
          List<Message> allMsg = snap.map((doc) {
            return Message.fromFirestore(doc.data());
          }).toList();
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 90, 10, 80),
                  child: ListView.builder(
                    itemCount: allMsg.length,
                    itemBuilder: (context, index) {
                      bool isMe = false;

                      if (allMsg[index].senderId ==
                          authC.auth.currentUser!.uid) {
                        isMe = true;
                      }
                      return MessageBubble(allMsg[index].message,
                          isMe == true ? 'Saya' : '$username', isMe);
                    },
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: 120,
                      color: whiteColor,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () => Get.back(),
                                  icon: const Icon(Icons.arrow_back)),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.viewimage,
                                      arguments: userImage);
                                },
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(userImage),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                username,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: whiteColor,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                hintText: 'Kirim pesan',
                              ),
                              controller: msgC.msg,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              chatC.sendMessage(userId, msgC.msg.text);
                              msgC.msg.clear();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: tabColor),
                              child: const Icon(
                                Icons.send,
                                color: whiteColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        }
        return const LoadingView();
      },
    );
  }
}
