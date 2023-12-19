import 'package:flutter_product/controller/post_controller.dart';
import 'package:flutter_product/controller/product_controller.dart';
import 'package:get/get.dart';
import 'api_client.dart';

Future<void> init() async {
  final ApiClient apiClient = ApiClient();
  Get.lazyPut(() => apiClient);
  Get.lazyPut(() => ProductController(apiClient: Get.find()));
  Get.lazyPut(() => PostController(apiClient: Get.find()));
}
