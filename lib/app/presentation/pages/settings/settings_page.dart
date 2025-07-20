import 'package:flutter/material.dart';
import 'package:mobile_tol_guard/app/presentation/widgets/base_page.dart';
import 'package:mobile_tol_guard/core/translator/translator.dart';
import 'package:mobile_tol_guard/core/util/app_theme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BasePage(body: body());
  }

  Widget body() {
    return Center(
      child: Text(
        translator.settings,
        style: AppTheme.title(),
      ),
    );
  }
}
