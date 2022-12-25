import 'dart:io';

import 'package:businessmates_admin/core/errors/image_upload_failure.dart';
import 'package:businessmates_admin/core/errors/manage_course_lesson_failure.dart';
import 'package:businessmates_admin/core/errors/manage_course_section_failure.dart';
import 'package:businessmates_admin/data/models/course/course_lesson_model.dart';
import 'package:businessmates_admin/data/models/course/course_model.dart';
import 'package:businessmates_admin/core/errors/manage_course_failure.dart';
import 'package:businessmates_admin/data/models/course/course_section_model.dart';
import 'package:businessmates_admin/data/models/course_categories_model.dart';
import 'package:businessmates_admin/core/errors/manage_categories_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:businessmates_admin/core/errors/auth_failure.dart';
import 'package:businessmates_admin/data/models/user_profile_model.dart';
import 'package:businessmates_admin/domain/repositories/repository.dart';

import '../../core/utils/network_info.dart';
import '../datasources/remote_datasource.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  RepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Stream<User> authStateChanges() async* {}

  @override
  Future<Either<AuthFailure, Unit>> changePassword(
      {required String password}) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.changePassword(password: password);
    } else {
      return left(const AuthFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> confirmPasswordReset(
      {required String code, required String password}) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.confirmPasswordReset(
          code: code, password: password);
    } else {
      return left(const AuthFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<AuthFailure, User>> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.createUserWithEmailAndPassword(
          email: email, password: password);
    } else {
      return left(const AuthFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<AuthFailure, UserProfileModel>> getUserProfile(
      {required String uid}) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.getUserProfile(uid: uid);
    } else {
      return left(const AuthFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<AuthFailure, void>> sendPasswordResetEmail(
      {required String email}) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.sendPasswordResetEmail(email: email);
    } else {
      return left(const AuthFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<AuthFailure, User>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.signInWithEmailAndPassword(
          email: email, password: password);
    } else {
      return left(const AuthFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signOut() async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.signOut();
    } else {
      return left(const AuthFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<AuthFailure, void>> updateUserProfile(
      {required UserProfileModel userProfile}) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.updateUserProfile(userProfile: userProfile);
    } else {
      return left(const AuthFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<ImageUploadFailure, String>> uploadUserProfileImage(
      {required String uid, required File image}) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.uploadUserProfileImage(uid: uid, image: image);
    } else {
      return left(const ImageUploadFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> sendEmailVerification() async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.sendEmailVerification();
    } else {
      return left(const AuthFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<ManageCategoriesFailure, CategoriesModel>> createCourseCategory(
      {required String name,
      required String description,
      required String imageUrl}) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.createCourseCategory(
          name: name, description: description, imageUrl: imageUrl);
    } else {
      return left(const ManageCategoriesFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<ImageUploadFailure, String>> uploadSingleImage(
      {required File image}) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.uploadSingleImage(image: image);
    } else {
      return left(const ImageUploadFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<ManageCategoriesFailure, CategoriesModel>> deleteCourseCategory(
      {required String id}) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.deleteCourseCategory(id: id);
    } else {
      return left(const ManageCategoriesFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<ManageCategoriesFailure, CategoriesModel>> updateCourseCategory(
      {required CategoriesModel categoriesModel}) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.updateCourseCategory(
          categoriesModel: categoriesModel);
    } else {
      return left(const ManageCategoriesFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<ManageCategoriesFailure, List<CategoriesModel>>>
      getAllCourseCategories() async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.getAllCourseCategories();
    } else {
      return left(const ManageCategoriesFailure.noInternetConnection());
    }
  }

  @override
  Stream<List<CategoriesModel>> streamAllCourseCategories() async* {
    yield* remoteDataSource.streamAllCourseCategories();
  }

  @override
  Future<Either<ManageCourseFailure, CourseModel>> createCourse(
      {required CourseModel courseModel}) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.createCourse(courseModel: courseModel);
    } else {
      return left(const ManageCourseFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<ManageCourseFailure, CourseModel>> deleteCourse(
      {required CourseModel courseModel}) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.deleteCourse(courseModel: courseModel);
    } else {
      return left(const ManageCourseFailure.noInternetConnection());
    }
  }

  @override
  Stream<List<CourseModel>> streamAllCourseOfCategories(
      {required String categoryId}) async* {
    yield* remoteDataSource.streamAllCoursesOfCategory(categoryId: categoryId);
  }

  @override
  Future<Either<ManageCourseFailure, CourseModel>> updateCourse(
      {required CourseModel courseModel}) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.updateCourse(courseModel: courseModel);
    } else {
      return left(const ManageCourseFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<ManageCourseSectionFailure, CourseSectionModel>>
      createCourseSection(
          {required CourseSectionModel courseSectionModel}) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.createCourseSection(
          courseSectionModel: courseSectionModel);
    } else {
      return left(const ManageCourseSectionFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<ManageCourseSectionFailure, CourseSectionModel>>
      deleteCourseSection(
          {required CourseSectionModel courseSectionModel}) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.deleteCourseSection(
          courseSectionModel: courseSectionModel);
    } else {
      return left(const ManageCourseSectionFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<ManageCourseSectionFailure, List<CourseSectionModel>>>
      getAllSectionsOfCourse(
          {required CourseSectionModel courseSectionModel}) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.getAllSectionsOfCourse(
          courseSectionModel: courseSectionModel);
    } else {
      return left(const ManageCourseSectionFailure.noInternetConnection());
    }
  }

  @override
  Stream<List<CourseSectionModel>> streamAllSectionsOfCourse(
      {required CourseModel courseModel}) async* {
    yield* remoteDataSource.streamAllSectionsOfCourse(
        courseModel: courseModel);
  }

  @override
  Future<Either<ManageCourseSectionFailure, CourseSectionModel>>
      updateCourseSection(
          {required CourseSectionModel courseSectionModel}) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.updateCourseSection(
          courseSectionModel: courseSectionModel);
    } else {
      return left(const ManageCourseSectionFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<ManageCourseLessonFailure, CourseLessonModel>>
      createCourseLesson({required CourseLessonModel courseLessonModel}) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.createCourseLesson(
          courseLessonModel: courseLessonModel);
    } else {
      return left(const ManageCourseLessonFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<ManageCourseLessonFailure, CourseLessonModel>>
      deleteCourseLesson({required CourseLessonModel courseLessonModel}) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.deleteCourseLesson(
          courseLessonModel: courseLessonModel);
    } else {
      return left(const ManageCourseLessonFailure.noInternetConnection());
    }
  }

  @override
  Future<Either<ManageCourseLessonFailure, List<CourseLessonModel>>>
      getAllSectionsOfLesson(
          {required CourseLessonModel courseLessonModel}) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.getAllSectionsOfLesson(
          courseLessonModel: courseLessonModel);
    } else {
      return left(const ManageCourseLessonFailure.noInternetConnection());
    }
  }

  @override
  Stream<List<CourseLessonModel>> streamAllLessonOfSection(
      {required CourseSectionModel courseSectionModel}) async* {
    if (await networkInfo.isConnected) {
      yield* remoteDataSource.streamAllLessonOfSection(
          courseSectionModel: courseSectionModel);
    } else {
      yield* const Stream.empty();
    }
  }

  @override
  Future<Either<ManageCourseLessonFailure, CourseLessonModel>>
      updateCourseLesson({required CourseLessonModel courseLessonModel}) async {
    if (await networkInfo.isConnected) {
      return remoteDataSource.updateCourseLesson(
          courseLessonModel: courseLessonModel);
    } else {
      return left(const ManageCourseLessonFailure.noInternetConnection());
    }
  }
}
