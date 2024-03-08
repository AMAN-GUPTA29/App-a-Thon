import 'package:agri_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  FormScreenState createState() => FormScreenState();
}

class FormScreenState extends State<FormScreen> {
  late String name;
  late Map<String, DateTime> cropDetail = {};
  late double landArea;

  List<String> predefinedCrops = ['Maize', 'Rice', 'Wheat'];
  List<String> selectedCrops = [];
  Map<String, DateTime> sowingDates = {};

  int count = 1;

  void formHandler() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Details Form'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Column(
              children: List.generate(count, (index) {
                final crop =
                    selectedCrops.length > index ? selectedCrops[index] : null;
                return Column(
                  children: [
                    DropdownButtonFormField<String>(
                      key: ValueKey<String>('crop_$index'),
                      decoration:
                          const InputDecoration(labelText: 'Crop Detail'),
                      value: crop,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedCrops.add(newValue);
                          });
                          _selectDate(context, newValue);
                        }
                      },
                      items: predefinedCrops.map((crop) {
                        return DropdownMenuItem<String>(
                          value: crop,
                          child: Text(crop),
                        );
                      }).toList(),
                    ),
                    if (sowingDates.containsKey(crop))
                      Text(
                          'Sown Date: ${sowingDates[crop].toString().substring(0, 11)}'),
                    const SizedBox(height: 10),
                  ],
                );
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (count <= 2)
                  ElevatedButton.icon(
                    onPressed: () => setState(() => count++),
                    icon: const Icon(Icons.add),
                    label: const Text("Add More Crop"),
                  ),
                if (count >= 1)
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        count--;
                        final lastCrop = selectedCrops.removeLast();
                        sowingDates.remove(lastCrop);
                      });
                    },
                    icon: const Icon(Icons.remove),
                    label: const Text("Remove Crop"),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Land Area:'),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(labelText: 'Enter Land Area'),
                    onChanged: (value) {
                      setState(() {
                        landArea = double.parse(value);
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomeScreen())),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, String crop) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        sowingDates[crop] = picked;
      });
    }
  }
}
