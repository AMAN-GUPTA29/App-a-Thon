import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/signin_provider.dart';

import '../widgets/drawer_widget.dart';

enum FilterOptions { signOut, viewProfile }

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
        title: const Text("Farm Hub"),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              if (selectedValue == FilterOptions.signOut) {
                signInProvider.signOut();
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.signOut,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 10),
                    Text("Sign Out"),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: FilterOptions.viewProfile,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 10),
                    Text("View Profile"),
                  ],
                ),
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body: Center(
        child: Text("HELLO ${FirebaseAuth.instance.currentUser!.displayName!}"),
      ),
    );
  }
}
