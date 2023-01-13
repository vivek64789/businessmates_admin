import 'package:auto_route/auto_route.dart';
import 'package:businessmates_admin/core/design/app_icons.dart';
import 'package:businessmates_admin/presentation/cubits/auth/auth_cubit.dart';
import 'package:businessmates_admin/presentation/screens/manage_categories/manage_categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/color.dart';
import '../authentication/login_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/homepage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AuthCubit _authCubit;
  @override
  void initState() {
    _authCubit = context.read<AuthCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appBgColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: appBarColor,
              pinned: true,
              snap: true,
              floating: true,
              title: getAppBar(),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => buildBody(),
                childCount: 1,
              ),
            )
          ],
        ));
  }

  Widget getAppBar() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LogoWidget(height: MediaQuery.of(context).size.height * 0.06),
                  const Text(
                    "Business Mates",
                  ),
                ],
              ),
            ],
          )),
          // NotificationBox(
          //   notifiedNumber: 1,
          //   onTap: () {},
          // )
        ],
      ),
    );
  }

  Widget buildBody() {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),

          // design a beautiful card for managing courses, sections, lessons, etc
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: InkWell(
              splashColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
              onTap: () {
                context.router.pushNamed(ManageCategoriesScreen.routeName);
              },
              child: Container(
                  margin: const EdgeInsets.all(8),
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        BMIcon.check_circle,
                        size: 40,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Text("Manage Courses",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold)),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
