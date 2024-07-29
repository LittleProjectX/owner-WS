import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ownerwaroengsederhana/app/firebases/firestore_service.dart';
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
  String? value1;
  String? value2;
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
        body: FutureBuilder<DocumentSnapshot<Object?>>(
          future: fireC.getCardInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final snap = snapshot.data!;
              Map<String, dynamic> data = snap.data() as Map<String, dynamic>;

              String? item1 = data['item1'];
              String? item2 = data['item2'];
              cardC.number1.text = data['number1'];
              cardC.number2.text = data['number2'];
              cardC.name1.text = data['name1'];
              cardC.name2.text = data['name2'];

              if (selectedItem1 != null) {
                value1 = selectedItem1;
              } else {
                value1 = item1;
              }

              if (selectedItem2 != null) {
                value2 = selectedItem2;
              } else {
                value2 = item2;
              }

              return Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'DATA 1',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
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
                            value: value1,
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
                            decoration: const InputDecoration(
                                label: Text(
                              'Nomor Transfer',
                              style: TextStyle(color: blackColor),
                            )),
                            controller: cardC.number1,
                          ),
                          TextField(
                            decoration: const InputDecoration(
                              label: Text('Atas Nama',
                                  style: TextStyle(color: blackColor)),
                            ),
                            controller: cardC.name1,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Text(
                            'DATA 2',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
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
                            value: value2,
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
                            decoration: const InputDecoration(
                                label: Text(
                              'Nomor Transfer',
                              style: TextStyle(color: blackColor),
                            )),
                            controller: cardC.number2,
                          ),
                          TextField(
                            decoration: const InputDecoration(
                              label: Text('Atas Nama',
                                  style: TextStyle(color: blackColor)),
                            ),
                            controller: cardC.name2,
                          ),
                          const SizedBox(
                            height: 60,
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
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
                                  value1.toString(),
                                  value2.toString(),
                                  cardC.number1.text,
                                  cardC.number2.text,
                                  cardC.name1.text,
                                  cardC.name2.text,
                                );
                                Get.snackbar(
                                    'Perhatian', 'Berhasil mengubah data');
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
            return const LoadingView();
          },
        ));
  }
}
