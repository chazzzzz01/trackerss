import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:trackerss/core/errors/failure.dart';
import 'package:trackerss/features/gift_management/domain/entities/gift.dart';
import 'package:trackerss/features/gift_management/domain/use_cases/create_gift.dart';
import 'package:trackerss/features/gift_management/domain/use_cases/delete_gift.dart';
import 'package:trackerss/features/gift_management/domain/use_cases/get_gift.dart';
import 'package:trackerss/features/gift_management/domain/use_cases/update_gift.dart';

part 'gift_state.dart';

const String noInternetErrorMessage =
    "Sync Failed: Changes saved on your device and will sync once you're back online.";

class GiftCubit extends Cubit<GiftState> {
  final CreateGift createGiftUseCase;
  final DeleteGift deleteGiftUseCase;
  final GetGifts getGiftsUseCase;
  final UpdateGift updateGiftUseCase;

  GiftCubit({
    required this.createGiftUseCase,
    required this.deleteGiftUseCase,
    required this.getGiftsUseCase,
    required this.updateGiftUseCase,
  }) : super(GiftInitial());

  // Fetch all gifts
  Future<void> getAllGifts() async {
    emit(GiftLoading());

    try {
      final Either<Failure, List<Gift>> result = await getGiftsUseCase
          .call()
          .timeout(const Duration(seconds: 10),
              onTimeout: () => throw TimeoutException("Request timed out"));

      result.fold(
        (failure) => emit(GiftError(failure.getMessage())),
        (gifts) {
          emit(GiftLoaded(gifts: gifts));
        },
      );
    } on TimeoutException catch (_) {
      emit(const GiftError(
          "There seems to be a problem with your Internet connection"));
    }
  }

  // Create a new gift
  Future<void> createGift(Gift gift) async {
    emit(GiftLoading());

    try {
      final Either<Failure, void> result = await createGiftUseCase
          .call(gift)
          .timeout(const Duration(seconds: 10),
              onTimeout: () => throw TimeoutException("Request timed out"));

      result.fold(
        (failure) => emit(GiftError(failure.getMessage())),
        (_) {
          emit(GiftAdded());
        },
      );
    } catch (_) {
      emit(const GiftError(noInternetErrorMessage));
    }
  }

  // Update an existing gift
  Future<void> updateGift(Gift gift) async {
    emit(GiftLoading());

    try {
      final Either<Failure, void> result = await updateGiftUseCase
          .call(gift)
          .timeout(const Duration(seconds: 10),
              onTimeout: () => throw TimeoutException("Request timed out"));

      result.fold(
        (failure) => emit(GiftError(failure.getMessage())),
        (_) {
          emit(GiftUpdated(gift));
        },
      );
    } catch (_) {
      emit(const GiftError(noInternetErrorMessage));
    }
  }

  // Delete a gift
  Future<void> deleteGift(String giftId) async {
    emit(GiftLoading());

    try {
      final Either<Failure, void> result = await deleteGiftUseCase
          .call(giftId)
          .timeout(const Duration(seconds: 10),
              onTimeout: () => throw TimeoutException("Request timed out"));

      result.fold(
        (failure) => emit(GiftError(failure.getMessage())),
        (_) {
          emit(GiftDeleted());
        },
      );
    } catch (_) {
      emit(const GiftError(noInternetErrorMessage));
    }
  }
}
