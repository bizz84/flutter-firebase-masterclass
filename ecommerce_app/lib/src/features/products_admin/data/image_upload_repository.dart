import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_upload_repository.g.dart';

/// Class for uploading images to Firebase Storage
class ImageUploadRepository {
  ImageUploadRepository(this._storage);
  final FirebaseStorage _storage;

  /// Upload an image asset to Firebase Storage and returns the download URL
  Future<String> uploadProductImageFromAsset(
      String assetPath, ProductID productId) async {
    // TODO: Implement
    throw UnimplementedError();
  }

  UploadTask _uploadAsset(ByteData byteData, String filename) {
    final bytes = byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    final ref = _storage.ref('products/$filename');
    return ref.putData(
      bytes,
      SettableMetadata(contentType: 'image/jpeg'),
    );
  }
}

@riverpod
ImageUploadRepository imageUploadRepository(ImageUploadRepositoryRef ref) {
  return ImageUploadRepository(FirebaseStorage.instance);
}
