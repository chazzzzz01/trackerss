part of 'gift_cubit.dart';

// Base state for GiftCubit
abstract class GiftState extends Equatable {
  const GiftState();

  @override
  List<Object?> get props => [];
}

// Initial State
class GiftInitial extends GiftState {}

// Loading State
class GiftLoading extends GiftState {}

// Loaded State (with List<Gift>)
class GiftLoaded extends GiftState {
  final List<Gift> gifts;

  const GiftLoaded({required this.gifts});

  @override
  List<Object?> get props => [gifts];
}

// Added State
class GiftAdded extends GiftState {}

// Deleted State
class GiftDeleted extends GiftState {}

// Updated State (with updated Gift)
class GiftUpdated extends GiftState {
  final Gift updatedGift;

  const GiftUpdated(this.updatedGift);

  @override
  List<Object?> get props => [updatedGift];
}

// Error State (with error message)
class GiftError extends GiftState {
  final String message;

  const GiftError(this.message);

  @override
  List<Object?> get props => [message];
}
