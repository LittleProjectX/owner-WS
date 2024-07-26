import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ownerwaroengsederhana/app/firebases/firestore_service.dart';
import 'package:ownerwaroengsederhana/app/models/food.dart';
import 'package:ownerwaroengsederhana/app/modules/addfood/controllers/addfood_controller.dart';
import 'package:ownerwaroengsederhana/app/routes/app_pages.dart';
import 'package:ownerwaroengsederhana/colors.dart';

class AddfoodView extends StatefulWidget {
  const AddfoodView({super.key});

  @override
  State<AddfoodView> createState() => _AddfoodViewState();
}

class _AddfoodViewState extends State<AddfoodView> {
  final addFoodC = Get.put(AddfoodController());
  FirestoreService fireC = FirestoreService();
  FoodCategory? selectedItem;
  String? imageLink = '';

  // memilih file dari memori
  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      final imageLink =
          await Get.toNamed(Routes.menupict, arguments: result.files.first);
      if (imageLink != null) {
        setState(() {
          this.imageLink = imageLink;
        });
      }
    }
  }

  void clearAddMenu() {
    setState(() {
      imageLink = '';
      selectedItem = null;
      addFoodC.name.clear();
      addFoodC.description.clear();
      addFoodC.price.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.offAllNamed(Routes.home);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          'A D D  M E N U',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: tabColor, fontSize: 26),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: size.width,
                height: 120,
                decoration: BoxDecoration(
                    color: textfielColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        selectFile();
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: imageLink != null && imageLink!.isNotEmpty
                              ? NetworkImage(imageLink!)
                              : const AssetImage('assets/images/no_image.jpg')
                                  as ImageProvider,
                        )),
                      ),
                    ),
                    const Text('Pilih gambar menu')
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<FoodCategory>(
                dropdownColor: greyColor400,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: textfielColor,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                hint: const Text(
                  'Pilih kategori menu',
                ),
                value: selectedItem,
                padding: const EdgeInsets.all(5),
                items: FoodCategory.values.map((FoodCategory category) {
                  return DropdownMenuItem<FoodCategory>(
                      value: category,
                      child: Text(
                          category.toString().split('.').last.toUpperCase()));
                }).toList(),
                onChanged: (FoodCategory? newValue) {
                  setState(() {
                    selectedItem = newValue;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              // textfield
              TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: textfielColor,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  label: const Text(
                    'Nama Menu',
                    style: TextStyle(color: blackColor),
                  ),
                ),
                controller: addFoodC.name,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: textfielColor,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  label: const Text(
                    'Deskripsi Menu',
                    style: TextStyle(color: blackColor),
                  ),
                ),
                controller: addFoodC.description,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: textfielColor,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  label: const Text(
                    'Harga Menu',
                    style: TextStyle(color: blackColor),
                  ),
                ),
                controller: addFoodC.price,
              ),
              const SizedBox(
                height: 70,
              ),
              SizedBox(
                  height: 50,
                  width: size.width * 0.7,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: tabColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      onPressed: () {
                        if (selectedItem != null &&
                            addFoodC.name.text.isNotEmpty &&
                            addFoodC.price.text.isNotEmpty) {
                          double price = double.parse(addFoodC.price.text);
                          fireC.addFood(
                              selectedItem.toString(),
                              addFoodC.name.text,
                              addFoodC.description.text,
                              imageLink.toString(),
                              price);
                          Get.snackbar('Pemberitahuan',
                              'Berhasil Menambahkan Menu Baru');
                          clearAddMenu();
                        } else {
                          Get.snackbar('Perhatian',
                              'Mohon untuk mengisi data dengan benar');
                        }
                      },
                      child: const Text(
                        'SIMPAN',
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ))),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 40,
                  width: size.width * 0.4,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: whiteColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      onPressed: clearAddMenu,
                      child: const Text(
                        'BATAL',
                        style: TextStyle(
                          color: tabColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
