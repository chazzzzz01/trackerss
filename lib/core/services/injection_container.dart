import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:trackerss/features/category_management/data/data_source/category_remote_datasource.dart';
import 'package:trackerss/features/category_management/data/data_source/firebase_category_remote_datasource.dart';
import 'package:trackerss/features/category_management/data/repositories_impl/category_repo_impl.dart';
import 'package:trackerss/features/category_management/domain/repositories/category_repositories.dart';
import 'package:trackerss/features/category_management/domain/use_cases/create_category.dart';
import 'package:trackerss/features/category_management/domain/use_cases/delete_category.dart';
import 'package:trackerss/features/category_management/domain/use_cases/get_category.dart';
import 'package:trackerss/features/category_management/domain/use_cases/update_category.dart';
import 'package:trackerss/features/category_management/presentation/cubit/category_cubit.dart';
import 'package:trackerss/features/gift_management/data/data_source/firebase_gift_remote_datasource.dart';
import 'package:trackerss/features/gift_management/data/data_source/gift_remote_datasource.dart';
import 'package:trackerss/features/gift_management/data/repositories_impl/gift_repo_impl.dart';
import 'package:trackerss/features/gift_management/domain/repositories/gift_repositories.dart';
import 'package:trackerss/features/gift_management/domain/use_cases/create_gift.dart';
import 'package:trackerss/features/gift_management/domain/use_cases/delete_gift.dart';
import 'package:trackerss/features/gift_management/domain/use_cases/get_gift.dart';
import 'package:trackerss/features/gift_management/domain/use_cases/update_gift.dart';
import 'package:trackerss/features/gift_management/presentation/cubit/gift_cubit.dart';
import 'package:trackerss/features/recipient_management/data/data_source/firebase_recipient_remote_datasource.dart';
import 'package:trackerss/features/recipient_management/data/repositories_impl/recipient_repo_impl.dart';
import 'package:trackerss/features/recipient_management/domain/repositories/recipient_repositories.dart';
import 'package:trackerss/features/recipient_management/domain/use_cases/create_recipient.dart';
import 'package:trackerss/features/recipient_management/domain/use_cases/delete_recipient.dart';
import 'package:trackerss/features/recipient_management/domain/use_cases/get_recipient.dart';
import 'package:trackerss/features/recipient_management/domain/use_cases/update_recipient.dart';
import 'package:trackerss/features/recipient_management/presentation/cubit/recipient_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  serviceLocator.registerFactory(() => CategoryCubit(createCategoryUseCase: serviceLocator(), deleteCategoryUseCase: serviceLocator(), getCategoriesUseCase: serviceLocator(), updateCategoryUseCase: serviceLocator()));

  serviceLocator.registerLazySingleton(() => CreateCategory(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => DeleteCategory(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetCategories(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => UpdateCategory(repository: serviceLocator()));


  serviceLocator.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImplementation(serviceLocator()));

  
  serviceLocator.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryFirebaseRemoteDataSource(serviceLocator()));


  serviceLocator.registerLazySingleton(
    () => FirebaseFirestore.instance);






  serviceLocator.registerFactory(() => GiftCubit(createGiftUseCase: serviceLocator(), deleteGiftUseCase: serviceLocator(), getGiftsUseCase: serviceLocator(), updateGiftUseCase: serviceLocator()));

  serviceLocator.registerLazySingleton(() => CreateGift(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => DeleteGift(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetGifts(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => UpdateGift(repository: serviceLocator()));


  serviceLocator.registerLazySingleton<GiftRepository>(
    () => GiftRepositoryImplementation(serviceLocator()));

  
  serviceLocator.registerLazySingleton<GiftRemoteDataSource>(
    () => GiftFirebaseRemoteDatasource(serviceLocator()));







  serviceLocator.registerFactory(() => RecipientCubit(createRecipientUseCase: serviceLocator(), deleteRecipientUseCase: serviceLocator(), getRecipientsUseCase: serviceLocator(), updateRecipientUseCase: serviceLocator()));

  serviceLocator.registerLazySingleton(() => CreateRecipient(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => DeleteRecipient(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetRecipients(repository: serviceLocator()));
  serviceLocator.registerLazySingleton(() => UpdateRecipient(repository: serviceLocator()));


  serviceLocator.registerLazySingleton<RecipientRepository>(
    () => RecipientRepositoryImplementation(serviceLocator()));

  
  serviceLocator.registerLazySingleton(
    () => RecipientFirebaseRemoteDatasource(serviceLocator()));


}