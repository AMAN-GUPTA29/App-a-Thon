import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  bool isLoading = false;
  bool isError = false;

  Map<String, dynamic> weatherInfo = {};

  @override
  void initState() {
    // TODO: implement initState
    getLocationData();
    super.initState();
  }

  void getLocationData() async {
    setState(() => isLoading = true);
    try {
      var response = await Dio().get(
          'https://api.openweathermap.org/data/2.5/weather?q=tada&appid=730d719ac3bd3c2ae02d0483af92253f&units=metric');
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        weatherInfo = response.data;
      }
    } catch (e) {
      setState(() => isError = true);
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather Info")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : isError
              ? const Center(
                  child: AlertDialog(
                    title: Text("Error Occurred!"),
                    content: Text(
                        "Unable to fetch data. Please check your internet connection and refresh!"),
                  ),
                )
              : Column(
                  children: [
                    Container(
                      child: Text("Place:"),
                    ),
                  ],
                ),
    );
  }
}
