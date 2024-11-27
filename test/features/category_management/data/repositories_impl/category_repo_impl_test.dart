import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:trackerss/core/errors/failure.dart';
import 'package:trackerss/features/category_management/data/repositories_impl/category_repo_impl.dart';
import 'package:trackerss/features/category_management/domain/entities/category.dart';

import 'category_remote_datasource.mock.dart';





void main() {
  late CategoryRepositoryImplementation categoryRepositoryUnderTest;
  late MockCategoryRemoteDataSource mockCategoryRemoteDataSource;

  setUp(() {
    mockCategoryRemoteDataSource = MockCategoryRemoteDataSource();
    categoryRepositoryUnderTest = CategoryRepositoryImplementation(mockCategoryRemoteDataSource); // Adjust constructor if necessary.
  });

  
    const testCategory = Category(
      id: '1',
      name: 'Test Category',
      icon: 'test_icon',
      color: 'blue',
    );

  group('createCategory', () {
    test('should return Right(void) when createCategory succeeds', () async {
      // Arrange
      when(() => mockCategoryRemoteDataSource.createCategory(testCategory))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await categoryRepositoryUnderTest.createCategory(testCategory);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockCategoryRemoteDataSource.createCategory(testCategory)).called(1);
      verifyNoMoreInteractions(mockCategoryRemoteDataSource);
    });

    test('should return Left(Failure) when createCategory fails', () async {
      // Arrange
      when(() => mockCategoryRemoteDataSource.createCategory(testCategory))
          .thenThrow(Exception());

      // Act
      final result = await categoryRepositoryUnderTest.createCategory(testCategory);

      // Assert
      expect(result, isA<Left<Failure, void>>());
      verify(() => mockCategoryRemoteDataSource.createCategory(testCategory)).called(1);
      verifyNoMoreInteractions(mockCategoryRemoteDataSource);
    });
  });


  group('getCategories', () {
    test('should return Right(List<Category>) when getCategories succeeds', () async {
      // Arrange
      final testCategories = [testCategory];
      when(() => mockCategoryRemoteDataSource.getCategories())
          .thenAnswer((_) async => testCategories);

      // Act
      final result = await categoryRepositoryUnderTest.getCategories();

      // Assert
      expect(result, equals(Right(testCategories)));
      verify(() => mockCategoryRemoteDataSource.getCategories()).called(1);
      verifyNoMoreInteractions(mockCategoryRemoteDataSource);
    });

    test('should return Left(Failure) when getCategories fails', () async {
      // Arrange
      when(() => mockCategoryRemoteDataSource.getCategories())
          .thenThrow(Exception());

      // Act
      final result = await categoryRepositoryUnderTest.getCategories();

      // Assert
      expect(result, isA<Left<Failure, List<Category>>>());
      verify(() => mockCategoryRemoteDataSource.getCategories()).called(1);
      verifyNoMoreInteractions(mockCategoryRemoteDataSource);
    });
  });

  group('deleteCategory', () {
    const testId = '1';

    test('should return Right(void) when deleteCategory succeeds', () async {
      // Arrange
      when(() => mockCategoryRemoteDataSource.deleteCategory(testId))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await categoryRepositoryUnderTest.deleteCategory(testId);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockCategoryRemoteDataSource.deleteCategory(testId)).called(1);
      verifyNoMoreInteractions(mockCategoryRemoteDataSource);
    });

    test('should return Left(Failure) when deleteCategory fails', () async {
      // Arrange
      when(() => mockCategoryRemoteDataSource.deleteCategory(testId))
          .thenThrow(Exception());

      // Act
      final result = await categoryRepositoryUnderTest.deleteCategory(testId);

      // Assert
      expect(result, isA<Left<Failure, void>>());
      verify(() => mockCategoryRemoteDataSource.deleteCategory(testId)).called(1);
      verifyNoMoreInteractions(mockCategoryRemoteDataSource);
    });
  });

  group('updateCategory', () {
    test('should return Right(void) when updateCategory succeeds', () async {
      // Arrange
      when(() => mockCategoryRemoteDataSource.updateCategory(testCategory))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await categoryRepositoryUnderTest.updateCategory(testCategory);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockCategoryRemoteDataSource.updateCategory(testCategory)).called(1);
      verifyNoMoreInteractions(mockCategoryRemoteDataSource);
    });

    test('should return Left(Failure) when updateCategory fails', () async {
      // Arrange
      when(() => mockCategoryRemoteDataSource.updateCategory(testCategory))
          .thenThrow(Exception());

      // Act
      final result = await categoryRepositoryUnderTest.updateCategory(testCategory);

      // Assert
      expect(result, isA<Left<Failure, void>>());
      verify(() => mockCategoryRemoteDataSource.updateCategory(testCategory)).called(1);
      verifyNoMoreInteractions(mockCategoryRemoteDataSource);
    });
  });
  
}