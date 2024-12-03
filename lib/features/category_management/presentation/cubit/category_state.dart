part of 'category_cubit.dart';


// Base state for CategoryCubit
abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

// Initial State
class CategoryInitial extends CategoryState {}

// Loading State
class CategoryLoading extends CategoryState {}

// Loaded State (with List<Category>)
class CategoryLoaded extends CategoryState {
  final List<Category> categories;

  const CategoryLoaded({required this.categories});

  @override
  List<Object?> get props => [categories];
}



// Added State
class CategoryAdded extends CategoryState {}

// Deleted State
class CategoryDeleted extends CategoryState {}

// Updated State (with updated Category)
class CategoryUpdated extends CategoryState {
  final Category newCategory;

  const CategoryUpdated(this.newCategory);

  @override
  List<Object?> get props => [newCategory];

  get updatedCategory => null;
}

// Error State (with error message)
class CategoryError extends CategoryState {
  final String message;

  const CategoryError(this.message);

  @override
  List<Object?> get props => [message];
}
