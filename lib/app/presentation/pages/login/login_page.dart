import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_tol_guard/app/domain/entities/constant.dart';
import 'package:mobile_tol_guard/app/presentation/cubit/auth/auth_cubit.dart';
import 'package:mobile_tol_guard/app/presentation/pages/home/home_page.dart';
import 'package:mobile_tol_guard/app/presentation/widgets/base_page.dart';
import 'package:mobile_tol_guard/app/presentation/widgets/button.dart';
import 'package:mobile_tol_guard/app/presentation/widgets/custom_loading.dart';
import 'package:mobile_tol_guard/app/presentation/widgets/text_field.dart';
import 'package:mobile_tol_guard/core/services/injection.dart';
import 'package:mobile_tol_guard/core/translator/translator.dart';
import 'package:mobile_tol_guard/core/util/app_theme.dart';
import 'package:mobile_tol_guard/core/util/assets.dart';
import 'package:mobile_tol_guard/core/util/layer_size.dart';
import 'package:mobile_tol_guard/core/util/navigation.dart';
import 'package:mobile_tol_guard/core/util/preferences.dart';
import 'package:mobile_tol_guard/core/util/spacing.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      appBarHide: true,
      body: body(),
      footer: footer(),
      padding: const EdgeInsets.all(32),
    );
  }

  Widget body() {
    return Column(
      children: [
        verticalSpacing(layerPaddingTop),
        header(),
        verticalSpacing(48),
        Semantics(
          identifier: 'input_username',
          child: CustomTextField(
            controller: usernameController,
            label: translator.username,
            setUpperCase: true,
            disableSpace: true,
            alphanumericOnly: true,
          ),
        ),
        verticalSpacing(),
        Semantics(
          identifier: 'input_password',
          child: CustomTextField(
            controller: passwordController,
            label: translator.password,
            inputType: TextInputType.visiblePassword,
            obscureText: !showPassword,
            trailing: Semantics(
              identifier: 'button_show_password',
              child: GestureDetector(
                onTap: () => setState(() {
                  showPassword = !showPassword;
                }),
                child: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off),
              ),
            ),
          ),
        ),
        verticalSpacing(24),
        Button(
          onPressed: () async {
            /// TODO : implement this if backend is already
            // getIt<AuthCubit>().login(
            //   username: usernameController.text,
            //   password: passwordController.text);
            showLoading();
            Future.delayed(const Duration(seconds: 3), () {
              hideLoading();
              navigateOff(const HomePage());
            });
          },
          text: translator.login,
        ),
      ],
    );
  }

  Widget footer() {
    return Container();
  }

  Widget header() {
    return SizedBox(
      width: layerWidth,
      height: 160,
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              Assets.imagesIcLogo,
              width: 160,
              height: 100,
            ),
          ),
          Positioned(
            right: 0,
            child: Row(
              children: [
                Semantics(
                  identifier: 'button_language',
                  child: InkWell(
                    onTap: () async {
                      Get.updateLocale(Constant.localeEn);
                      await Prefs.setLanguage(Constant.localeEn.languageCode);
                      setState(() {});
                    },
                    child: AnimatedContainer(
                      width: 32,
                      height: 24,
                      duration: const Duration(milliseconds: 500),
                      decoration: BoxDecoration(
                        color: Get.locale?.languageCode ==
                                Constant.localeEn.languageCode
                            ? AppTheme.blue50
                            : AppTheme.blue10,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(100),
                          bottomLeft: Radius.circular(100),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          Constant.localeEn.languageCode.toUpperCase(),
                          style: AppTheme.subtitle3(
                            color: Get.locale?.languageCode ==
                                    Constant.localeEn.languageCode
                                ? AppTheme.white
                                : AppTheme.blue50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Semantics(
                  identifier: 'button_set_language',
                  child: InkWell(
                    onTap: () async {
                      Get.updateLocale(Constant.localeId);
                      await Prefs.setLanguage(Constant.localeId.languageCode);
                      setState(() {});
                    },
                    child: AnimatedContainer(
                      width: 32,
                      height: 24,
                      duration: const Duration(milliseconds: 500),
                      decoration: BoxDecoration(
                        color: Get.locale?.languageCode ==
                                Constant.localeId.languageCode
                            ? AppTheme.blue50
                            : AppTheme.blue10,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(100),
                          bottomRight: Radius.circular(100),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          Constant.localeId.languageCode.toUpperCase(),
                          style: AppTheme.subtitle3(
                            color: Get.locale?.languageCode ==
                                    Constant.localeId.languageCode
                                ? AppTheme.white
                                : AppTheme.blue50,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
