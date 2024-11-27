import 'package:trackerss/features/recipient_management/domain/entities/recipient.dart';

abstract interface class RecipientRemoteDataSource {
  Future<void> createRecipient(Recipient recipient);
  Future<List<Recipient>> getRecipients({String? searchQuery});
  Future<void> updateRecipient(Recipient recipient);
  Future<void> deleteRecipient(String id);
}