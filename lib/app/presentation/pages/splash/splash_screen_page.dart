import 'package:flutter/material.dart';
import 'package:mobile_tol_guard/app/domain/entities/constant.dart';
import 'package:mobile_tol_guard/app/presentation/pages/home/home_page.dart';
import 'package:mobile_tol_guard/app/presentation/pages/login/login_page.dart';
import 'package:mobile_tol_guard/app/presentation/widgets/base_page.dart';
import 'package:mobile_tol_guard/core/database/user_db.dart';
import 'package:mobile_tol_guard/core/util/assets.dart';
import 'package:mobile_tol_guard/core/util/layer_size.dart';
import 'package:mobile_tol_guard/core/util/navigation.dart';
import 'package:mobile_tol_guard/core/util/preferences.dart';
import 'package:mobile_tol_guard/core/util/spacing.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  checkLogin() async {
    var user = await UserDb.instance.getUser();
    if (user == null) {
      Prefs.setLanguage('id');
      Future.delayed(const Duration(seconds: 5));
      navigateOff(const LoginPage());
    } else {
      Future.delayed(const Duration(seconds: 5));
      navigateOff(const HomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: body(),
      padding: const EdgeInsets.all(24),
      extendBodyBehindAppBar: true,
      appBarHide: true,
    );
  }

  Widget body() {
    return Column(
      children: [
        verticalSpacing(layerPaddingTop),
        Expanded(
          child: Image.asset(
            Assets.imagesIcLogo,
            width: 200,
            height: 126.8,
          ),
        ),
      ],
    );
  }
}
