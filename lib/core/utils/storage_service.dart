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
      fileOptions: const FileOptions(upsert: false, cacheControl: '3600'),
    );
    return ref.getPublicUrl(fileName);
  }

  Future<void> deleteData({
    required String bucketId,
    required String fileName,
  }) async {
    await supabase.storage.from(bucketId).remove([fileName]);
  }

  Future<String> updateData({
    required String bucketId,
    required String fileName,
    required Uint8List file,
  }) async {
    final ref = supabase.storage.from(bucketId);
    await ref.uploadBinary(
      fileName,
      file,
      fileOptions: const FileOptions(upsert: true, cacheControl: '3600'),
    );
    // Add timestamp parameter to force cache refresh when image is updated
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return '${ref.getPublicUrl(fileName)}?v=$timestamp';
  }
}
