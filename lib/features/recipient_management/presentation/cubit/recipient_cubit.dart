import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trackerss/features/recipient_management/domain/entities/recipient.dart';
import 'package:trackerss/features/recipient_management/domain/use_cases/create_recipient.dart';
import 'package:trackerss/features/recipient_management/domain/use_cases/delete_recipient.dart';
import 'package:trackerss/features/recipient_management/domain/use_cases/get_recipient.dart';
import 'package:trackerss/features/recipient_management/domain/use_cases/update_recipient.dart';

part 'recipient_state.dart';

const String noInternetErrorMessage =
    "Sync Failed: Changes saved on your device and will sync once you're back online.";

class RecipientCubit extends Cubit<RecipientState> {
  final CreateRecipient createRecipientUseCase;
  final DeleteRecipient deleteRecipientUseCase;
  final GetRecipients getRecipientsUseCase;
  final UpdateRecipient updateRecipientUseCase;

  RecipientCubit({
    required this.createRecipientUseCase,
    required this.deleteRecipientUseCase,
    required this.getRecipientsUseCase,
    required this.updateRecipientUseCase,
  }) : super(RecipientInitial());

  // Fetch all recipients
  Future<void> getAllRecipients() async {
    emit(RecipientLoading());

    try {
      final result = await getRecipientsUseCase
          .call()
          .timeout(const Duration(seconds: 10),
              onTimeout: () => throw TimeoutException("Request timed out"));

      result.fold(
        (failure) => emit(RecipientError(failure.getMessage())),
        (recipients) {
          emit(RecipientLoaded(recipients: recipients));
        },
      );
    } on TimeoutException catch (_) {
      emit(const RecipientError(
          "There seems to be a problem with your Internet connection"));
    } catch (_) {
      emit(const RecipientError(noInternetErrorMessage));
    }
  }

  // Create a new recipient
  Future<void> createRecipient(Recipient recipient) async {
    emit(RecipientLoading());

    try {
      await createRecipientUseCase
          .call(recipient)
          .timeout(const Duration(seconds: 10),
              onTimeout: () => throw TimeoutException("Request timed out"));

      // No need for result.fold since the return type is void.
      emit(RecipientAdded());
    } on TimeoutException {
      emit(const RecipientError("Request timed out. Please try again."));
    } catch (_) {
      emit(const RecipientError(noInternetErrorMessage));
    }
  }

  // Update an existing recipient
  Future<void> updateRecipient(Recipient recipient) async {
    emit(RecipientLoading());

    try {
      await updateRecipientUseCase
          .call(recipient)
          .timeout(const Duration(seconds: 10),
              onTimeout: () => throw TimeoutException("Request timed out"));

      emit(RecipientUpdated(recipient));
    } on TimeoutException {
      emit(const RecipientError("Request timed out. Please try again."));
    } catch (_) {
      emit(const RecipientError(noInternetErrorMessage));
    }
  }

  // Delete a recipient
  Future<void> deleteRecipient(String recipientId) async {
    emit(RecipientLoading());

    try {
      await deleteRecipientUseCase
          .call(recipientId)
          .timeout(const Duration(seconds: 10),
              onTimeout: () => throw TimeoutException("Request timed out"));

      emit(RecipientDeleted());
    } on TimeoutException {
      emit(const RecipientError("Request timed out. Please try again."));
    } catch (_) {
      emit(const RecipientError(noInternetErrorMessage));
    }
  }
}
