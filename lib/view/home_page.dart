import 'package:flutter/material.dart';
import 'package:flutter_product/controller/product_controller.dart';
import 'package:flutter_product/view/post_list.dart';
import 'package:flutter_product/view/product_list.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Get.to(ProductList());
              },
              child: Text('Product List'))
        ],
      ),
    );
  }
}
