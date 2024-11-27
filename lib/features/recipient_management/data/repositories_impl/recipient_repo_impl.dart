import 'package:dartz/dartz.dart';
import 'package:trackerss/core/errors/exceptions.dart';
import 'package:trackerss/core/errors/failure.dart';
import 'package:trackerss/features/recipient_management/data/data_source/recipient_remote_datasource.dart';
import 'package:trackerss/features/recipient_management/domain/entities/recipient.dart';
import 'package:trackerss/features/recipient_management/domain/repositories/recipient_repositories.dart';

class RecipientRepositoryImplementation implements RecipientRepository {

  final RecipientRemoteDataSource _remoteDataSource;

  const RecipientRepositoryImplementation(this._remoteDataSource);

  @override
  Future<Either<Failure, void>> createRecipient(Recipient recipient) async {
    try {
      return Right(await _remoteDataSource.createRecipient(recipient));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    } on Exception catch(e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteRecipient(String id) async {
    try {
    return Right(await _remoteDataSource.deleteRecipient(id));
  } on APIException catch (e) {
    return Left(APIFailure(message: e.message, statusCode: e.statusCode));
  } on Exception catch (e) {
    return Left(GeneralFailure(message: e.toString()));
  }
  }

  @override
  Future<Either<Failure, List<Recipient>>> getRecipients({String? searchQuery}) async {
    try {
    return Right(await _remoteDataSource.getRecipients());
  } on APIException catch (e) {
    return Left(APIFailure(message: e.message, statusCode: e.statusCode));
  } on Exception catch (e) {
    return Left(GeneralFailure(message: e.toString()));
  }
  }

  @override
  Future<Either<Failure, void>> updateRecipient(Recipient recipient) async {
     try {
    return Right(await _remoteDataSource.updateRecipient(recipient));
  } on APIException catch (e) {
    return Left(APIFailure(message: e.message, statusCode: e.statusCode));
  } on Exception catch (e) {
    return Left(GeneralFailure(message: e.toString()));
  }
  }
  
}