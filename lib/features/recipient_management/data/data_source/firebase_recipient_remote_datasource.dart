import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trackerss/core/errors/exceptions.dart';
import 'package:trackerss/features/recipient_management/data/data_source/recipient_remote_datasource.dart';
import 'package:trackerss/features/recipient_management/data/models/recipient_model.dart';
import 'package:trackerss/features/recipient_management/domain/entities/recipient.dart';

class RecipientFirebaseRemoteDatasource implements RecipientRemoteDataSource {
  final FirebaseFirestore _firestore;

  RecipientFirebaseRemoteDatasource(this._firestore);

  @override
  Future<void> createRecipient(Recipient recipient) async {
    try {
      final recipientDocRef = _firestore.collection('recipients').doc('123'); // Fixed ID: '123'
      final recipientModel = RecipientModel(
        id: recipientDocRef.id,
        name: recipient.name,
        contactDetails: recipient.contactDetails,
        notes: recipient.notes,
      );
      await recipientDocRef.set(recipientModel.toMap());
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
  Future<void> deleteRecipient(String id) async {
    try {
      await _firestore.collection('recipients').doc(id).delete();
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
   Future<List<Recipient>> getRecipients({String? searchQuery}) async {
    try {
      final querySnapshot = await _firestore.collection('recipients').get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Recipient(
          id: data['id'],
          name: data['name'],
          contactDetails: data['contactDetails'],
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
  Future<void> updateRecipient(Recipient recipient) async {
    final recipientModel = RecipientModel(
      id: recipient.id,
      name: 'John Doe',
      contactDetails: 'johndoe@example.com',
      notes: 'Test notes',
    );
    try {
      await _firestore
          .collection('recipients')
          .doc(recipient.id)
          .update(recipientModel.toMap());
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
