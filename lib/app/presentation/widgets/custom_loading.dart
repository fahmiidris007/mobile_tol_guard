import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_tol_guard/app/domain/entities/global.dart';
import 'package:mobile_tol_guard/core/services/injection.dart';

class LoadingScaffold extends StatelessWidget {
  final String? message;
  const LoadingScaffold({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(
              height: 12.0,
            ),
            if (message != null)
              Text(
                "$message",
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

showLoading({
  String? message,
}) async {
  BuildContext? context = getIt<Global>().navigatorKey.currentState?.context;
  await showDialog<void>(
    context: context!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            width: 110,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Align(
                  child: Wrap(
                    children: [
                      const SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        message ?? 'Loading...',
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

hideLoading() async {
  Get.back();
}
