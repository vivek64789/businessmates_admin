// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:flutter/material.dart' as _i18;

import 'data/models/course/course_lesson_model.dart' as _i22;
import 'data/models/course/course_model.dart' as _i20;
import 'data/models/course/course_section_model.dart' as _i21;
import 'data/models/course_categories_model.dart' as _i19;
import 'presentation/screens/authentication/login_screen.dart' as _i2;
import 'presentation/screens/authentication/register_screen.dart' as _i1;
import 'presentation/screens/authentication/verify_otp_screen.dart' as _i3;
import 'presentation/screens/homepage/course_info_screen.dart' as _i6;
import 'presentation/screens/homepage/home_screen.dart' as _i4;
import 'presentation/screens/introduction_animation/introduction_animation_screen.dart'
    as _i7;
import 'presentation/screens/manage_categories/add_new_category_screen.dart'
    as _i9;
import 'presentation/screens/manage_categories/manage_categories_screen.dart'
    as _i8;
import 'presentation/screens/manage_course_lesson/create_new_course_lesson_screen.dart'
    as _i15;
import 'presentation/screens/manage_course_lesson/manage_course_lessons_screen.dart'
    as _i14;
import 'presentation/screens/manage_course_section/create_new_course_section_screen.dart'
    as _i13;
import 'presentation/screens/manage_course_section/manage_course_sections_screen.dart'
    as _i12;
import 'presentation/screens/manage_courses/create_new_course_screen.dart'
    as _i11;
import 'presentation/screens/manage_courses/manage_courses_screen.dart' as _i10;
import 'presentation/screens/root_dashboard.dart' as _i5;
import 'presentation/screens/splash_screen.dart' as _i16;

class AppRouter extends _i17.RootStackRouter {
  AppRouter([_i18.GlobalKey<_i18.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i17.PageFactory> pagesMap = {
    RegisterScreenRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.RegisterScreen(),
      );
    },
    LoginScreenRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginScreen(),
      );
    },
    VerifyOTPScreenRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.VerifyOTPScreen(),
      );
    },
    HomePageRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.HomePage(),
      );
    },
    RootDashboardRoute.name: (routeData) {
      final args = routeData.argsAs<RootDashboardRouteArgs>();
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.RootDashboard(
          key: args.key,
          currentIndex: args.currentIndex,
        ),
      );
    },
    CourseInfoScreenRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.CourseInfoScreen(),
      );
    },
    IntroductionAnimationScreenRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.IntroductionAnimationScreen(),
      );
    },
    ManageCategoriesScreenRoute.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.ManageCategoriesScreen(),
      );
    },
    CreateNewCategoryScreenRoute.name: (routeData) {
      final args = routeData.argsAs<CreateNewCategoryScreenRouteArgs>(
          orElse: () => const CreateNewCategoryScreenRouteArgs());
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.CreateNewCategoryScreen(
          key: args.key,
          category: args.category,
        ),
      );
    },
    ManageCoursesScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ManageCoursesScreenRouteArgs>(
          orElse: () => const ManageCoursesScreenRouteArgs());
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i10.ManageCoursesScreen(
          key: args.key,
          category: args.category,
        ),
      );
    },
    CreateNewCourseScreenRoute.name: (routeData) {
      final args = routeData.argsAs<CreateNewCourseScreenRouteArgs>(
          orElse: () => const CreateNewCourseScreenRouteArgs());
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i11.CreateNewCourseScreen(
          key: args.key,
          category: args.category,
          course: args.course,
        ),
      );
    },
    ManageCourseSectionsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ManageCourseSectionsScreenRouteArgs>(
          orElse: () => const ManageCourseSectionsScreenRouteArgs());
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i12.ManageCourseSectionsScreen(
          key: args.key,
          category: args.category,
          course: args.course,
        ),
      );
    },
    CreateNewCourseSectionScreenRoute.name: (routeData) {
      final args = routeData.argsAs<CreateNewCourseSectionScreenRouteArgs>(
          orElse: () => const CreateNewCourseSectionScreenRouteArgs());
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i13.CreateNewCourseSectionScreen(
          key: args.key,
          category: args.category,
          course: args.course,
          section: args.section,
        ),
      );
    },
    ManageCourseLessonsScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ManageCourseLessonsScreenRouteArgs>(
          orElse: () => const ManageCourseLessonsScreenRouteArgs());
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i14.ManageCourseLessonsScreen(
          key: args.key,
          category: args.category,
          course: args.course,
          section: args.section,
        ),
      );
    },
    CreateNewCourseLessonScreenRoute.name: (routeData) {
      final args = routeData.argsAs<CreateNewCourseLessonScreenRouteArgs>(
          orElse: () => const CreateNewCourseLessonScreenRouteArgs());
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i15.CreateNewCourseLessonScreen(
          key: args.key,
          category: args.category,
          course: args.course,
          section: args.section,
          lesson: args.lesson,
        ),
      );
    },
    SplashScreen.name: (routeData) {
      return _i17.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i16.SplashScreen(),
      );
    },
  };

  @override
  List<_i17.RouteConfig> get routes => [
        _i17.RouteConfig(
          RegisterScreenRoute.name,
          path: '/register-screen',
        ),
        _i17.RouteConfig(
          LoginScreenRoute.name,
          path: '/login-screen',
        ),
        _i17.RouteConfig(
          VerifyOTPScreenRoute.name,
          path: '/verify-otp-screen',
        ),
        _i17.RouteConfig(
          HomePageRoute.name,
          path: '/homepage',
        ),
        _i17.RouteConfig(
          RootDashboardRoute.name,
          path: '/Rootdashboard',
        ),
        _i17.RouteConfig(
          CourseInfoScreenRoute.name,
          path: '/course-info',
        ),
        _i17.RouteConfig(
          IntroductionAnimationScreenRoute.name,
          path: '/introduction-animation-screen',
        ),
        _i17.RouteConfig(
          ManageCategoriesScreenRoute.name,
          path: '/manage_categories',
        ),
        _i17.RouteConfig(
          CreateNewCategoryScreenRoute.name,
          path: '/create_new_category',
        ),
        _i17.RouteConfig(
          ManageCoursesScreenRoute.name,
          path: '/manage_courses',
        ),
        _i17.RouteConfig(
          CreateNewCourseScreenRoute.name,
          path: '/create_new_course',
        ),
        _i17.RouteConfig(
          ManageCourseSectionsScreenRoute.name,
          path: '/manage_course_sections',
        ),
        _i17.RouteConfig(
          CreateNewCourseSectionScreenRoute.name,
          path: '/create_new_course_section',
        ),
        _i17.RouteConfig(
          ManageCourseLessonsScreenRoute.name,
          path: '/manage_course_lessons',
        ),
        _i17.RouteConfig(
          CreateNewCourseLessonScreenRoute.name,
          path: '/create_new_course_lesson',
        ),
        _i17.RouteConfig(
          SplashScreen.name,
          path: '/',
        ),
      ];
}

