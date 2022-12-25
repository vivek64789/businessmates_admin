import 'package:businessmates_admin/core/errors/manage_course_lesson_failure.dart';
import 'package:businessmates_admin/data/models/course/course_lesson_model.dart';
import 'package:businessmates_admin/data/models/course/course_section_model.dart';
import 'package:businessmates_admin/di/injector.dart';
import 'package:businessmates_admin/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../manage_categories/manage_categories_cubit.dart';

part 'manage_course_lesson_state.dart';
part 'manage_course_lesson_cubit.freezed.dart';

@LazySingleton()
class ManageCourseLessonCubit extends Cubit<ManageCourseLessonState> {
  late final Repository _repository;

  ManageCourseLessonCubit() : super(ManageCourseLessonState.empty()) {
    _repository = repository;
  }

  // set courseModel
  void setCourseLessonModel(CourseLessonModel courseLessonModel) {
    emit(state.copyWith(
      courseLessonModel: courseLessonModel,
      manageCourseLessonLoadingStatus: LoadingStatus.initial,
    ));
  }

  // createCourseCategory
  Future<void> createNewCourseLesson({
    required CourseLessonModel courseLessonModel,
  }) async {
    emit(
        state.copyWith(manageCourseLessonLoadingStatus: LoadingStatus.loading));
    final result = await _repository.createCourseLesson(
      courseLessonModel: courseLessonModel,
    );

    result.fold(
      (failure) => emit(state.copyWith(
          manageCourseLessonLoadingStatus: LoadingStatus.error,
          failureMessageOption: some(failure))),
      (category) => emit(
        state.copyWith(
          manageCourseLessonLoadingStatus: LoadingStatus.loaded,
          courseLessonModel: CourseLessonModel.empty(),
        ),
      ),
    );
  }

  Future<void> updateCourseLesson({
    required CourseLessonModel courseLessonModel,
  }) async {
    emit(
        state.copyWith(manageCourseLessonLoadingStatus: LoadingStatus.loading));
    final result = await _repository.updateCourseLesson(
      courseLessonModel: courseLessonModel,
    );

    result.fold(
      (failure) => emit(state.copyWith(
          manageCourseLessonLoadingStatus: LoadingStatus.error,
          failureMessageOption: some(failure))),
      (category) => emit(
        state.copyWith(
          manageCourseLessonLoadingStatus: LoadingStatus.loaded,
        ),
      ),
    );
  }

  // deleteCourseCategory
  Future<void> deleteCourseLesson({
    required CourseLessonModel courseLessonModel,
  }) async {
    emit(
        state.copyWith(manageCourseLessonLoadingStatus: LoadingStatus.loading));
    final result = await _repository.deleteCourseLesson(
      courseLessonModel: courseLessonModel,
    );

    result.fold(
      (failure) => emit(state.copyWith(
          manageCourseLessonLoadingStatus: LoadingStatus.error,
          failureMessageOption: some(failure))),
      (category) => emit(
        state.copyWith(
          manageCourseLessonLoadingStatus: LoadingStatus.loaded,
        ),
      ),
    );
  }

  // stream all courses of a category
  Stream<List<CourseLessonModel>> streamAllLessonOfSection(
      {required CourseSectionModel courseSectionModel}) async* {
    yield* _repository.streamAllLessonOfSection(
        courseSectionModel: courseSectionModel);
  }
}
