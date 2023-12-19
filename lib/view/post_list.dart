import 'package:flutter/material.dart';
import 'package:flutter_product/controller/post_controller.dart';
import 'package:get/get.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  ScrollController scrollController = ScrollController();
  PostController postController =
      Get.put(PostController(apiClient: Get.find()));
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset &&
          postController.hasDataForNextPage) {
        postController.fetchPost();
      }
    });
    postController.fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(builder: (postController) {
      return Scaffold(
          appBar: AppBar(),
          body: postController.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  controller: scrollController,
                  itemCount: postController.postList.length + 1,
                  itemBuilder: (context, index) {
                    if (index < postController.postList.length) {
                      return ListTile(
                        title:
                            Text(postController.postList[index].id.toString()),
                      );
                    } else {
                      return postController.hasDataForNextPage
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const SizedBox.shrink();
                    }
                  },
                )
          );
    });
  }
}
