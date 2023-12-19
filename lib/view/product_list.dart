import 'package:flutter/material.dart';
import 'package:flutter_product/controller/product_controller.dart';
import 'package:flutter_product/data/response/product_model.dart';
import 'package:get/get.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ProductController productController =
      Get.put(ProductController(apiClient: Get.find()));
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    productController.fetchProduct();
  }

  void _scrollListener() {
    if (_scrollController.position.maxScrollExtent ==
            _scrollController.offset &&
        productController.hasDataForNextPage) {
      productController.fetchProduct();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<ProductController>(
        builder: (productController) {
          return SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                TextField(
                  // controller: productController.searchController,
                  onChanged: (value) async {
                    await productController.filterProductsByTitle(value);
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: "Search"),
                ),
                productController.isLoading
                    ? _buildLoader()
                    : productController.dataNotFound
                        ? const Center(
                            child: Text("No data found"),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            // controller: _scrollController,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: productController.productList.length + 1,
                            itemBuilder: (context, index) {
                              if (index <
                                  productController.productList.length) {
                                ProductModel product =
                                    productController.productList[index];
                                return Card(
                                  child: ListTile(
                                    title: Text(product.title ?? ''),
                                  ),
                                );
                              } else {
                                return productController.hasDataForNextPage
                                    ? _buildLoader()
                                    : const SizedBox.shrink();
                              }
                            },
                          )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoader() {
    return const Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
