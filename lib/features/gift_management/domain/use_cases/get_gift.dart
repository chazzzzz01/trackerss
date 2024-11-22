import '../entities/gift.dart';
import '../repositories/gift_repositories.dart';

class GetGifts {
  final GiftRepository repository;

  GetGifts({required this.repository});

  Future<List<Gift>> call({String? filterBy, String? sortBy}) async {
    return await repository.getGifts(filterBy: filterBy, sortBy: sortBy);
  }
}
