import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class UserDataProvider with ChangeNotifier {
  late String name;
  late Map<String, DateTime> cropDetail;
  late double landArea;

  bool isLoading = false;

  Future<bool> loadData() async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      DatabaseReference ref = FirebaseDatabase.instance.ref(user.uid);
      final snapshot = await ref.get();
      if (snapshot.exists) {
        print(snapshot.value);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> setData(
      String name, Map<String, DateTime> cropDetail, double landArea) async {}
}
