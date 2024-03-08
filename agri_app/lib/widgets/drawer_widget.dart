import 'package:agri_app/screens/weather.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Drawer(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              height: height * 0.13,
              alignment: Alignment.bottomCenter,
              child: Text("FarmHub", style: Theme.of(context).textTheme.headlineLarge,),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.05),
                InkWell(onTap: (){Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Weather()),);},child: const Text("Sample 1")),
                const Divider(height: 50),
                const Text("Sample 2"),
                const Divider(height: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
