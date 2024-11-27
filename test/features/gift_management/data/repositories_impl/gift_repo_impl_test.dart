import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:trackerss/core/errors/failure.dart';
import 'package:trackerss/features/gift_management/data/repositories_impl/gift_repo_impl.dart';
import 'package:trackerss/features/gift_management/domain/entities/gift.dart';

import 'gift_remote_datasource.mock.dart';



void main() {
  late MockGiftRemoteDataSource mockGiftRemoteDataSource;
  late GiftRepositoryImplementation giftRepositoryUnderTest;

  setUp(() {
    mockGiftRemoteDataSource = MockGiftRemoteDataSource();
    giftRepositoryUnderTest = GiftRepositoryImplementation(mockGiftRemoteDataSource);
  });

 
    final testGift = Gift(
      id: '1',
      name: 'Test Gift',
      description: 'Test Description',
      category: 'Electronics',
      recipientId: '123',
      occasionDate: DateTime(2024, 12, 25),
      status: 'Pending',
      price: 100.0,
      notes: 'Test notes',
    );


  

   group('createGift', () {
    test('should return Right(void) when creation succeeds', () async {
      // Arrange
      when(() => mockGiftRemoteDataSource.createGift(testGift))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await giftRepositoryUnderTest.createGift(testGift);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockGiftRemoteDataSource.createGift(testGift)).called(1);
      verifyNoMoreInteractions(mockGiftRemoteDataSource);
    });

    test('should return Left(Failure) when creation fails', () async {
      // Arrange
      when(() => mockGiftRemoteDataSource.createGift(testGift))
          .thenThrow(Exception('Error creating gift'));

      // Act
      final result = await giftRepositoryUnderTest.createGift(testGift);

      // Assert
      expect(result, isA<Left<Failure, void>>());
      verify(() => mockGiftRemoteDataSource.createGift(testGift)).called(1);
      verifyNoMoreInteractions(mockGiftRemoteDataSource);
    });
  });

  
 group('getGifts', () {
  test('should return Right(List<Gift>) when getGifts succeeds', () async {
    // Arrange
    final testGift = Gift(
      id: '1',
      name: 'Test Gift',
      description: 'Test Description',
      category: 'Electronics',
      recipientId: '123',
      occasionDate: DateTime(2024, 12, 25),
      status: 'Pending',
      price: 100.0,
      notes: 'Test notes',
    );
    final testGifts = [testGift]; // A list of gifts

    // Stub the method to return a list of gifts wrapped in a Future
    when(() => mockGiftRemoteDataSource.getGifts())
        .thenAnswer((_) async => testGifts);

    // Act
    final result = await giftRepositoryUnderTest.getGifts();

    // Assert
    // Expect the result to be a Right containing a List of Gifts
    expect(result, equals(Right<Failure, List<Gift>>(testGifts))); // Compare to the list of gifts
    verify(() => mockGiftRemoteDataSource.getGifts()).called(1);
    verifyNoMoreInteractions(mockGiftRemoteDataSource);
  });

    test('should return Left(Failure) when getCategories fails', () async {
      // Arrange
      when(() => mockGiftRemoteDataSource.getGifts())
          .thenThrow(Exception());

      // Act
      final result = await giftRepositoryUnderTest.getGifts();

      // Assert
      expect(result, isA<Left<Failure, List<Gift>>>());
      verify(() => mockGiftRemoteDataSource.getGifts()).called(1);
      verifyNoMoreInteractions(mockGiftRemoteDataSource);
    });
  });

    group('deleteGift', () {
    const testId = '1';

    test('should return Right(void) when deleteCategory succeeds', () async {
      // Arrange
      when(() => mockGiftRemoteDataSource.deleteGift(testId))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await giftRepositoryUnderTest.deleteGift(testId);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockGiftRemoteDataSource.deleteGift(testId)).called(1);
      verifyNoMoreInteractions(mockGiftRemoteDataSource);
    });

    test('should return Left(Failure) when deleteCategory fails', () async {
      // Arrange
      when(() => mockGiftRemoteDataSource.deleteGift(testId))
          .thenThrow(Exception());

      // Act
      final result = await giftRepositoryUnderTest.deleteGift(testId);

      // Assert
      expect(result, isA<Left<Failure, void>>());
      verify(() => mockGiftRemoteDataSource.deleteGift(testId)).called(1);
      verifyNoMoreInteractions(mockGiftRemoteDataSource);
    });
  });

  group('updateCategory', () {
    test('should return Right(void) when updateCategory succeeds', () async {
      // Arrange
      when(() => mockGiftRemoteDataSource.updateGift(testGift))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await giftRepositoryUnderTest.updateGift(testGift);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockGiftRemoteDataSource.updateGift(testGift)).called(1);
      verifyNoMoreInteractions(mockGiftRemoteDataSource);
    });

    test('should return Left(Failure) when updateCategory fails', () async {
      // Arrange
      when(() => mockGiftRemoteDataSource.updateGift(testGift))
          .thenThrow(Exception());

      // Act
      final result = await giftRepositoryUnderTest.updateGift(testGift);

      // Assert
      expect(result, isA<Left<Failure, void>>());
      verify(() => mockGiftRemoteDataSource.updateGift(testGift)).called(1);
      verifyNoMoreInteractions(mockGiftRemoteDataSource);
    });
  });
  
}


