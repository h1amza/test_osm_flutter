/*
* Created By Mirai Devs.
* On 8/19/2022.
*/

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  ValueNotifier<File?> cameraFile = ValueNotifier(null);
  ValueNotifier<File?> galleryFile = ValueNotifier(null);
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ValueListenableBuilder(
                valueListenable: cameraFile,
                builder: (_, __, ___) {
                  if (cameraFile.value != null) {
                    return Expanded(
                      child: Image.file(
                        cameraFile.value!,
                        fit: BoxFit.fill,
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const SizedBox(height: 30),
              ValueListenableBuilder(
                valueListenable: galleryFile,
                builder: (_, __, ___) {
                  if (galleryFile.value != null) {
                    return Expanded(
                      child: Image.file(
                        galleryFile.value!,
                        fit: BoxFit.fill,
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () async {
              final XFile? photo = await _picker.pickImage(
                source: ImageSource.camera,
                maxHeight: 500,
                maxWidth: 500,
                imageQuality: 85,
              );
              if (photo != null) cameraFile.value = File(photo.path);
            },
            icon: const Icon(Icons.camera_alt_outlined),
          ),
          const SizedBox(height: 20),
          IconButton(
            onPressed: () async {
              final XFile? photo = await _picker.pickImage(
                source: ImageSource.gallery,
                maxHeight: 500,
                maxWidth: 500,
                imageQuality: 85,
              );
              if (photo != null) galleryFile.value = File(photo.path);
            },
            icon: const Icon(Icons.photo_library_rounded),
          ),
        ],
      ),
    );
  }
}
