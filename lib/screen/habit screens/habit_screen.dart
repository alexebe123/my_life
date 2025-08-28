import 'package:flutter/material.dart';
import 'package:my_life/Notifiers/api_service_firebase.dart';
import 'package:my_life/model/habit_model.dart';
import 'package:provider/provider.dart';

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});
  static const screenRoute = 'habit_screen';
  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  List<Habit> habits = [];
  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    habits =
        await Provider.of<ApiServiceFirebase>(
          context,
          listen: false,
        ).getHabits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
