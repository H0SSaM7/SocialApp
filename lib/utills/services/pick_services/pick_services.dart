import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PickServices {
  final ImagePicker _picker = ImagePicker();
  Future<File?> pickImage() async {
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return null;
    } else {
      return File(pickedImage.path);
    }
  }

  pickMultiImages() async {
    List<File> images = [];
    List<XFile>? _pickedImages = await _picker.pickMultiImage();
    if (_pickedImages != null) {
      for (var element in _pickedImages) {
        images.add(File(element.path));
      }
    } else {
      return null;
    }
    return images;
  }
}
