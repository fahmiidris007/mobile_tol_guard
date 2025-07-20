import 'package:flutter/material.dart';
import 'package:mobile_tol_guard/core/translator/translator.dart';
import 'package:mobile_tol_guard/core/util/app_theme.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        translator.home,
        style: AppTheme.title(),
      ),
    );
  }
}
