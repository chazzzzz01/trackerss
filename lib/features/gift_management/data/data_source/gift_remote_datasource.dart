import 'package:trackerss/features/gift_management/domain/entities/gift.dart';

abstract class GiftRemoteDataSource {
  Future<void> createGift(Gift gift);
  Future<List<Gift>> getGifts({String? filterBy, String? sortBy});
  Future<void> updateGift(Gift gift);
  Future<void> deleteGift(String id);
}