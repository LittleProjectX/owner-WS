import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ownerwaroengsederhana/app/firebases/firestore_service.dart';
import 'package:ownerwaroengsederhana/app/models/all_food.dart';
import 'package:ownerwaroengsederhana/app/models/order.dart';
import 'package:ownerwaroengsederhana/app/routes/app_pages.dart';
import 'package:ownerwaroengsederhana/app/utils/loading.dart';
import 'package:ownerwaroengsederhana/colors.dart';

class AllOrder extends StatefulWidget {
  const AllOrder({
    super.key,
  });

  @override
  State<AllOrder> createState() => _AllOrderState();
}

class _AllOrderState extends State<AllOrder> {
  FirestoreService fireC = FirestoreService();
  final listOrderC = Get.put(Allfood());
  String? selectedItem = 'Orderan Baru';
  String? statusOrder;

  final List<String> _dropMenu = [
    'Orderan Baru',
    'Diproses',
    'Dikirim',
    'selesai',
  ];

  Color _getOrderColor(String status) {
    switch (status) {
      case 'Orderan Baru':
        return Colors.red;
      case '`Diproses`':
        return Colors.blue;
      case 'Dikirim':
        return Colors.green;
      case 'selesai':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  List<FoodOrder> _filterMenu(String status, List<FoodOrder> allOrder) {
    return allOrder.where((order) => order.status == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    return StreamBuilder<QuerySnapshot<Object?>>(
      stream: fireC.getAllOrder(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final snap = snapshot.data!.docs;
          listOrderC.clearOrder();
          for (var doc in snap) {
            final data = doc.data() as Map<String, dynamic>;
            listOrderC.getAllOrder(
              doc.id,
              data['uId'],
              data['telp'],
              data['order'],
              data['alamatLengkap'],
              data['imageUrl'],
              data['pesan'],
              data['status'],
            );
          }

          List<FoodOrder> categoryList =
              _filterMenu(selectedItem.toString(), listOrderC.listOrder);

          return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'PESANAN',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: tabColor,
                    fontSize: 26,
                  ),
                ),
                actions: [
                  SizedBox(
                    width: size.width * 0.5,
                    child: DropdownButtonFormField<String>(
                      dropdownColor: greyColor400,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: textfielColor,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      hint: const Text(
                        'Pilih Status',
                      ),
                      value: selectedItem,
                      padding: const EdgeInsets.all(5),
                      items: _dropMenu.map((String status) {
                        return DropdownMenuItem<String>(
                            value: status,
                            child: Text(status
                                .toString()
                                .split('.')
                                .last
                                .toUpperCase()));
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedItem = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
              body: snap.isNotEmpty
                  ? ListView.builder(
                      itemCount: categoryList.length,
                      itemBuilder: (context, index) {
                        statusOrder = categoryList[index].status;

                        return categoryList.isNotEmpty
                            ? Container(
                                width: size.width,
                                height: size.height,
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(10),
                                decoration:
                                    const BoxDecoration(color: whiteColor),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _getOrderColor(
                                                categoryList[index].status),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        SizedBox(
                                          width: size.width * 0.5,
                                          child:
                                              DropdownButtonFormField<String>(
                                            dropdownColor: greyColor400,
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: textfielColor,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10))),
                                            hint: const Text(
                                              'Pilih Status',
                                            ),
                                            value: statusOrder,
                                            padding: const EdgeInsets.all(5),
                                            items:
                                                _dropMenu.map((String status) {
                                              return DropdownMenuItem<String>(
                                                  value: status,
                                                  child: Text(status
                                                      .toString()
                                                      .split('.')
                                                      .last
                                                      .toUpperCase()));
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                statusOrder = newValue;
                                                fireC.statusOrder(
                                                    categoryList[index].oId,
                                                    newValue.toString());
                                              });
                                            },
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                            onPressed: () {
                                              Get.toNamed(Routes.searchuser,
                                                  arguments:
                                                      categoryList[index].uId);
                                            },
                                            icon: const Icon(Icons.message)),
                                        const Spacer(),
                                        IconButton(
                                            onPressed: () {
                                              Get.defaultDialog(
                                                title: 'Perhatian',
                                                content: const Text(
                                                  'Yakin ingin menghapus orderan ini?',
                                                ),
                                                textCancel: 'Batal',
                                                textConfirm: 'Ya',
                                                onCancel: () {
                                                  Get.back();
                                                },
                                                onConfirm: () {
                                                  fireC
                                                      .deleteOrder(
                                                          categoryList[index]
                                                              .oId)
                                                      .then(
                                                    (_) {
                                                      Get.snackbar('Perhatian',
                                                          'Berhasil menghapus data Order');
                                                      Get.back();
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            icon: const Icon(Icons.delete))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Telp : ',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          categoryList[index].telp,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Alamat : ',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Expanded(
                                          child: Text(
                                            categoryList[index].alamatLengkap,
                                            maxLines: 5,
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Pesan : ',
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        Expanded(
                                          child: Text(
                                            categoryList[index].pesan,
                                            maxLines: 5,
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: greyColor)),
                                        child: Text(categoryList[index].order)),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.viewimage,
                                            arguments:
                                                categoryList[index].imageUrl);
                                      },
                                      child: SizedBox(
                                        height: 200,
                                        width: 150,
                                        child: Image.network(
                                          categoryList[index].imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  ],
                                ))
                            : const Column(
                                children: [
                                  SizedBox(
                                    height: 300,
                                  ),
                                  Text('Tidak ada data'),
                                ],
                              );
                      },
                    )
                  : const Center(
                      child: Text(
                        'Tidak ada orderan saat ini',
                        style: TextStyle(fontSize: 24),
                      ),
                    ));
        }
        return const LoadingView();
      },
    );
  }
}
