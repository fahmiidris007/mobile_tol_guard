import 'package:flutter/material.dart';
import 'package:mobile_tol_guard/app/domain/entities/bottom_navbar_data.dart';

class BottomNavbar extends StatefulWidget {
  final List<BottomNavbarData> listData;

  const BottomNavbar({
    super.key,
    required this.listData,
  });

  @override
  State<StatefulWidget> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  var bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.listData.map((e) => e.page).toList()[bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavIndex,
        onTap: (index) {
          if (widget.listData[index].isPage) {
            setState(() {
              bottomNavIndex = index;
            });
          } else {
            widget.listData[index].onTap?.call();
          }
        },
        items: widget.listData.map((data) {
          return BottomNavigationBarItem(
            icon: Image.asset(
              data.icon,
              width: 24,
              height: 24,
            ),
            label: data.title,
          );
        }).toList(),
      ),
    );
  }
}