/// generated route for
/// [_i1.RegisterScreen]
class RegisterScreenRoute extends _i17.PageRouteInfo<void> {
  const RegisterScreenRoute()
      : super(
          RegisterScreenRoute.name,
          path: '/register-screen',
        );

  static const String name = 'RegisterScreenRoute';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginScreenRoute extends _i17.PageRouteInfo<void> {
  const LoginScreenRoute()
      : super(
          LoginScreenRoute.name,
          path: '/login-screen',
        );

  static const String name = 'LoginScreenRoute';
}

/// generated route for
/// [_i3.VerifyOTPScreen]
class VerifyOTPScreenRoute extends _i17.PageRouteInfo<void> {
  const VerifyOTPScreenRoute()
      : super(
          VerifyOTPScreenRoute.name,
          path: '/verify-otp-screen',
        );

  static const String name = 'VerifyOTPScreenRoute';
}

/// generated route for
/// [_i4.HomePage]
class HomePageRoute extends _i17.PageRouteInfo<void> {
  const HomePageRoute()
      : super(
          HomePageRoute.name,
          path: '/homepage',
        );

  static const String name = 'HomePageRoute';
}

/// generated route for
/// [_i5.RootDashboard]
class RootDashboardRoute extends _i17.PageRouteInfo<RootDashboardRouteArgs> {
  RootDashboardRoute({
    _i18.Key? key,
    required int currentIndex,
  }) : super(
          RootDashboardRoute.name,
          path: '/Rootdashboard',
          args: RootDashboardRouteArgs(
            key: key,
            currentIndex: currentIndex,
          ),
        );

  static const String name = 'RootDashboardRoute';
}

class RootDashboardRouteArgs {
  const RootDashboardRouteArgs({
    this.key,
    required this.currentIndex,
  });

  final _i18.Key? key;

  final int currentIndex;

  @override
  String toString() {
    return 'RootDashboardRouteArgs{key: $key, currentIndex: $currentIndex}';
  }
}

/// generated route for
/// [_i6.CourseInfoScreen]
class CourseInfoScreenRoute extends _i17.PageRouteInfo<void> {
  const CourseInfoScreenRoute()
      : super(
          CourseInfoScreenRoute.name,
          path: '/course-info',
        );

