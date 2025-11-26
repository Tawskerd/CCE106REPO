import 'package:cloud_firestore/cloud_firestore.dart';

class CrudService {
  final CollectionReference items = 
      FirebaseFirestore.instance.collection('items');

  Future<void> addItem(String name, int quantity) {
  return items.add({
    'name': name,
    'quantity': quantity,
    'favorite': false,   // <-- REQUIRED
    'createdAt': Timestamp.now(),
  });
}


  Stream<QuerySnapshot> getItems() {
    return items.orderBy('createdAt', descending: true).snapshots();
  }

  Future<void> updateItem(String id, String name, int quantity) {
    return items.doc(id).update({
      'name': name,
      'quantity': quantity,
    });
  }

  Future<void> deleteItem(String id) {
    return items.doc(id).delete();
  }


  Future<void> toggleFavorite(String id, bool currentValue) {
  return items.doc(id).update({
    'favorite': !currentValue,
  });
}

Stream<QuerySnapshot> getFavorites() {
  return items.where('favorite', isEqualTo: true) 
      .snapshots();
}

}
