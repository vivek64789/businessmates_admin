import 'dart:io';

import 'package:businessmates_admin/core/errors/manage_course_failure.dart';
import 'package:businessmates_admin/data/models/course/course_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/errors/auth_failure.dart';
import '../../core/errors/image_upload_failure.dart';
import '../../core/errors/manage_categories_failure.dart';
import '../../core/errors/manage_course_lesson_failure.dart';
import '../../core/errors/manage_course_section_failure.dart';
import '../../data/models/course/course_lesson_model.dart';
import '../../data/models/course/course_section_model.dart';
import '../../data/models/course_categories_model.dart';
import '../../data/models/user_profile_model.dart';

abstract class Repository {
  // authentication actions
  Stream<User> authStateChanges();
  Future<Either<AuthFailure, Unit>> signOut();
  Future<Either<AuthFailure, void>> changePassword({required String password});
  Future<Either<AuthFailure, void>> sendPasswordResetEmail(
      {required String email});
  Future<Either<AuthFailure, void>> confirmPasswordReset(
      {required String code, required String password});
  Future<Either<AuthFailure, User>> createUserWithEmailAndPassword(
      {required String email, required String password});
  Future<Either<AuthFailure, User>> signInWithEmailAndPassword(
      {required String email, required String password});

  // profile actions
  Future<Either<AuthFailure, UserProfileModel>> getUserProfile(
      {required String uid});
  Future<Either<AuthFailure, void>> updateUserProfile(
      {required UserProfileModel userProfile});
  Future<Either<ImageUploadFailure, String>> uploadUserProfileImage(
      {required String uid, required File image});

  // eend email verification
  Future<Either<AuthFailure, void>> sendEmailVerification();

  // categories
  Future<Either<ManageCategoriesFailure, CategoriesModel>> createCourseCategory(
      {required String name,
      required String description,
      required String imageUrl});
  Stream<List<CategoriesModel>> streamAllCourseCategories();
  Future<Either<ManageCategoriesFailure, CategoriesModel>> updateCourseCategory(
      {required CategoriesModel categoriesModel});
  Future<Either<ManageCategoriesFailure, CategoriesModel>>
      deleteCourseCategory({
    required String id,
  });

  Future<Either<ImageUploadFailure, String>> uploadSingleImage(
      {required File image});

  Future<Either<ManageCategoriesFailure, List<CategoriesModel>>>
      getAllCourseCategories();

  // courses
  Stream<List<CourseModel>> streamAllCourseOfCategories(
      {required String categoryId});
  Future<Either<ManageCourseFailure, CourseModel>> createCourse(
      {required CourseModel courseModel});
  Future<Either<ManageCourseFailure, CourseModel>> updateCourse(
      {required CourseModel courseModel});
  Future<Either<ManageCourseFailure, CourseModel>> deleteCourse(
      {required CourseModel courseModel});

  // course sections
  // Section sources
  // create Section
  Future<Either<ManageCourseSectionFailure, CourseSectionModel>>
      createCourseSection({required CourseSectionModel courseSectionModel});
  // update Section
  Future<Either<ManageCourseSectionFailure, CourseSectionModel>>
      updateCourseSection({required CourseSectionModel courseSectionModel});
  // delete Section
  Future<Either<ManageCourseSectionFailure, CourseSectionModel>>
      deleteCourseSection({required CourseSectionModel courseSectionModel});
  // get all Section
  Future<Either<ManageCourseSectionFailure, List<CourseSectionModel>>>
      getAllSectionsOfCourse({required CourseSectionModel courseSectionModel});
  // stream all courses
  Stream<List<CourseSectionModel>> streamAllSectionsOfCourse(
      {required CourseModel courseModel});

  // Lesson sources
  // create Lesson
  Future<Either<ManageCourseLessonFailure, CourseLessonModel>>
      createCourseLesson({required CourseLessonModel courseLessonModel});
  // update Lesson
  Future<Either<ManageCourseLessonFailure, CourseLessonModel>>
      updateCourseLesson({required CourseLessonModel courseLessonModel});
  // delete Lesson
  Future<Either<ManageCourseLessonFailure, CourseLessonModel>>
      deleteCourseLesson({required CourseLessonModel courseLessonModel});
  // get all Lessons
  Future<Either<ManageCourseLessonFailure, List<CourseLessonModel>>>
      getAllSectionsOfLesson({required CourseLessonModel courseLessonModel});
  // stream all Lessons
  Stream<List<CourseLessonModel>> streamAllLessonOfSection(
      {required CourseSectionModel courseSectionModel});

  Repository();
}
