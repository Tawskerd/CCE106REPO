import 'dart:io' show File;
import 'dart:typed_data' show Uint8List;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:image_picker/image_picker.dart';

class PickedImage {
  final File? file;        // mobile only
  final Uint8List? bytes;  // web only
  final String url;        // cloudinary image URL

  PickedImage({
    this.file,
    this.bytes,
    required this.url,
  });
}

class CrudService {
  final CollectionReference items =
      FirebaseFirestore.instance.collection('items');

  final CloudinaryPublic _cloudinary = CloudinaryPublic(
    'djydxmgx7',  // your Cloudinary cloud name
    'gfchyj2d',   // your unsigned upload preset
    cache: false,
  );

  final ImagePicker _picker = ImagePicker();

  // ---------------------------------------------------------
  // PICK + UPLOAD IMAGE (WEB + MOBILE SUPPORT)
  // ---------------------------------------------------------
  Future<PickedImage?> pickImageForAndImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return null;

    CloudinaryResponse response;

    if (kIsWeb) {
      // ---------- WEB UPLOAD ----------
      Uint8List bytes = await pickedFile.readAsBytes();

      response = await _cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(
          bytes,
          identifier: pickedFile.name,
          resourceType: CloudinaryResourceType.Image,
        ),
      );

      return PickedImage(
        bytes: bytes,
        url: response.secureUrl,
      );
    } else {
      // ---------- MOBILE UPLOAD ----------
      final file = File(pickedFile.path);

      response = await _cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          file.path,
          resourceType: CloudinaryResourceType.Image,
        ),
      );

      return PickedImage(
        file: file,
        url: response.secureUrl,
      );
    }
  }

  // ---------------------------------------------------------
  // CREATE WITH IMAGE
  // ---------------------------------------------------------
  Future<void> addItemWithImage(
      String name, int quantity, String? imageUrl) async {
    await items.add({
      'name': name,
      'quantity': quantity,
      'imageUrl': imageUrl,
      'favorite': false,
      'createdAt': Timestamp.now(),
    });
  }

  // ---------------------------------------------------------
  // READ
  // ---------------------------------------------------------
  Stream<QuerySnapshot> getItems() {
    return items.orderBy('createdAt', descending: true).snapshots();
  }

  // ---------------------------------------------------------
  // UPDATE NAME + QUANTITY ONLY
  // ---------------------------------------------------------
  Future<void> updateItem(String id, String name, int quantity) {
    return items.doc(id).update({
      'name': name,
      'quantity': quantity,
    });
  }

  // ---------------------------------------------------------
  // DELETE ITEM
  // ---------------------------------------------------------
  Future<void> deleteItem(String id) {
    return items.doc(id).delete();
  }

  // ---------------------------------------------------------
  // TOGGLE FAVORITE
  // ---------------------------------------------------------
  Future<void> toggleFavorite(String id, bool currentValue) {
    return items.doc(id).update({
      'favorite': !currentValue,
    });
  }

  // ---------------------------------------------------------
  // GET FAVORITES ONLY
  // ---------------------------------------------------------
  Stream<QuerySnapshot> getFavorites() {
    return items.where('favorite', isEqualTo: true).snapshots();
  }
}
