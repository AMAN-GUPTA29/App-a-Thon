import 'package:agri_app/screens/calender_screen.dart';
import 'package:agri_app/screens/weather.dart';
import 'package:flutter/material.dart';
import 'package:agri_app/screens/test.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    Widget listItem(String text, IconData icon, VoidCallback tapHandler) {
      return SizedBox(
        width: double.infinity,
        child: TextButton.icon(
          style: TextButton.styleFrom(alignment: Alignment.centerLeft),
            onPressed: tapHandler,
            icon: Icon(icon),
            label: Text(text)),
      );
    }

    return Drawer(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              height: height * 0.13,
              alignment: Alignment.bottomCenter,
              child: Text(
                "FarmHub",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.05),
                listItem(
                    "Calender",
                    Icons.calendar_month,
                    () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const CalenderScreen()))),
                const Divider(),
                listItem(
                    "Weather Info",
                    Icons.cloud,
                    () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Weather()))),
                const Divider(),
                listItem("Disease detection", Icons.coronavirus, ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const HomePageTest())))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
