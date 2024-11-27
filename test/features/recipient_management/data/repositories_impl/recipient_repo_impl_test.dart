import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:trackerss/core/errors/failure.dart';
import 'package:trackerss/features/recipient_management/data/repositories_impl/recipient_repo_impl.dart';
import 'package:trackerss/features/recipient_management/domain/entities/recipient.dart';

import 'recipient_remote_datasource.mock.dart'; // For Either type


void main() {
  late RecipientRepositoryImplementation recipientRepositoryUnderTest;
  late MockRecipientRemoteDataSource mockRecipientRemoteDataSource;

  setUp(() {
    mockRecipientRemoteDataSource = MockRecipientRemoteDataSource();
    recipientRepositoryUnderTest = RecipientRepositoryImplementation(mockRecipientRemoteDataSource);
  });

 
    const testRecipient = Recipient(
      id: '123',
      name: 'John Doe',
      contactDetails: 'johndoe@example.com',
      notes: 'Test notes',
    );


  group('createRecipient', () {
    test('should return void when the data source successfully creates a recipient', () async {
      // Arrange
      when(() => mockRecipientRemoteDataSource.createRecipient(testRecipient))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await recipientRepositoryUnderTest.createRecipient(testRecipient);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockRecipientRemoteDataSource.createRecipient(testRecipient)).called(1);
      verifyNoMoreInteractions(mockRecipientRemoteDataSource);
    });

    test('should return Left(Failure) when creation fails', () async {
      // Arrange
      when(() => mockRecipientRemoteDataSource.createRecipient(testRecipient))
          .thenThrow(Exception('Error creating recipient'));

      // Act
      final result = await recipientRepositoryUnderTest.createRecipient(testRecipient);

      // Assert
      expect(result, isA<Left<Failure, void>>());
      verify(() => mockRecipientRemoteDataSource.createRecipient(testRecipient)).called(1);
      verifyNoMoreInteractions(mockRecipientRemoteDataSource);
    });
  });
  
  group('getRecipients', () {
    test('should return Right(List<Recipient>) when getRecipients succeeds', () async {
      // Arrange
      const testRecipient = Recipient(
        id: '1',
        name: 'Test Name',
        contactDetails: '1234567890',
        notes: 'Test Notes',
      );
      final testRecipients = [testRecipient];
      when(() => mockRecipientRemoteDataSource.getRecipients(searchQuery: any(named: 'searchQuery')))
          .thenAnswer((_) async => testRecipients);

      // Act
      final result = await recipientRepositoryUnderTest.getRecipients();

      // Assert
      expect(result, equals(Right<Failure, List<Recipient>>(testRecipients)));
      verify(() => mockRecipientRemoteDataSource.getRecipients(searchQuery: any(named: 'searchQuery')))
          .called(1);
      verifyNoMoreInteractions(mockRecipientRemoteDataSource);
    });

    test('should return Left(Failure) when getRecipients fails', () async {
      // Arrange
      when(() => mockRecipientRemoteDataSource.getRecipients(searchQuery: any(named: 'searchQuery')))
          .thenThrow(Exception());

      // Act
      final result = await recipientRepositoryUnderTest.getRecipients();

      // Assert
      expect(result, isA<Left<Failure, List<Recipient>>>());
      verify(() => mockRecipientRemoteDataSource.getRecipients(searchQuery: any(named: 'searchQuery')))
          .called(1);
      verifyNoMoreInteractions(mockRecipientRemoteDataSource);
    });
  });

  group('deleteRecipient', () {
    const testId = '1';

    test('should return Right(void) when deleteRecipient succeeds', () async {
      // Arrange
      when(() => mockRecipientRemoteDataSource.deleteRecipient(testId))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await recipientRepositoryUnderTest.deleteRecipient(testId);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockRecipientRemoteDataSource.deleteRecipient(testId)).called(1);
      verifyNoMoreInteractions(mockRecipientRemoteDataSource);
    });

    test('should return Left(Failure) when deleteRecipient fails', () async {
      // Arrange
      when(() => mockRecipientRemoteDataSource.deleteRecipient(testId))
          .thenThrow(Exception());

      // Act
      final result = await recipientRepositoryUnderTest.deleteRecipient(testId);

      // Assert
      expect(result, isA<Left<Failure, void>>());
      verify(() => mockRecipientRemoteDataSource.deleteRecipient(testId)).called(1);
      verifyNoMoreInteractions(mockRecipientRemoteDataSource);
    });
  });

  group('updateRecipient', () {
    const testRecipient = Recipient(
      id: '1',
      name: 'Updated Name',
      contactDetails: '0987654321',
      notes: 'Updated Notes',
    );

    test('should return Right(void) when updateRecipient succeeds', () async {
      // Arrange
      when(() => mockRecipientRemoteDataSource.updateRecipient(testRecipient))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await recipientRepositoryUnderTest.updateRecipient(testRecipient);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockRecipientRemoteDataSource.updateRecipient(testRecipient)).called(1);
      verifyNoMoreInteractions(mockRecipientRemoteDataSource);
    });

    test('should return Left(Failure) when updateRecipient fails', () async {
      // Arrange
      when(() => mockRecipientRemoteDataSource.updateRecipient(testRecipient))
          .thenThrow(Exception());

      // Act
      final result = await recipientRepositoryUnderTest.updateRecipient(testRecipient);

      // Assert
      expect(result, isA<Left<Failure, void>>());
      verify(() => mockRecipientRemoteDataSource.updateRecipient(testRecipient)).called(1);
      verifyNoMoreInteractions(mockRecipientRemoteDataSource);
    });
  });
}
