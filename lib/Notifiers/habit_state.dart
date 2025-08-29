import 'package:flutter/material.dart';
import 'package:my_life/Notifiers/api_service_firebase.dart';
import 'package:my_life/model/habit_model.dart';
import 'package:provider/provider.dart';

class HabitState extends ChangeNotifier {
  List<Habit> habits = [];
  final List<Color> colors = [
    Colors.red[100]!,
    Colors.green[100]!,
    Colors.blue[100]!,
    Colors.orange[100]!,
    Colors.purple[100]!,
    Colors.yellow[100]!,
    Colors.pink[100]!,
    Colors.teal[100]!,
  ];

  Future<void> getHabits(BuildContext context) async {
    habits =
        await Provider.of<ApiServiceFirebase>(
          context,
          listen: false,
        ).getHabits();
    notifyListeners();
  }

  Color getColorFromNumber(int index) {
    return colors[index];
  }

  Future<void> deleteHabit(BuildContext context, String habitId) async {
    await Provider.of<ApiServiceFirebase>(
      context,
      listen: false,
    ).deleteHabit(habitId);
    habits.removeWhere((habit) => habit.id == habitId);
    notifyListeners();
  }
}
