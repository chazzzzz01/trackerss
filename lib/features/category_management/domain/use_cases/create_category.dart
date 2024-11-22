import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/category.dart';
import '../repositories/category_repositories.dart';

class CreateCategory {
  final CategoryRepository repository;

  CreateCategory({required this.repository});

  Future<Either<Failure, void>> call(Category category) async =>
    repository.createCategory(category);
  }

