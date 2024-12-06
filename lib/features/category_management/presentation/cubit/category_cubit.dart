import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:trackerss/core/errors/failure.dart';
import 'package:trackerss/features/category_management/domain/entities/category.dart';
import 'package:trackerss/features/category_management/domain/use_cases/create_category.dart';
import 'package:trackerss/features/category_management/domain/use_cases/delete_category.dart';
import 'package:trackerss/features/category_management/domain/use_cases/get_category.dart';
import 'package:trackerss/features/category_management/domain/use_cases/update_category.dart';

part 'category_state.dart';

const String noInternetErrorMessage =
    "Sync Failed: Changes saved on your device and will sync once you're back online.";

class CategoryCubit extends Cubit<CategoryState> {
  final CreateCategory createCategoryUseCase;
  final DeleteCategory deleteCategoryUseCase;
  final GetCategories getCategoriesUseCase;
  final UpdateCategory updateCategoryUseCase;

  CategoryCubit({
    required this.createCategoryUseCase,
    required this.deleteCategoryUseCase,
    required this.getCategoriesUseCase,
    required this.updateCategoryUseCase,
  }) : super(CategoryInitial());

  

  // Get categories and cache them locally
  Future<void> getAllCategories() async {
    emit(CategoryLoading());

    try {
      final Either<Failure, List<Category>> result = await getCategoriesUseCase
          .call()
          .timeout(const Duration(seconds: 10),
              onTimeout: () => throw TimeoutException("Request timed out"));

      result.fold(
        (failure) => emit(CategoryError(failure.getMessage())),
        (categories) {
          emit(CategoryLoaded(categories: categories));
        },
      );
    } on TimeoutException catch (_) {
      emit(const CategoryError(
          "There seems to be a problem with your Internet connection"));
    }
  }

  // Create a category
  Future<void> createCategory(Category category) async {
    emit(CategoryLoading());

    try {
      final Either<Failure, void> result = await createCategoryUseCase
          .call(category)
          .timeout(const Duration(seconds: 10),
              onTimeout: () => throw TimeoutException("Request timed out"));

      result.fold(
        (failure) => emit(CategoryError(failure.getMessage())),
        (_) {
          emit(CategoryAdded());
        },
      );
    } catch (_) {
      emit(const CategoryError(noInternetErrorMessage));
    }
  }

  // Update a category
  Future<void> updateCategory(Category category) async {
    emit(CategoryLoading());

    try {
      final Either<Failure, void> result = await updateCategoryUseCase
          .call(category)
          .timeout(const Duration(seconds: 10),
              onTimeout: () => throw TimeoutException("Request timed out"));

      result.fold(
        (failure) => emit(CategoryError(failure.getMessage())),
        (_) {
          emit(CategoryUpdated(category));
        },
      );
    } catch (_) {
      emit(const CategoryError(noInternetErrorMessage));
    }
  }

  // Delete a category
  Future<void> deleteCategory(Category category) async {
    emit(CategoryLoading());

    try {
      final Either<Failure, void> result = await deleteCategoryUseCase(category.id).timeout(
           const Duration(seconds: 10),
              onTimeout: () => throw TimeoutException("Request timed out"));

      result.fold(
        (failure) => emit(CategoryError(failure.getMessage())),
        (_) {
          emit(CategoryDeleted());
        },
      );
    } catch (_) {
      emit(const CategoryError(noInternetErrorMessage));
    }
  }
}
