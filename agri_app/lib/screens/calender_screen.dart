import 'package:agri_app/provider/userdata_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CropHarvestingDate {
  final String cropName;
  final int daysToHarvest;

  CropHarvestingDate({required this.cropName, required this.daysToHarvest});
}

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({super.key});

  String formattedDate(DateTime date) {
    final formatter = DateFormat('d MMMM, EEEE');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserDataProvider>(context, listen: false);

    final List<CropHarvestingDate> harvestingDates = [
      CropHarvestingDate(cropName: 'Maize', daysToHarvest: 90),
      CropHarvestingDate(cropName: 'Rice', daysToHarvest: 120),
      CropHarvestingDate(cropName: 'Wheat', daysToHarvest: 100),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Calendar Screen")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Total Land Area: ${userProvider.landArea}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final cropName = userProvider.cropDetail.keys.toList()[index];
                final sowingDate = userProvider.cropDetail[cropName];
                final harvestingDate = _calculateHarvestingDate(
                    cropName, DateTime.parse(sowingDate!), harvestingDates);
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        "Crop: $cropName",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Sowing Date: ${formattedDate(DateTime.parse(sowingDate))}"),
                          Text(
                              "Harvesting Date: ${formattedDate(DateTime.parse(harvestingDate))}"),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: userProvider.cropDetail.length,
            ),
          ),
        ],
      ),
    );
  }

  String _calculateHarvestingDate(String cropName, DateTime? sowingDate,
      List<CropHarvestingDate> harvestingDates) {
    final CropHarvestingDate cropHarvestingDate = harvestingDates.firstWhere(
      (harvestingDate) => harvestingDate.cropName == cropName,
      orElse: () => CropHarvestingDate(cropName: '', daysToHarvest: 0),
    );

    if (cropHarvestingDate.cropName.isNotEmpty && sowingDate != null) {
      final harvestingDate =
          sowingDate.add(Duration(days: cropHarvestingDate.daysToHarvest));
      return harvestingDate.toString();
    } else {
      return 'Unknown';
    }
  }
}

