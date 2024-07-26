import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ownerwaroengsederhana/app/models/message.dart';

class ChatService extends GetxController {
  CollectionReference users = FirebaseFirestore.instance.collection('owner');
  CollectionReference chats =
      FirebaseFirestore.instance.collection('chats_room');
  FirebaseAuth authn = FirebaseAuth.instance;

  Stream<QuerySnapshot<Object?>> getStreamUser() {
    return users.snapshots();
  }

  Future<void> sendMessage(String receiverId, message) async {
    // mengambil pengguna
    final String currentUserId = authn.currentUser!.uid;
    final String currentEmail = authn.currentUser!.email.toString();
    final Timestamp timeStamp = Timestamp.now();

    // buat pesan baru
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentEmail,
      receiverId: receiverId,
      message: message,
      timeStamps: timeStamp,
    );

    // buat room id dengan kode unik
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); // membuat id room sama untuk dua pengguna
    String chatRoomId = ids.join('_');

    // tambah pesan ke database
    await chats.doc(chatRoomId).collection('messages').add(
          newMessage.toMap(),
        );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessage(
      String userId, otherUserId) {
    // mengambil room id
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    // mengambil pesan sesuai room id
    return chats
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timeStamp', descending: false)
        .snapshots();
  }
}
