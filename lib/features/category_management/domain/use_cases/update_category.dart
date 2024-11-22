import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/category.dart';
import '../repositories/category_repositories.dart';

class UpdateCategory {
  final CategoryRepository repository;

  UpdateCategory({required this.repository});

  Future<Either<Failure, void>> call(Category category) async =>
    await repository.updateCategory(category);
  }

