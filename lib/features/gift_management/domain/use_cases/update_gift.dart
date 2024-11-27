import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/gift.dart';
import '../repositories/gift_repositories.dart';

class UpdateGift {
  final GiftRepository repository;

  UpdateGift({required this.repository});

  Future<Either<Failure, void>> call(Gift gift) async =>
     repository.updateGift(gift);
  }

