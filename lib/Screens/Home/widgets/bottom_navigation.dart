import 'package:flutter/material.dart';
import 'package:money_app/Screens/Home/screen_home.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: ScreenHome.updatedIntex,
        builder: (BuildContext ctx, int newindex, Widget? _) {
          return BottomNavigationBar(
              selectedItemColor: Colors.purple,
              unselectedItemColor: Colors.grey,
              currentIndex: newindex,
              onTap: (value) {
                ScreenHome.updatedIntex.value = value;
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: "Transactions"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: "Category")
              ]);
        });
  }
}
