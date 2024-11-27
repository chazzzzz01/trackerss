import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/recipient.dart';
import '../repositories/recipient_repositories.dart';

class CreateRecipient {
  final RecipientRepository repository;

  CreateRecipient({required this.repository});

  Future<Either<Failure,void>> call(Recipient recipient) async =>
    repository.createRecipient(recipient);
  }

