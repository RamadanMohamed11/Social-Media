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

  Future<List<dynamic>> getData() async {
    QuerySnapshot querySnapshot = await collectionReference.get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
}
