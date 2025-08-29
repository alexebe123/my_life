import 'package:flutter/material.dart';
import 'package:my_life/Notifiers/habit_state.dart';
import 'package:my_life/model/habit_model.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CreateHabitScreen extends StatefulWidget {
  const CreateHabitScreen({super.key});
  static const screenRoute = 'create_habit';
  @override
  State<CreateHabitScreen> createState() => _CreateHabitScreenState();
}

class _CreateHabitScreenState extends State<CreateHabitScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _reasonController;

  Habit habit = Habit.empty();
  String nameError = "";
  String descriptionError = "";
  String colorError = "";
  String reasonError = "";

  _defaultValues() {
    nameError = "";
    descriptionError = "";
    colorError = "";
    reasonError = "";
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _reasonController = TextEditingController();
  }

  bool _validateInfo(void Function(void Function()) setState) {
    bool result = true;
    _defaultValues();
    if (habit.title == "") {
      result = false;
      setState(() {
        nameError = "Enter Name";
      });
    }
    if (habit.description == "") {
      result = false;
      setState(() {
        descriptionError = "Enter Description";
      });
    }
    if (habit.color == "") {
      result = false;
      setState(() {
        colorError = "Enter Color";
      });
    }
    if (habit.reason == "") {
      result = false;
      setState(() {
        reasonError = "Enter Reason";
      });
    }

    return result;
  }

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

  Color getColorFromColors(int index) {
    if (index == 0) {
      return Colors.red;
    } else if (index == 1) {
      return Colors.green;
    } else if (index == 2) {
      return Colors.blue;
    } else if (index == 3) {
      return Colors.orange;
    } else if (index == 4) {
      return Colors.purple;
    } else if (index == 5) {
      return Colors.yellow;
    } else if (index == 6) {
      return Colors.pink;
    } else if (index == 7) {
      return Colors.teal;
    }
    return Colors.grey;
  }

  String loading = '';
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    final Habit? habitEddit =
        ModalRoute.of(context)!.settings.arguments as Habit?;
    if (habitEddit != null && habitEddit.id != "") {
      habit = habitEddit;
      _titleController.text = habitEddit.title;
      _descriptionController.text = habitEddit.description;
      _reasonController.text = habitEddit.reason;
      selectedIndex = int.tryParse(habitEddit.color);
    }
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
                onChanged: (value) {
                  if (nameError != "") {
                    setState(() {
                      nameError = "";
                    });
                  } else {
                    habit.title = value;
                  }
                },
                controller: _titleController,
                decoration: InputDecoration(
                  errorText: (nameError == "") ? null : nameError,
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
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
                          colorError = "";
                          selectedIndex = index;
                        });
                        habit.color = index.toString();
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
              (selectedIndex != null)
                  ? const SizedBox.shrink()
                  : Text(
                    colorError,
                    style: TextStyle(color: Colors.red, fontSize: 10.sp),
                  ),
              SizedBox(height: 2.h),
              Text(
                'Description',
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2.h),
              TextField(
                onChanged: (value) {
                  if (descriptionError != "") {
                    setState(() {
                      descriptionError = "";
                    });
                  } else {
                    habit.description = value;
                  }
                },
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  errorText: (descriptionError == "") ? null : descriptionError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
                onChanged: (value) {
                  if (reasonError != "") {
                    setState(() {
                      reasonError = "";
                    });
                  } else {
                    habit.reason = value;
                  }
                },
                controller: _reasonController,
                decoration: InputDecoration(
                  errorText: (reasonError == "") ? null : reasonError,
                  labelText: 'Reason',
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 2.h),
              GestureDetector(
                onTap: () async {
                  if (!_validateInfo(setState)) {
                    return;
                  }
                  setState(() {
                    loading = 'loading';
                  });
                  habit.dateCreated = DateTime.now();
                  habit.state = true;
                  if (habitEddit != null) {
                    await Provider.of<HabitState>(
                      context,
                      listen: false,
                    ).updateHabit(context, habit);
                  } else {
                    await Provider.of<HabitState>(
                      context,
                      listen: false,
                    ).addHabit(context, habit);
                  }
                  setState(() {
                    loading = '';
                  });
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  width: 90.w,
                  height: 7.h,
                  alignment: Alignment.center,
                  child:
                      (loading == "")
                          ? Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                          : CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
