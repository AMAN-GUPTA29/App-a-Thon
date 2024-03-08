
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';


class Weather extends StatefulWidget{
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  @override
  void initState() {
    // _determinePosition();
    getlocationdata();

    

    super.initState();
  }


double? latitude;
double? longitude;

bool loadingdata=false;
String apiKey='14b184c01530281091e34c6912ef4367';

void getlocationdata()async{
  setState(() {
     loadingdata=true;
    });

      print("inside");
    try{
      var response3 =await Dio().get('https://api.openweathermap.org/data/2.5/weather?q=tada&appid=730d719ac3bd3c2ae02d0483af92253f&units=metric');
      if (response3.statusCode! >= 200 && response3.statusCode! <= 300) {
        setState(() {
            print(response3.data);
            print("insisde");
        });
      }
    }catch(e){
      print("insssside");
    }
    print("insiccde");

    setState(() {
     loadingdata=false;
    });

}


//   Future<Position> _determinePosition() async {
//     setState(() {
//       loadingdata=true;
//     });
//   bool serviceEnabled;
//   LocationPermission permission;

//   // Test if location services are enabled.
//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     // Location services are not enabled don't continue
//     // accessing the position and request users of the 
//     // App to enable the location services.
//     return Future.error('Location services are disabled.');
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       // Permissions are denied, next time you could try
//       // requesting permissions again (this is also where
//       // Android's shouldShowRequestPermissionRationale 
//       // returned true. According to Android guidelines
//       // your App should show an explanatory UI now.
//       return Future.error('Location permissions are denied');
//     }
//   }
  
//   if (permission == LocationPermission.deniedForever) {
//     // Permissions are denied forever, handle appropriately. 
//     return Future.error(
//       'Location permissions are permanently denied, we cannot request permissions.');
//   } 

//   // When we reach here, permissions are granted and we can
//   // continue accessing the position of the device.
//   setState(() {
//       loadingdata=false;
//     });
//   return await Geolocator.getCurrentPosition();

  
// }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:loadingdata==true?const Scaffold(body: Center(
                  child: CircularProgressIndicator(color: Colors.green),
                ),): Scaffold(body: Container(height: double.infinity,)));
  }
}