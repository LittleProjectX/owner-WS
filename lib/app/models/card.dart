import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Cards extends GetxController {
  final String cId;
  final String item1;
  final String item2;
  final String number1;
  final String number2;
  final String name1;
  final String name2;

  Cards({
    required this.cId,
    required this.item1,
    required this.item2,
    required this.number1,
    required this.number2,
    required this.name1,
    required this.name2,
  });

  factory Cards.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Cards(
        cId: doc.id,
        item1: data['item1'],
        item2: data['item2'],
        number1: data['number1'],
        number2: data['number2'],
        name1: data['name1'],
        name2: data['name2']);
  }
}
