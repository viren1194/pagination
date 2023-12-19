import 'dart:convert';

import 'package:flutter_product/data/response/post_model.dart';
import 'package:flutter_product/utils/api_client.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PostController extends GetxController {
  ApiClient apiClient;
  PostController({required this.apiClient});
  List<PostModel> postList = [];
  int page = 1;
  int limit = 15;
  bool isLoading = false;
  bool hasDataForNextPage = true;

  Future<void> fetchPost() async {
    isLoading = true;
    final url = Uri.parse(
        'https://jsonplaceholder.typicode.com/posts?_limit=$limit&_page=$page');
    final result = await http.get(url);
    print('url ==> $url');
    if (result.statusCode == 200) {
      List<dynamic> jsonList = json.decode(result.body);

      for (var jsonMap in jsonList) {
        PostModel postModel = PostModel.fromJson(jsonMap);
        postList.add(postModel);
      }
      page++;
      if (jsonList.length < limit) {
        print('limit = ${limit}');
        hasDataForNextPage = false;
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
}
