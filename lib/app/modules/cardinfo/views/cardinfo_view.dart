import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ownerwaroengsederhana/app/firebases/firestore_service.dart';
import 'package:ownerwaroengsederhana/app/models/card.dart';
import 'package:ownerwaroengsederhana/app/modules/cardinfo/controllers/cardinfo_controller.dart';
import 'package:ownerwaroengsederhana/app/utils/loading.dart';
import 'package:ownerwaroengsederhana/colors.dart';

class CardinfoView extends StatefulWidget {
  const CardinfoView({super.key});

  @override
  State<CardinfoView> createState() => _CardinfoViewState();
}

class _CardinfoViewState extends State<CardinfoView> {
  String? selectedItem1;
  String? selectedItem2;
  List<Cards> _listCards = [];
  final cardC = Get.put(CardinfoController());
  FirestoreService fireC = FirestoreService();
  String? cId;
  final List<String> _dropItem = [
    'bca',
    'bni',
    'bri',
    'dana',
    'mandiri',
    'ovo',
  ];
  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'INFO TRANSFER',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: tabColor, fontSize: 26),
          ),
        ),
        body: FutureBuilder(
          future: fireC.getCardInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              _listCards.clear();
              final snap = snapshot.data!.docs;
              for (var card in snap) {
                Map<String, dynamic> data = card.data() as Map<String, dynamic>;
                _listCards.add(Cards(
                    cId: card.id,
                    item1: data['item1'],
                    item2: data['item2'],
                    number1: data['number1'],
                    number2: data['number2'],
                    name1: data['name1'],
                    name2: data['name2']));
              }

              return Stack(
                children: [
                  ListView.builder(
                    itemCount: _listCards.length,
                    itemBuilder: (context, index) {
                      cId = _listCards[index].cId;
                      print(_listCards[index].name1);
                      selectedItem1 = _listCards[index].item1;
                      selectedItem2 = _listCards[index].item2;
                      cardC.number1.text = _listCards[index].number1;
                      cardC.number2.text = _listCards[index].number1;
                      cardC.name1.text = _listCards[index].name1;
                      cardC.name2.text = _listCards[index].name2;

                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DATA 1',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DropdownButtonFormField<String>(
                              dropdownColor: greyColor400,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: textfielColor,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              hint: const Text(
                                'Pilih kategori menu',
                              ),
                              value: selectedItem1,
                              padding: const EdgeInsets.all(5),
                              items: _dropItem.map((String category) {
                                return DropdownMenuItem<String>(
                                    value: category,
                                    child: Text(category.toUpperCase()));
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedItem1 = newValue;
                                });
                              },
                            ),
                            TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  label: Text(
                                'Nomor Transfer',
                                style: TextStyle(color: blackColor),
                              )),
                              controller: cardC.number1,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                label: Text('Atas Nama',
                                    style: TextStyle(color: blackColor)),
                              ),
                              controller: cardC.name1,
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              'DATA 2',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DropdownButtonFormField<String>(
                              dropdownColor: greyColor400,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: textfielColor,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              hint: const Text(
                                'Pilih kategori menu',
                              ),
                              value: selectedItem2,
                              padding: const EdgeInsets.all(5),
                              items: _dropItem.map((String category) {
                                return DropdownMenuItem<String>(
                                    value: category,
                                    child: Text(category.toUpperCase()));
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedItem2 = newValue;
                                });
                              },
                            ),
                            TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  label: Text(
                                'Nomor Transfer',
                                style: TextStyle(color: blackColor),
                              )),
                              controller: cardC.number2,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                label: Text('Atas Nama',
                                    style: TextStyle(color: blackColor)),
                              ),
                              controller: cardC.name2,
                            ),
                            SizedBox(
                              height: 60,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                          height: 50,
                          width: size.width * 0.7,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: tabColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                              onPressed: () {
                                fireC.editCard(
                                  cId.toString(),
                                  selectedItem1.toString(),
                                  selectedItem2.toString(),
                                  cardC.number1.text,
                                  cardC.number2.text,
                                  cardC.name1.text,
                                  cardC.name2.text,
                                );
                                Get.back();
                              },
                              child: const Text(
                                'SIMPAN',
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ))),
                    ),
                  ),
                ],
              );
            }
            return LoadingView();
          },
        ));
  }
}
