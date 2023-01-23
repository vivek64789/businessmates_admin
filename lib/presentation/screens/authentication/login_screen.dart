import 'package:auto_route/auto_route.dart';
import 'package:businessmates_admin/core/design/app_icons.dart';
import 'package:businessmates_admin/core/utils/validation_helper.dart';
import 'package:businessmates_admin/presentation/cubits/auth/auth_cubit.dart';
import 'package:businessmates_admin/presentation/screens/authentication/register_screen.dart';
import 'package:businessmates_admin/presentation/screens/authentication/verify_otp_screen.dart';
import 'package:businessmates_admin/presentation/widgets/bm_button.dart';
import 'package:businessmates_admin/presentation/widgets/bm_text_form_field.dart';
import 'package:businessmates_admin/routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/design/size.dart';
import '../../../core/utils/constants.dart';
import '../../cubits/manage_categories/manage_categories_cubit.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = '/login-screen';
  static Page page() => const MaterialPage<void>(child: LoginScreen());

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthCubit _authCubit;
  // controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isHidden = true;

  bool isHiddenConfirm = true;

  bool isChecked = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _authCubit = context.read<AuthCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Login to your account',
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: Constants.formFieldBetweenSpacing,
                  ),
                  const LogoWidget(
                    height: 150,
                  ),
                  // Email form field
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: Constants.formFieldMarginHorizontal),
                    child: BMTextFormField(
                      controller: _emailController,
                      hintText: 'Email',
                      // labelText: 'Email',
                      prefixIcon: const Icon(BMIcon.envelope),
                      validator: (value) {
                        return isEmpty(value) ?? isEmail(value);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: Constants.formFieldBetweenSpacing,
                  ),
                  // Password form field
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: Constants.formFieldMarginHorizontal),
                    child: BMTextFormField(
                      controller: _passwordController,
                      hintText: 'Password',
                      prefixIcon: const Icon(BMIcon.lock),
                      validator: (value) {
                        return isEmpty(value) ?? checkPassword(value);
                      },
                      obscureText: isHidden,
                      suffixIcon: IconButton(
                        icon: Icon(
                          isHidden ? BMIcon.eye : BMIcon.eye_slash,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        onPressed: () {
                          setState(() {
                            isHidden = !isHidden;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: Constants.formFieldBetweenSpacing,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: paddingHorizontal),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              context.router.pushNamed(
                                ForgotPasswordScreen.routeName,
                              );
                            },
                            child: const Text('Forgot Password?')),
                      ],
                    ),
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      state.failureMessageOption.fold(
                        () => {},
                        (failure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(failure.when(
                                serverError: (e) => e.toString(),
                                noInternetConnection: (e) => e.toString(),
                                tooManyRequests: (e) => e.toString(),
                                deviceNotSupported: (e) => e.toString(),
                                smsTimeout: (e) => e.toString(),
                                sessionExpired: (e) => e.toString(),
                                invalidVerificationCode: (e) => e.toString(),
                                invalidEmailAddress: (e) => e.toString(),
                                weakPassword: (e) => e.toString(),
                                invalidActionCode: (e) => e.toString(),
                                emailAlreadyInUse: (e) => e.toString(),
                                invalidEmailAndPasswordCombination: (e) =>
                                    e.toString(),
                                userNotFound: (e) => e.toString(),
                                requiresRecentLogin: (e) => e.toString(),
                              )),
                            ),
                          );
                        },
                      );
                      if (state.loginLoadingStatus == LoadingStatus.loaded &&
                          state.currentLoggedInUser!.emailVerified == true) {
                        context.router.replace(
                          RootDashboardRoute(
                            currentIndex: 0,
                          ),
                        );
                      } else if (state.loginLoadingStatus ==
                              LoadingStatus.loaded &&
                          state.currentLoggedInUser!.emailVerified == false) {
                        context.router.replaceNamed(VerifyOTPScreen.routeName);
                      }
                    },
                    builder: (context, state) {
                      return BMButton(
                          isLoading:
                              state.loginLoadingStatus == LoadingStatus.loading,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _authCubit.signInWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                            }
                          },
                          text: "Login");
                    },
                  ),
                  const SizedBox(
                    height: Constants.formFieldBetweenSpacing,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      TextButton(
                        onPressed: () {
                          context.router.replaceNamed(RegisterScreen.routeName);
                        },
                        child: Text(
                          "Sign up",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    Key? key,
    this.showTitle = true,
    required this.height,
  }) : super(key: key);

  final double height;
  final bool showTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(paddingHorizontal),
      // height: height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: height * 0.5,
            child: Image.asset(
              Constants.logo,
              fit: BoxFit.contain,
            ),
          ),
          showTitle
              ? const SizedBox(
                  width: 10,
                )
              : Container(),
          showTitle
              ? Text(
                  Constants.appName,
                  style: Theme.of(context).textTheme.labelLarge,
                )
              : Container(),
        ],
      ),
    );
  }
}
