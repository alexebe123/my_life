import 'package:flutter/material.dart';
import 'package:my_life/screen/main_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});
  static const screenRoute = 'base_screen';
  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // الصفحات
  final List<Widget> _pages = [
    MainScreen(),
    const Center(child: Text('🔍 البحث', style: TextStyle(fontSize: 24))),
    const Center(child: Text('⚙️ الإعدادات', style: TextStyle(fontSize: 24))),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
        // تمكين التمرير إذا أراد المستخدم السحب اليدوي مع الاحتفاظ بسلاسة الانتقال
        physics: const BouncingScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            // استبدال jumpToPage بـ animateToPage لإضافة انزلاق سلس
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeInOut,
            );
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'البحث'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'الإعدادات',
          ),
        ],
      ),
    );
  }
}
