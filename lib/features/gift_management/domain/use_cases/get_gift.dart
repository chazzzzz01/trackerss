import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/gift.dart';
import '../repositories/gift_repositories.dart';

class GetGifts {
  final GiftRepository repository;

  GetGifts({required this.repository});

  Future<Either<Failure, List<Gift>>> call({String? filterBy, String? sortBy}) async {
    return await repository.getGifts(filterBy: filterBy, sortBy: sortBy);
  }
}
