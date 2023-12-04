import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/export_files.dart';

class ImageViewScreen extends StatelessWidget {
  final String image;
  final String baseUrl = Constants.baseUrl;

  ImageViewScreen({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Container(
              margin: const EdgeInsets.only(
                top: 20,
              ),
              child: const CustomText(
                headingStr: 'IMAGE VIEW',
                weight: TextWeight.bold,
                fontSize: 19,
              ),
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 30,
                      top: 20,
                    ),
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
            
          ),
        ),
      body: Center(
        child: Hero(
          tag: '${baseUrl}user/image/${image}',
          child: Image.network(
            '${baseUrl}user/image/${image}',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
