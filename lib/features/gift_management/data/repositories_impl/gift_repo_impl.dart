import 'package:dartz/dartz.dart';
import 'package:trackerss/core/errors/exceptions.dart';
import 'package:trackerss/core/errors/failure.dart';
import 'package:trackerss/features/gift_management/data/data_source/gift_remote_datasource.dart';
import 'package:trackerss/features/gift_management/domain/entities/gift.dart';
import 'package:trackerss/features/gift_management/domain/repositories/gift_repositories.dart';

class GiftRepositoryImplementation implements GiftRepository {
  final GiftRemoteDataSource _remoteDataSource;
  
  const GiftRepositoryImplementation(this._remoteDataSource);

  @override
  Future<Either<Failure, void>> createGift(Gift gift) async{
    try {
      return Right(await _remoteDataSource.createGift(gift));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } on Exception catch(e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteGift(String id) async {
    try {
    return Right(await _remoteDataSource.deleteGift(id));
  } on APIException catch (e) {
    return Left(APIFailure(message: e.message, statusCode: e.statusCode));
  } on Exception catch (e) {
    return Left(GeneralFailure(message: e.toString()));
  }
  }

  @override
  Future<Either<Failure, List<Gift>>> getGifts({String? filterBy, String? sortBy}) async {
     try {
    return Right(await _remoteDataSource.getGifts());
  } on APIException catch (e) {
    return Left(APIFailure(message: e.message, statusCode: e.statusCode));
  } on Exception catch (e) {
    return Left(GeneralFailure(message: e.toString()));
  }
  }

  @override
  Future<Either<Failure, void>> updateGift(Gift gift) async{
    try {
    return Right(await _remoteDataSource.updateGift(gift));
  } on APIException catch (e) {
    return Left(APIFailure(message: e.message, statusCode: e.statusCode));
  } on Exception catch (e) {
    return Left(GeneralFailure(message: e.toString()));
  }
  }
  
}