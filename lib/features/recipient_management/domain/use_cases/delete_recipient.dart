import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/recipient_repositories.dart';

class DeleteRecipient {
  final RecipientRepository repository;

  DeleteRecipient({required this.repository});

  Future<Either<Failure, void>> call(String id) async =>
    repository.deleteRecipient(id);
  }

