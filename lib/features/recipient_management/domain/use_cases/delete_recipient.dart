import '../repositories/recipient_repositories.dart';

class DeleteRecipient {
  final RecipientRepository repository;

  DeleteRecipient({required this.repository});

  Future<void> call(String id) async {
    await repository.deleteRecipient(id);
  }
}
