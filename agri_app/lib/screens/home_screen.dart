import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/provider/signin_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signInProvider = Provider.of<SignInProvider>(context, listen: true);

    if (signInProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () => signInProvider.signOut(),
            icon: const Icon(Icons.exit_to_app),
            label: const Text("Sign Out"),
          )
        ],
      ),
      body: const Placeholder(),
    );
  }
}
