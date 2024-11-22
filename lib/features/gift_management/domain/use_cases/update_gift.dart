import '../entities/gift.dart';
import '../repositories/gift_repositories.dart';

class UpdateGift {
  final GiftRepository repository;

  UpdateGift({required this.repository});

  Future<void> call(Gift gift) async {
    await repository.updateGift(gift);
  }
}
