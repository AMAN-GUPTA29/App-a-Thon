import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '/provider/signin_provider.dart';
import '/config/constants.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: Consumer<SignInProvider>(builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Placeholder(),
              SizedBox(height: height * 0.15),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: ElevatedButton(
                  onPressed: () => provider.signIn(context),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Constants.googleLogo),
                      const SizedBox(width: 15),
                      const Text("Sign In with Google"),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
