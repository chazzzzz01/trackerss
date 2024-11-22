import '../entities/recipient.dart';
import '../repositories/recipient_repositories.dart';

class CreateRecipient {
  final RecipientRepository repository;

  CreateRecipient({required this.repository});

  Future<void> call(Recipient recipient) async {
    await repository.createRecipient(recipient);
  }
}
