import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/recipient.dart';

abstract class RecipientRepository {
  Future<Either<Failure, void>> createRecipient(Recipient recipient);
  Future<Either<Failure, List<Recipient>>> getRecipients({String? searchQuery});
  Future<Either<Failure, void>> updateRecipient(Recipient recipient);
  Future<Either<Failure, void>> deleteRecipient(String id);
}
