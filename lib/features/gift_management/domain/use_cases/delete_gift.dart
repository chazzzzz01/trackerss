import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/gift_repositories.dart';

class DeleteGift {
  final GiftRepository repository;

  DeleteGift({required this.repository});

  Future<Either<Failure, void>> call(String id) async =>
     repository.deleteGift(id);
  }

