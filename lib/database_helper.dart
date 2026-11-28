import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

class DatabaseHelper {
  static final CollectionReference<Map<String, dynamic>> _goals =
      FirebaseFirestore.instance.collection('goals');

  // connect the app to Firebase (needed for web)
  static Future<void> initDatabase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static Future<List<Map<String, dynamic>>> getGoals() async {
    final snapshot = await _goals.orderBy('createdAt').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'id': doc.id,
        'subject': data['subject'],
        'hours': data['hours'],
        'done': data['done'] ?? false,
      };
    }).toList();
  }

  static Future<String> insertGoal(Map<String, dynamic> goal) async {
    final doc = await _goals.add({
      'subject': goal['subject'],
      'hours': goal['hours'],
      'done': goal['done'] ?? false,
      'createdAt': FieldValue.serverTimestamp(),
    });
    return doc.id;
  }

  static Future<void> updateGoal(String id, bool done) async {
    await _goals.doc(id).update({'done': done});
  }

  static Future<void> deleteGoal(String id) async {
    await _goals.doc(id).delete();
  }
}
