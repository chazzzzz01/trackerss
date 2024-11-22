import '../entities/recipient.dart';
import '../repositories/recipient_repositories.dart';

class UpdateRecipient {
  final RecipientRepository repository;

  UpdateRecipient({required this.repository});

  Future<void> call(Recipient recipient) async {
    await repository.updateRecipient(recipient);
  }
}
