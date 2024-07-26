import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ownerwaroengsederhana/app/models/food.dart';
import 'package:ownerwaroengsederhana/app/models/user.dart';

class FirestoreService extends GetxController {
  CollectionReference owner = FirebaseFirestore.instance.collection('owner');
  CollectionReference food = FirebaseFirestore.instance.collection('food');
  CollectionReference cart = FirebaseFirestore.instance.collection('cart');
  CollectionReference order = FirebaseFirestore.instance.collection('order');
  CollectionReference user = FirebaseFirestore.instance.collection('users');
  CollectionReference cards = FirebaseFirestore.instance.collection('cards');

  Future<void> addUser(String uId, name, phone, profilPict) async {
    try {
      var user = UserModel(
        uId: uId,
        name: name,
        phone: phone,
        profilPict: profilPict,
        isOnline: false,
      );
      await owner.doc(uId).set(user.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addCard(
      String item1, item2, number1, number2, name1, name2) async {
    try {
      await cards.add({
        'item1': item1,
        'item2': item2,
        'number1': number1,
        'number2': number2,
        'name1': name1,
        'name2': name2,
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<DocumentSnapshot<Object?>> getMyData(String uId) {
    return owner.doc(uId).snapshots();
  }

  Future<QuerySnapshot<Object?>> getCardInfo() {
    return cards.get();
  }

  Future<void> addFood(
      String category, name, description, imageUrl, double price) async {
    try {
      double finalPrice = double.parse(price.toStringAsFixed(0));
      await food.add({
        'category': category,
        'name': name,
        'description': description,
        'price': finalPrice,
        'imageUrl': imageUrl,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, List<DocumentSnapshot>>> fetchData(String uId) async {
    QuerySnapshot data1 = await food.get();
    QuerySnapshot data2 = await cart.doc(uId).collection('cartItem').get();

    return {
      'food': data1.docs,
      'cart': data2.docs,
    };
  }

  Future<QuerySnapshot<Object?>> getOnlyMenu() {
    return food.get();
  }

  Stream<QuerySnapshot<Object?>> getAllUsers() {
    return user.snapshots();
  }

  Future<DocumentSnapshot<Object?>> getById(String id) async {
    return await food.doc(id).get();
  }

  Stream<QuerySnapshot<Object?>> getAllOrder() {
    return order.snapshots();
  }

  void addCart(String uId, FoodModel food) async {
    await cart.doc(uId).collection('cartItem').add({
      'food': food.toMap(),
      'qty': 1,
    });
  }

  Future<void> statusOrder(String oId, status) {
    return order.doc(oId).update({'status': status});
  }

  Future<void> plusQty(String uId, String cId, int qty) {
    return cart
        .doc(uId)
        .collection('cartItem')
        .doc(cId)
        .update({'qty': qty + 1});
  }

  Future<void> minQty(String uId, String cId, int qty) {
    return cart
        .doc(uId)
        .collection('cartItem')
        .doc(cId)
        .update({'qty': qty - 1});
  }

  Future<void> editFood(
      String fId, category, name, description, imageUrl, double price) {
    double finalPrice = double.parse(price.toStringAsFixed(0));
    return food.doc(fId).update({
      'category': category,
      'name': name,
      'description': description,
      'price': finalPrice,
      'imageUrl': imageUrl,
    });
  }

  Future<void> editCard(
      String id, item1, item2, number1, number2, name1, name2) {
    return cards.doc(id).update({
      'item1': item1,
      'item2': item2,
      'number1': number1,
      'number2': number2,
      'name1': name1,
      'name2': name2,
    });
  }

  Future<void> editUser(String uId, name, phone, imageLink) {
    return owner.doc(uId).update({
      'name': name,
      'phone': phone,
      'profilPict': imageLink,
    });
  }

  Future<void> deleteFood(String fId) {
    return food.doc(fId).delete();
  }

  Future<void> deleteOrder(String oId) {
    return food.doc(oId).delete();
  }
}
