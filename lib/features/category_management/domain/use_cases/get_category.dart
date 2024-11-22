import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/category.dart';
import '../repositories/category_repositories.dart';

class GetCategories {
  final CategoryRepository repository;

  GetCategories({required this.repository});

  Future<Either<Failure, List<Category>>> call() async {
    return await repository.getCategories();
  }
}
