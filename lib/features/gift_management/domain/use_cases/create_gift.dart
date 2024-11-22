import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/gift.dart';
import '../repositories/gift_repositories.dart';

class CreateGift {
  final GiftRepository repository;

  CreateGift({required this.repository});

  Future<Either<Failure, void>> call(Gift gift) async =>
     repository.createGift(gift);
  }

