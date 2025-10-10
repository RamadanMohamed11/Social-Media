import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  final SupabaseClient supabase;

  StorageService({required this.supabase});

  Future<String> uploadData({
    required String bucketId,
    required Uint8List file,
    required String fileName,
  }) async {
    final ref = supabase.storage.from(bucketId);
    await ref.uploadBinary(
      fileName,
      file,
      fileOptions: FileOptions(upsert: false, cacheControl: '3600'),
    );
    return ref.getPublicUrl(fileName);
  }

  Future<void> deleteData({
    required String bucketId,
    required String fileName,
  }) async {
    await supabase.storage.from(bucketId).remove([fileName]);
  }

  Future<void> updateData({
    required String bucketId,
    required String fileName,
    required Uint8List file,
  }) async {
    // delete then add
    await deleteData(bucketId: bucketId, fileName: fileName);
    await uploadData(bucketId: bucketId, fileName: fileName, file: file);
  }
}