  static const String name = 'CourseInfoScreenRoute';
}

/// generated route for
/// [_i7.IntroductionAnimationScreen]
class IntroductionAnimationScreenRoute extends _i17.PageRouteInfo<void> {
  const IntroductionAnimationScreenRoute()
      : super(
          IntroductionAnimationScreenRoute.name,
          path: '/introduction-animation-screen',
        );

  static const String name = 'IntroductionAnimationScreenRoute';
}

/// generated route for
/// [_i8.ManageCategoriesScreen]
class ManageCategoriesScreenRoute extends _i17.PageRouteInfo<void> {
  const ManageCategoriesScreenRoute()
      : super(
          ManageCategoriesScreenRoute.name,
          path: '/manage_categories',
        );

  static const String name = 'ManageCategoriesScreenRoute';
}

/// generated route for
/// [_i9.CreateNewCategoryScreen]
class CreateNewCategoryScreenRoute
    extends _i17.PageRouteInfo<CreateNewCategoryScreenRouteArgs> {
  CreateNewCategoryScreenRoute({
    _i18.Key? key,
    _i19.CategoriesModel? category,
  }) : super(
          CreateNewCategoryScreenRoute.name,
          path: '/create_new_category',
          args: CreateNewCategoryScreenRouteArgs(
            key: key,
            category: category,
          ),
        );

  static const String name = 'CreateNewCategoryScreenRoute';
}

class CreateNewCategoryScreenRouteArgs {
  const CreateNewCategoryScreenRouteArgs({
    this.key,
    this.category,
  });

  final _i18.Key? key;

  final _i19.CategoriesModel? category;

  @override
  String toString() {
    return 'CreateNewCategoryScreenRouteArgs{key: $key, category: $category}';
  }
}

/// generated route for
/// [_i10.ManageCoursesScreen]
class ManageCoursesScreenRoute
    extends _i17.PageRouteInfo<ManageCoursesScreenRouteArgs> {
  ManageCoursesScreenRoute({
    _i18.Key? key,
    _i19.CategoriesModel? category,
  }) : super(
          ManageCoursesScreenRoute.name,
          path: '/manage_courses',
          args: ManageCoursesScreenRouteArgs(
            key: key,
            category: category,
          ),
        );

  static const String name = 'ManageCoursesScreenRoute';
}

class ManageCoursesScreenRouteArgs {
  const ManageCoursesScreenRouteArgs({
    this.key,
    this.category,
  });

  final _i18.Key? key;

  final _i19.CategoriesModel? category;

  @override
  String toString() {
    return 'ManageCoursesScreenRouteArgs{key: $key, category: $category}';
  }
}

/// generated route for
/// [_i11.CreateNewCourseScreen]
class CreateNewCourseScreenRoute
    extends _i17.PageRouteInfo<CreateNewCourseScreenRouteArgs> {
  CreateNewCourseScreenRoute({
    _i18.Key? key,
    _i19.CategoriesModel? category,
    _i20.CourseModel? course,
  }) : super(
          CreateNewCourseScreenRoute.name,
          path: '/create_new_course',
          args: CreateNewCourseScreenRouteArgs(
            key: key,
            category: category,
            course: course,
          ),
        );

  static const String name = 'CreateNewCourseScreenRoute';
}

class CreateNewCourseScreenRouteArgs {
  const CreateNewCourseScreenRouteArgs({
    this.key,
    this.category,
    this.course,
  });

  final _i18.Key? key;

  final _i19.CategoriesModel? category;

  final _i20.CourseModel? course;

  @override
  String toString() {
    return 'CreateNewCourseScreenRouteArgs{key: $key, category: $category, course: $course}';
  }
}

/// generated route for
/// [_i12.ManageCourseSectionsScreen]
class ManageCourseSectionsScreenRoute
    extends _i17.PageRouteInfo<ManageCourseSectionsScreenRouteArgs> {
  ManageCourseSectionsScreenRoute({
    _i18.Key? key,
    _i19.CategoriesModel? category,
    _i20.CourseModel? course,
  }) : super(
          ManageCourseSectionsScreenRoute.name,
          path: '/manage_course_sections',
          args: ManageCourseSectionsScreenRouteArgs(
            key: key,
            category: category,
            course: course,
          ),
        );

  static const String name = 'ManageCourseSectionsScreenRoute';
}

class ManageCourseSectionsScreenRouteArgs {
  const ManageCourseSectionsScreenRouteArgs({
    this.key,
    this.category,
    this.course,
  });

