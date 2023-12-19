import 'package:flutter/material.dart';
import 'package:flutter_product/controller/product_controller.dart';
import 'package:flutter_product/data/response/product_model.dart';
import 'package:get/get.dart';

class DemoProduct extends StatefulWidget {
  const DemoProduct({super.key});

  @override
  State<DemoProduct> createState() => _DemoProductState();
}

class _DemoProductState extends State<DemoProduct> {
  final ProductController productController =
      Get.put(ProductController(apiClient: Get.find()));
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(_scrollListener);
      _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset &&
        productController.hasDataForNextPage) {
        // page++;
          productController.fetchProduct();
      }
    });

    productController.fetchProduct();
  }

  void _scrollListener() {

    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !productController.isLoading &&
        productController.hasDataForNextPage) {
      // Scrolling at the bottom, load the next page
      productController.fetchProduct();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<ProductController>(
        builder: (productController) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: productController.productList.length + 1,
            itemBuilder: (context, index) {
              if (index < productController.productList.length) {
                ProductModel product = productController.productList[index];
                return ListTile(
                  title: Text(product.title ?? ''),
                 
                );
              } else {
                return productController.hasDataForNextPage
                    ? _buildLoader()
                    : SizedBox.shrink();
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildLoader() {
    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
