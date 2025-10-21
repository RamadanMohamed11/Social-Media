import 'package:cloud_firestore/cloud_firestore.dart';

class CloudService {
  final CollectionReference collectionReference;

  CloudService({required this.collectionReference});

  Future<void> storeData({
    required Map<String, dynamic> obj,
    required String docId,
  }) async {
    await collectionReference.doc(docId).set(obj);
  }

  Future<void> updateData({
    required Map<String, dynamic> obj,
    required String docId,
  }) async {
    await collectionReference.doc(docId).update(obj);
  }

  Future<void> deleteData({required String docId}) async {
    await collectionReference.doc(docId).delete();
  }

  Stream<List<DocumentSnapshot>> getData({
    String? orderBy,
    bool? isDescending,
  }) {
    if (orderBy == null) {
      return collectionReference.snapshots().map(
        (querySnapshot) => querySnapshot.docs,
      );
    } else {
      return collectionReference
          .orderBy(orderBy, descending: isDescending ?? true)
          .snapshots()
          .map((querySnapshot) => querySnapshot.docs);
    }
  }

  Future<DocumentSnapshot> getDocumentById({required String docId}) async {
    return await collectionReference.doc(docId).get();
  }
}
