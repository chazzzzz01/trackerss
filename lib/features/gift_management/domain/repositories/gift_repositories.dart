import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/gift.dart';

abstract class GiftRepository {
  Future<Either<Failure, void>> createGift(Gift gift);
  Future<Either<Failure, List<Gift>>> getGifts({String? filterBy, String? sortBy});
  Future<Either<Failure, void>> updateGift(Gift gift);
  Future<Either<Failure, void>> deleteGift(String id);
}
