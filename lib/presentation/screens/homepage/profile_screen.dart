import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes.gr.dart';
import '../../cubits/auth/auth_cubit.dart';
import '../../widgets/bm_button.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/ProfileScreen';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final AuthCubit authCubit = context.read<AuthCubit>();
    return SizedBox(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            BMButton(
              onPressed: () {
                //create ui to confirm logout with modal bottom sheet
                

                context.read<AuthCubit>().signOut();
                context.router.replaceAll([const LoginScreenRoute()]);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logged out'),
                  ),
                );
              },
              text: "Logout",
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
