import '../entities/recipient.dart';

abstract class RecipientRepository {
  Future<void> createRecipient(Recipient recipient);
  Future<List<Recipient>> getRecipients({String? searchQuery});
  Future<void> updateRecipient(Recipient recipient);
  Future<void> deleteRecipient(String id);
}
