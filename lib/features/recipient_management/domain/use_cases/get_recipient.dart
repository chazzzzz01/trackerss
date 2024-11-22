import '../entities/recipient.dart';
import '../repositories/recipient_repositories.dart';

class GetRecipients {
  final RecipientRepository repository;

  GetRecipients({required this.repository});

  Future<List<Recipient>> call({String? searchQuery}) async {
    return await repository.getRecipients(searchQuery: searchQuery);
  }
}
