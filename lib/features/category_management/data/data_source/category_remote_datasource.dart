import 'package:trackerss/features/category_management/domain/entities/category.dart';

abstract class CategoryRemoteDataSource {
  Future<void> createCategory(Category category);
  Future<List<Category>> getCategories();
  Future<void> updateCategory(Category category);
  Future<void> deleteCategory(String id);
}