import 'package:agri_app/config/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../provider/signin_provider.dart';

import '../widgets/drawer_widget.dart';

enum FilterOptions { signOut, viewProfile }

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.width;
    final signInProvider = Provider.of<SignInProvider>(context, listen: true);

    if (signInProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    Widget cropWidget(String image, String text, int count) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(image),
                    minRadius: 30,
                  ), // Only show the text if count is not null
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(
                        count.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(text),
            ],
          ),
        ],
      );
    }

    Widget functionalityWidget(IconData icon, String text) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          child: Card(
            elevation: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(icon),
                Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      );
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
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.lightGreen,
                      minRadius: 30,
                      child: Icon(Icons.add),
                    ),
                    SizedBox(height: 5),
                    Text("Add"),
                  ],
                ),
                cropWidget(Constants.bananaImage, "Banana", 10),
                cropWidget(Constants.sugarcaneImage, "SugarCane", 11),
                cropWidget(Constants.maizeImage, "Maize", 15),
              ],
            ),
          ),
          SizedBox(height: height * 0.1),
          Container(
            padding: const EdgeInsets.all(8),
            child: Image.asset(Constants.smartFarmerImage),
          ),
          SizedBox(height: height * 0.05),
          Container(
            margin: EdgeInsets.only(top: height * 0.05),
            height: height * 0.7,
            child: GridView(
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1 / 1,
              ),
              children: [
                functionalityWidget(Icons.shopping_cart, "Shop"),
                functionalityWidget(Icons.book, "Best Practices"),
                functionalityWidget(Icons.people, "Community"),
                functionalityWidget(Icons.label, "News"),
                functionalityWidget(Icons.comment, "Blog"),
                functionalityWidget(Icons.video_call, "Videos")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
