part of 'recipient_cubit.dart';

// Base state for RecipientCubit
abstract class RecipientState extends Equatable {
  const RecipientState();

  @override
  List<Object?> get props => [];
}

// Initial State
class RecipientInitial extends RecipientState {}

// Loading State
class RecipientLoading extends RecipientState {}

// Loaded State (with List<Recipient>)
class RecipientLoaded extends RecipientState {
  final List<Recipient> recipients;

  const RecipientLoaded({required this.recipients});

  @override
  List<Object?> get props => [recipients];
}

// Added State
class RecipientAdded extends RecipientState {}

// Deleted State
class RecipientDeleted extends RecipientState {}

// Updated State (with updated Recipient)
class RecipientUpdated extends RecipientState {
  final Recipient updatedRecipient;

  const RecipientUpdated(this.updatedRecipient);

  @override
  List<Object?> get props => [updatedRecipient];
}

// Error State (with error message)
class RecipientError extends RecipientState {
  final String message;

  const RecipientError(this.message);

  @override
  List<Object?> get props => [message];
}
