import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseStorageServices {
  uploadImageAndGetUrl({required String path, required File image}) async {
    String imageUrl = await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('$path/${Uri.file(image.path).pathSegments.last}')
        .putFile(image)
        .then((p0) => p0.ref.getDownloadURL());
    return imageUrl;
  }
}
