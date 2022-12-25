// ignore: depend_on_referenced_packages
import 'package:auto_route/auto_route.dart';
import 'package:businessmates_admin/presentation/screens/authentication/login_screen.dart';
import 'package:businessmates_admin/presentation/screens/authentication/register_screen.dart';
import 'package:businessmates_admin/presentation/screens/authentication/verify_otp_screen.dart';
import 'package:businessmates_admin/presentation/screens/homepage/home_screen.dart';
import 'package:businessmates_admin/presentation/screens/introduction_animation/introduction_animation_screen.dart';
import 'package:businessmates_admin/presentation/screens/manage_categories/add_new_category_screen.dart';
import 'package:businessmates_admin/presentation/screens/manage_categories/manage_categories_screen.dart';
import 'package:businessmates_admin/presentation/screens/manage_course_lesson/create_new_course_lesson_screen.dart';
import 'package:businessmates_admin/presentation/screens/manage_course_lesson/manage_course_lessons_screen.dart';
import 'package:businessmates_admin/presentation/screens/manage_course_section/create_new_course_section_screen.dart';
import 'package:businessmates_admin/presentation/screens/manage_course_section/manage_course_sections_screen.dart';
import 'package:businessmates_admin/presentation/screens/manage_courses/create_new_course_screen.dart';
import 'package:businessmates_admin/presentation/screens/manage_courses/manage_courses_screen.dart';
import 'package:businessmates_admin/presentation/screens/root_dashboard.dart';
import 'package:businessmates_admin/presentation/screens/splash_screen.dart';

import 'presentation/screens/homepage/course_info_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: RegisterScreen,
      name: "RegisterScreenRoute",
      path: RegisterScreen.routeName,
    ),
    AutoRoute(
      page: LoginScreen,
      name: "LoginScreenRoute",
      path: LoginScreen.routeName,
    ),
    AutoRoute(
      page: VerifyOTPScreen,
      name: "VerifyOTPScreenRoute",
      path: VerifyOTPScreen.routeName,
    ),
    AutoRoute(
      page: HomePage,
      name: "HomePageRoute",
      path: HomePage.routeName,
    ),
    AutoRoute(
      page: RootDashboard,
      name: "RootDashboardRoute",
      path: RootDashboard.routeName,
    ),
    AutoRoute(
      page: CourseInfoScreen,
      name: "CourseInfoScreenRoute",
      path: CourseInfoScreen.routeName,
    ),
    AutoRoute(
      page: IntroductionAnimationScreen,
      name: "IntroductionAnimationScreenRoute",
      path: IntroductionAnimationScreen.routeName,
    ),
    AutoRoute(
      page: ManageCategoriesScreen,
      name: "ManageCategoriesScreenRoute",
      path: ManageCategoriesScreen.routeName,
    ),
    AutoRoute(
      page: CreateNewCategoryScreen,
      name: "CreateNewCategoryScreenRoute",
      path: CreateNewCategoryScreen.routeName,
    ),
    AutoRoute(
      page: ManageCoursesScreen,
      name: "ManageCoursesScreenRoute",
      path: ManageCoursesScreen.routeName,
    ),
    AutoRoute(
      page: CreateNewCourseScreen,
      name: "CreateNewCourseScreenRoute",
      path: CreateNewCourseScreen.routeName,
    ),
    AutoRoute(
      page: ManageCourseSectionsScreen,
      name: "ManageCourseSectionsScreenRoute",
      path: ManageCourseSectionsScreen.routeName,
    ),
    AutoRoute(
      page: CreateNewCourseSectionScreen,
      name: "CreateNewCourseSectionScreenRoute",
      path: CreateNewCourseSectionScreen.routeName,
    ),
    AutoRoute(
      page: ManageCourseLessonsScreen,
      name: "ManageCourseLessonsScreenRoute",
      path: ManageCourseLessonsScreen.routeName,
    ),
    AutoRoute(
      page: CreateNewCourseLessonScreen,
      name: "CreateNewCourseLessonScreenRoute",
      path: CreateNewCourseLessonScreen.routeName,
    ),
    AutoRoute(page: SplashScreen, initial: true),
  ],
)
class $AppRouter {}
