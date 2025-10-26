import 'package:cloud_firestore/cloud_firestore.dart';

String timeAgoFrom(dynamic timestamp) {
  DateTime date;
  if (timestamp == null) return '';
  try {
    if (timestamp is DateTime) {
      date = timestamp;
    } else if (timestamp is Timestamp) {
      date = timestamp.toDate();
    } else if (timestamp is String) {
      date = DateTime.tryParse(timestamp) ?? DateTime.now();
    } else {
      // Fallback: try toString parse
      date = DateTime.tryParse(timestamp.toString()) ?? DateTime.now();
    }
  } catch (_) {
    return '';
  }

  final now = DateTime.now();
  final diff = now.difference(date);

  if (diff.inSeconds < 60) return 'just now';
  if (diff.inMinutes < 60) return '${diff.inMinutes}m';
  if (diff.inHours < 24) return '${diff.inHours}h';
  if (diff.inDays < 30) return '${diff.inDays}d';

  final months = diff.inDays ~/ 30;
  if (months < 12) return '${months}mo';

  final years = months ~/ 12;
  return '${years}y';
}
