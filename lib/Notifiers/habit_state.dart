import 'package:flutter/material.dart';
import 'package:my_life/Notifiers/api_service_firebase.dart';
import 'package:my_life/model/habit_model.dart';
import 'package:provider/provider.dart';

class HabitState extends ChangeNotifier {
  List<Habit> habits = [];

  Future<void> getHabits(BuildContext context) async {
    habits =
        await Provider.of<ApiServiceFirebase>(
          context,
          listen: false,
        ).getHabits();
    notifyListeners();
  }
}
