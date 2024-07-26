import 'package:get/get.dart';
import 'package:ownerwaroengsederhana/app/models/cart_item.dart';
import 'package:ownerwaroengsederhana/app/models/food.dart';
import 'package:ownerwaroengsederhana/app/models/order.dart';

class Allfood extends GetxController {
  final List<FoodModel> _listFood = [];
  List<FoodModel> get listFood => _listFood;

  final List<CartItem> _listCart = [];
  List<CartItem> get listCart => _listCart;

  final List<FoodOrder> _listOrder = [];
  List<FoodOrder> get listOrder => _listOrder;

  void getAllOrder(
      String oId, uId, telp, order, alamatLengkap, imageUrl, pesan, status) {
    _listOrder.add(FoodOrder(
        oId: oId,
        uId: uId,
        telp: telp,
        order: order,
        alamatLengkap: alamatLengkap,
        imageUrl: imageUrl,
        pesan: pesan,
        status: status));
  }

  void getAllMenu(
      String fId, category, name, description, imageUrl, double price) {
    _listFood.add(FoodModel(
      fId: fId,
      category: category,
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl,
    ));
  }

  void getAllCart(String cId, FoodModel food, int qty) {
    _listCart.add(CartItem(
      cId: cId,
      food: food,
      qty: qty,
    ));
  }

  void clearFood() {
    _listFood.clear();
  }

  void clearCart() {
    _listCart.clear();
  }

  void clearOrder() {
    _listOrder.clear();
  }
}
