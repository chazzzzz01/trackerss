import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/recipient.dart';
import '../repositories/recipient_repositories.dart';

class GetRecipients {
  final RecipientRepository repository;

  GetRecipients({required this.repository});

  Future<Either<Failure, List<Recipient>>> call({String? searchQuery}) async =>
    await repository.getRecipients(searchQuery: searchQuery);
  
}
