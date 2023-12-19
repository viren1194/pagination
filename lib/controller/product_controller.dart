import 'package:flutter/material.dart';
import 'package:flutter_product/data/response/product_model.dart';
import 'package:flutter_product/utils/api_client.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  ApiClient apiClient;
  ProductController({required this.apiClient});
  List<ProductModel> productList = [];
  int offset = 0;
  int limit = 13;
  bool isLoading = false;
  bool hasDataForNextPage = true; // Add this flag
  bool dataNotFound = false;
  TextEditingController searchController = TextEditingController();

  Future<void> fetchProduct() async {
    isLoading = true;

    Response response = await apiClient.getData(
        'https://api.escuelajs.co/api/v1/products?offset=$offset&limit=$limit');

    print('response ==> ${response.body}');
    print(
        'uri => ${'https://api.escuelajs.co/api/v1/products?offset=$offset&limit=$limit'}');
    if (response.statusCode == 200) {
      List<dynamic> jsonList = response.body as List;
      for (var element in jsonList) {
        ProductModel productModel = ProductModel.fromJson(element);
        productList.add(productModel);
      }
      offset += limit;
      if (jsonList.length < limit) {
        //  print('length***** ${jsonList.length}');
        hasDataForNextPage = false;
      } else {
        hasDataForNextPage = true;
      }
      // print('length ${jsonList.length}');
      // print('limit = ${limit}');
      isLoading = false;
      update();
    } else {
      isLoading = false;
      update();
    }
  }

  Future<void> filterProductsByTitle(String title) async {
    dataNotFound = false;
    isLoading = true;
    update();
    String apiUrl = 'https://api.escuelajs.co/api/v1/products?title=$title';
    Response response = await apiClient.getData(apiUrl);
    print('apiUrl --> $apiUrl');
    print('response --> ${response.body}');

    if (response.statusCode == 200) {
      // dataNotFound = false;
      List<dynamic> responseData = response.body;
      if (responseData.isNotEmpty) {
        productList.clear(); // Clear the existing list before adding new items
        responseData.forEach(
          (element) {
            ProductModel productModel = ProductModel.fromJson(element);
            productList.add(productModel);
          },
        );
        isLoading = false;
        update();
      } else {
        dataNotFound = true;
        isLoading = false;
        update();
      }
    } else {
      isLoading = false;
      update();
    }
    // update();
  }
}



