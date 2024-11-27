import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trackerss/core/errors/exceptions.dart';
import 'package:trackerss/features/gift_management/data/data_source/gift_remote_datasource.dart';
import 'package:trackerss/features/gift_management/data/models/gift_model.dart';
import 'package:trackerss/features/gift_management/domain/entities/gift.dart';

class GiftFirebaseRemoteDatasource implements GiftRemoteDataSource {
  final FirebaseFirestore _firestore;

  GiftFirebaseRemoteDatasource(this._firestore);

  @override
  Future<void> createGift(Gift gift) async {
    try {
      final giftDocRef = _firestore.collection('gifts').doc('1'); // Fixed ID: '1'
      final giftModel = GiftModel(
       id: gift.id,
      name: gift.name,
      description: gift.description,
      category: gift.category,
      recipientId: gift.recipientId,
      occasionDate: DateTime(2024, 12, 25),
      status: gift.status,
      price: gift.price,
      notes: gift.notes,
      );
      await giftDocRef.set(giftModel.toMap());
    } on FirebaseException catch (e) {
      throw APIException(
        message: e.message ?? 'Unknown error has occurred',
        statusCode: e.code,
      );
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }

  @override
  Future<void> deleteGift(String id) async {
    try {
      await _firestore.collection('gifts').doc(id).delete();
    } on FirebaseException catch (e) {
      throw APIException(
        message: e.message ?? 'Unknown error has occurred',
        statusCode: e.code,
      );
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }

  @override
  Future<List<Gift>> getGifts({String? filterBy, String? sortBy}) async {
    try {
      final querySnapshot = await _firestore.collection('gifts').get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Gift(
          id: data['id'],
          name: data['name'],
          description: data['description'],
          category: data['category'],
          recipientId: data['recipientId'],
          occasionDate: DateTime.parse(data['occasionDate']),
          status: data['status'],
          price: data['price'],
          notes: data['notes'],
        );
      }).toList();
    } on FirebaseException catch (e) {
      throw APIException(
        message: e.message ?? 'Unknown error has occurred',
        statusCode: e.code,
      );
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }

  @override
  Future<void> updateGift(Gift gift) async {
    final giftModel = GiftModel(
      id: gift.id,
      name: gift.name,
      description: gift.description,
      category: gift.category,
      recipientId: gift.recipientId,
      occasionDate: DateTime(2024, 12, 25),
      status: gift.status,
      price: gift.price,
      notes: gift.notes,
    );
    try {
      await _firestore
          .collection('gifts')
          .doc(gift.id)
          .update(giftModel.toMap());
    } on FirebaseException catch (e) {
      throw APIException(
        message: e.message ?? 'Unknown error has occurred',
        statusCode: e.code,
      );
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: '500',
      );
    }
  }
}
