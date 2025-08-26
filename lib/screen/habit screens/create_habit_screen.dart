import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CreateHabitScreen extends StatefulWidget {
  const CreateHabitScreen({super.key});
  static const screenRoute = 'create_habit';
  @override
  State<CreateHabitScreen> createState() => _CreateHabitScreenState();
}

class _CreateHabitScreenState extends State<CreateHabitScreen> {
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.yellow,
    Colors.pink,
    Colors.teal,
  ];
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(child: const Text('New Habit')),
        leading: IconButton(
          icon: const Icon(Icons.close, size: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Habit Name',
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2.h),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Habit Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              SizedBox(
                height: 10.h,
                width: 90.w,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: colors.length,
                  itemBuilder: (context, index) {
                    bool isSelected = selectedIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: colors[index],
                            ),
                          ),
                          if (isSelected)
                            Icon(Icons.check, color: Colors.white, size: 40),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Description',
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2.h),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Reason',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 2.h),
              Text(
                'Reason',
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2.h),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Reason',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 2.h),
              Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30),
                ),
                width: 90.w,
                height: 7.h,
                alignment: Alignment.center,
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
