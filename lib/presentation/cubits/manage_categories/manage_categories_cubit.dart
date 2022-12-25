import 'package:businessmates_admin/core/errors/manage_categories_failure.dart';
import 'package:businessmates_admin/data/models/course/course_model.dart';
import 'package:businessmates_admin/data/models/course_categories_model.dart';
import 'package:businessmates_admin/di/injector.dart';
import 'package:businessmates_admin/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'manage_categories_state.dart';
part 'manage_categories_cubit.freezed.dart';

@LazySingleton()
class ManageCategoriesCubit extends Cubit<ManageCategoriesState> {
  late final Repository _repository;

  ManageCategoriesCubit() : super(ManageCategoriesState.empty()) {
    _repository = repository;
  }

  // getCourseCategories
  Future<void> getCourseCategories() async {
    emit(state.copyWith(manageCategoriesLoadingStatus: LoadingStatus.loading));
    final result = await _repository.getAllCourseCategories();

    result.fold(
      (failure) => emit(state.copyWith(
          manageCategoriesLoadingStatus: LoadingStatus.error,
          failureMessageOption: some(failure))),
      (categories) => emit(
        state.copyWith(
          manageCategoriesLoadingStatus: LoadingStatus.loaded,
          categories: categories,
        ),
      ),
    );
  }

  Stream<List<CategoriesModel>> streamAllCourseCategories() async* {
    yield* _repository.streamAllCourseCategories();
  }

  // createCourseCategory
  Future<void> createCourseCategory({
    required String name,
    required String description,
    required String imageUrl,
  }) async {
    emit(state.copyWith(manageCategoriesLoadingStatus: LoadingStatus.loading));
    final result = await _repository.createCourseCategory(
      name: name,
      description: description,
      imageUrl: imageUrl,
    );

    result.fold(
      (failure) => emit(state.copyWith(
          manageCategoriesLoadingStatus: LoadingStatus.error,
          failureMessageOption: some(failure))),
      (category) => emit(
        state.copyWith(
          manageCategoriesLoadingStatus: LoadingStatus.loaded,
        ),
      ),
    );
  }

  Future<void> updateCourseCategory({
    required CategoriesModel categoriesModel,
  }) async {
    emit(state.copyWith(manageCategoriesLoadingStatus: LoadingStatus.loading));
    final result = await _repository.updateCourseCategory(
      categoriesModel: categoriesModel,
    );

    result.fold(
      (failure) => emit(state.copyWith(
          manageCategoriesLoadingStatus: LoadingStatus.error,
          failureMessageOption: some(failure))),
      (category) => emit(
        state.copyWith(
          manageCategoriesLoadingStatus: LoadingStatus.loaded,
        ),
      ),
    );
  }

  // deleteCourseCategory
  Future<void> deleteCourseCategory({
    required String id,
  }) async {
    emit(state.copyWith(manageCategoriesLoadingStatus: LoadingStatus.loading));
    final result = await _repository.deleteCourseCategory(
      id: id,
    );

    result.fold(
      (failure) => emit(state.copyWith(
          manageCategoriesLoadingStatus: LoadingStatus.error,
          failureMessageOption: some(failure))),
      (category) => emit(
        state.copyWith(
          manageCategoriesLoadingStatus: LoadingStatus.loaded,
        ),
      ),
    );
    getCourseCategories();
  }

  // courses
  Stream<List<CourseModel>> streamAllCourseOfCategories(
      {required String categoryId}) async* {
    yield* _repository.streamAllCourseOfCategories(categoryId: categoryId);
  }
}
