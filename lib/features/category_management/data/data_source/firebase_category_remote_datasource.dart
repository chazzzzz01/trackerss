import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trackerss/core/errors/exceptions.dart';
import 'package:trackerss/features/category_management/data/data_source/category_remote_datasource.dart';
import 'package:trackerss/features/category_management/data/models/category_model.dart';
import 'package:trackerss/features/category_management/domain/entities/category.dart';

class CategoryFirebaseRemoteDataSource implements CategoryRemoteDataSource {
  final FirebaseFirestore _firestore;

  CategoryFirebaseRemoteDataSource(this._firestore);

  @override
  Future<void> createCategory(Category category) async {
    try {
      final categoryDocRef = _firestore.collection('categories').doc('1'); // Fixed ID: '1'
      final categoryModel = CategoryModel(
        id: categoryDocRef.id,
        name: category.name,
        icon: category.icon,
        color: category.color,
       
      );
      await categoryDocRef.set(categoryModel.toMap());
    } on FirebaseException catch (e) {
      throw APIException(
          message: e.message ?? 'Unknown error has occurred',
          statusCode: e.code);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '500');
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    try {
      await _firestore.collection('categories').doc(id).delete();
    } on FirebaseException catch (e) {
      throw APIException(
          message: e.message ?? 'Unknown error has occurred',
          statusCode: e.code);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '500');
    }
  }

  @override
  Future<List<Category>> getCategories() async {
    try {
      final querySnapshot =
          await _firestore.collection('categories').get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Category(
          id: data['id'],
          name: data['name'],
          icon: data['icon'],
          color: data['color'],
         
        );
      }).toList();
    } on FirebaseException catch (e) {
      throw APIException(
          message: e.message ?? 'Unknown error has occurred',
          statusCode: e.code);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '500');
    }
  }

  @override
  Future<void> updateCategory(Category category) async {
    final categoryModel = CategoryModel(
      id: category.id,
      name: category.name,
      icon: category.icon,
      color: category.color,
     
    );
    try {
      await _firestore
          .collection('categories')
          .doc(category.id)
          .update(categoryModel.toMap());
    } on FirebaseException catch (e) {
      throw APIException(
          message: e.message ?? 'Unknown error has occurred',
          statusCode: e.code);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '500');
    }
  }
}
