import 'package:dartz/dartz.dart';
import 'package:trackerss/core/errors/exceptions.dart';
import 'package:trackerss/core/errors/failure.dart';
import 'package:trackerss/features/category_management/data/data_source/category_remote_datasource.dart';
import 'package:trackerss/features/category_management/domain/entities/category.dart';
import 'package:trackerss/features/category_management/domain/repositories/category_repositories.dart';

class CategoryRepositoryImplementation implements CategoryRepository {
  final CategoryRemoteDataSource _remoteDataSource;

  const CategoryRepositoryImplementation(this._remoteDataSource);

  @override
  Future<Either<Failure, void>> createCategory(Category category)  async {
    try {
      return Right(await _remoteDataSource.createCategory(category));
    } on APIException catch (e) {
      return Left(APIFailure(message: e.message, statusCode: e.statusCode));
    }on Exception catch(e) {
      return Left(GeneralFailure(message: e.toString()));
    }
  }
@override
Future<Either<Failure, void>> deleteCategory(String id) async {
  try {
    return Right(await _remoteDataSource.deleteCategory(id));
  } on APIException catch (e) {
    return Left(APIFailure(message: e.message, statusCode: e.statusCode));
  } on Exception catch (e) {
    return Left(GeneralFailure(message: e.toString()));
  }
}

@override
Future<Either<Failure, List<Category>>> getCategories() async {
  try {
    return Right(await _remoteDataSource.getCategories());
  } on APIException catch (e) {
    return Left(APIFailure(message: e.message, statusCode: e.statusCode));
  } on Exception catch (e) {
    return Left(GeneralFailure(message: e.toString()));
  }
}

@override
Future<Either<Failure, void>> updateCategory(Category category) async {
  try {
    return Right(await _remoteDataSource.updateCategory(category));
  } on APIException catch (e) {
    return Left(APIFailure(message: e.message, statusCode: e.statusCode));
  } on Exception catch (e) {
    return Left(GeneralFailure(message: e.toString()));
  }
}

}