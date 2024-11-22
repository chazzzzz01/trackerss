import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/category_repositories.dart';

class DeleteCategory {
  final CategoryRepository repository;

  DeleteCategory({required this.repository});

  Future<Either<Failure, void>> call(String id) async =>
    repository.deleteCategory(id);
  }

