import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/property.dart';

class FirebasePropertyService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  static const String _collection = 'properties';

  // ─── Upload image to Firebase Storage ─────────────────────────────────────
  Future<String> uploadImage(File imageFile, String propertyId) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final ref = _storage.ref().child('properties/$propertyId/$fileName');
    final uploadTask = await ref.putFile(imageFile);
    return await uploadTask.ref.getDownloadURL();
  }

  // ─── Save / Update property in Firestore ──────────────────────────────────
  Future<void> saveProperty(PropertyListing property) async {
    await _db.collection(_collection).doc(property.id).set(property.toJson());
  }

  // ─── Delete property from Firestore ───────────────────────────────────────
  Future<void> deleteProperty(String id) async {
    await _db.collection(_collection).doc(id).delete();
  }

  // ─── Fetch all properties from Firestore ──────────────────────────────────
  Stream<List<PropertyListing>> streamProperties() {
    return _db
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => PropertyListing.fromJson(d.data())).toList());
  }
}
