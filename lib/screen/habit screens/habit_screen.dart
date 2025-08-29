import 'package:flutter/material.dart';
import 'package:my_life/Notifiers/api_service_firebase.dart';
import 'package:my_life/Notifiers/habit_state.dart';
import 'package:my_life/screen/habit%20screens/create_habit_screen.dart';
import 'package:provider/provider.dart';

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});
  static const screenRoute = 'habit_screen';
  @override
  State<HabitScreen> createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    await Provider.of<HabitState>(context, listen: false).getHabits(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue.shade50,
              child: Row(
                children: [
                  // صورة البروفايل
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                      Provider.of<ApiServiceFirebase>(
                            context,
                            listen: false,
                          ).profileModel?.imageUrl ??
                          '',
                    ), // رابط صورة افتراضي
                  ),
                  const SizedBox(width: 12),
                  // النصوص
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi ${Provider.of<ApiServiceFirebase>(context, listen: false).profileModel?.fullname}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Here are the list of yours habits\nyou need to work on',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // العنوان الرئيسي
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Your Habits (${Provider.of<HabitState>(context).habits.length})',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // قائمة العادات
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: Provider.of<HabitState>(context).habits.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // النصوص
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Date',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${Provider.of<HabitState>(context).habits[index].dateCreated.day}/${Provider.of<HabitState>(context).habits[index].dateCreated.month}/${Provider.of<HabitState>(context).habits[index].dateCreated.year}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                Provider.of<HabitState>(
                                  context,
                                ).habits[index].title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                Provider.of<HabitState>(
                                  context,
                                ).habits[index].description,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuButton<int>(
                          icon: const Icon(Icons.more_vert),
                          onSelected: (value) async {
                            if (value == 0) {
                              Navigator.of(context).pushNamed(
                                CreateHabitScreen.screenRoute,
                                arguments: "",
                              );
                            } else if (value == 1) {
                              await Provider.of<HabitState>(
                                context,
                                listen: false,
                              ).deleteHabit(
                                context,
                                Provider.of<HabitState>(
                                  context,
                                  listen: false,
                                ).habits[index].id,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('تم اختيار حذف'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else if (value == 2) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('عرض المزيد')),
                              );
                            }
                          },
                          itemBuilder:
                              (context) => [
                                PopupMenuItem(
                                  value: 0,
                                  child: Row(
                                    children: const [
                                      Icon(Icons.edit, color: Colors.blue),
                                      SizedBox(width: 8),
                                      Text('Edit'),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 1,
                                  child: Row(
                                    children: const [
                                      Icon(Icons.delete, color: Colors.red),
                                      SizedBox(width: 8),
                                      Text('Delete'),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: Row(
                                    children: const [
                                      Icon(Icons.info, color: Colors.green),
                                      SizedBox(width: 8),
                                      Text("Read"),
                                    ],
                                  ),
                                ),
                              ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
