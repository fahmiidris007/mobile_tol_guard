import 'package:flutter/material.dart';
import 'package:mobile_tol_guard/app/domain/entities/bottom_navbar_data.dart';
import 'package:mobile_tol_guard/app/presentation/widgets/button_navbar.dart';
import 'package:mobile_tol_guard/core/static_data/static_data.dart';
import 'package:mobile_tol_guard/core/util/assets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StaticData.listNavbar,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return BottomNavbar(
            hideCenterButton: false,
            listData: snapshot.data as List<BottomNavbarData>,
          );
        }
        return Container();
      },
    );
  }
}