  final _i18.Key? key;

  final _i19.CategoriesModel? category;

  final _i20.CourseModel? course;

  @override
  String toString() {
    return 'ManageCourseSectionsScreenRouteArgs{key: $key, category: $category, course: $course}';
  }
}

/// generated route for
/// [_i13.CreateNewCourseSectionScreen]
class CreateNewCourseSectionScreenRoute
    extends _i17.PageRouteInfo<CreateNewCourseSectionScreenRouteArgs> {
  CreateNewCourseSectionScreenRoute({
    _i18.Key? key,
    _i19.CategoriesModel? category,
    _i20.CourseModel? course,
    _i21.CourseSectionModel? section,
  }) : super(
          CreateNewCourseSectionScreenRoute.name,
          path: '/create_new_course_section',
          args: CreateNewCourseSectionScreenRouteArgs(
            key: key,
            category: category,
            course: course,
            section: section,
          ),
        );

  static const String name = 'CreateNewCourseSectionScreenRoute';
}

class CreateNewCourseSectionScreenRouteArgs {
  const CreateNewCourseSectionScreenRouteArgs({
    this.key,
    this.category,
    this.course,
    this.section,
  });

  final _i18.Key? key;

  final _i19.CategoriesModel? category;

  final _i20.CourseModel? course;

  final _i21.CourseSectionModel? section;

  @override
  String toString() {
    return 'CreateNewCourseSectionScreenRouteArgs{key: $key, category: $category, course: $course, section: $section}';
  }
}

/// generated route for
/// [_i14.ManageCourseLessonsScreen]
class ManageCourseLessonsScreenRoute
    extends _i17.PageRouteInfo<ManageCourseLessonsScreenRouteArgs> {
  ManageCourseLessonsScreenRoute({
    _i18.Key? key,
    _i19.CategoriesModel? category,
    _i20.CourseModel? course,
    _i21.CourseSectionModel? section,
  }) : super(
          ManageCourseLessonsScreenRoute.name,
          path: '/manage_course_lessons',
          args: ManageCourseLessonsScreenRouteArgs(
            key: key,
            category: category,
            course: course,
            section: section,
          ),
        );

  static const String name = 'ManageCourseLessonsScreenRoute';
}

class ManageCourseLessonsScreenRouteArgs {
  const ManageCourseLessonsScreenRouteArgs({
    this.key,
    this.category,
    this.course,
    this.section,
  });

  final _i18.Key? key;

  final _i19.CategoriesModel? category;

  final _i20.CourseModel? course;

  final _i21.CourseSectionModel? section;

  @override
  String toString() {
    return 'ManageCourseLessonsScreenRouteArgs{key: $key, category: $category, course: $course, section: $section}';
  }
}

/// generated route for
/// [_i15.CreateNewCourseLessonScreen]
class CreateNewCourseLessonScreenRoute
    extends _i17.PageRouteInfo<CreateNewCourseLessonScreenRouteArgs> {
  CreateNewCourseLessonScreenRoute({
    _i18.Key? key,
    _i19.CategoriesModel? category,
    _i20.CourseModel? course,
    _i21.CourseSectionModel? section,
    _i22.CourseLessonModel? lesson,
  }) : super(
          CreateNewCourseLessonScreenRoute.name,
          path: '/create_new_course_lesson',
          args: CreateNewCourseLessonScreenRouteArgs(
            key: key,
            category: category,
            course: course,
            section: section,
            lesson: lesson,
          ),
        );

  static const String name = 'CreateNewCourseLessonScreenRoute';
}

class CreateNewCourseLessonScreenRouteArgs {
  const CreateNewCourseLessonScreenRouteArgs({
    this.key,
    this.category,
    this.course,
    this.section,
    this.lesson,
  });

  final _i18.Key? key;

  final _i19.CategoriesModel? category;

  final _i20.CourseModel? course;

  final _i21.CourseSectionModel? section;

  final _i22.CourseLessonModel? lesson;

  @override
  String toString() {
    return 'CreateNewCourseLessonScreenRouteArgs{key: $key, category: $category, course: $course, section: $section, lesson: $lesson}';
  }
}

/// generated route for
/// [_i16.SplashScreen]
class SplashScreen extends _i17.PageRouteInfo<void> {
  const SplashScreen()
      : super(
          SplashScreen.name,
          path: '/',
        );

  static const String name = 'SplashScreen';
}
