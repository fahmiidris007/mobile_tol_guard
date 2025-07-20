import 'package:flutter/material.dart';
import 'package:mobile_tol_guard/app/domain/entities/global.dart';
import 'package:mobile_tol_guard/core/services/injection.dart';

final BuildContext? _context =
    getIt<Global>().navigatorKey.currentState?.context;

Size get layerSize {
  return MediaQuery.of(_context!).size;
}

double get layerHeight {
  return MediaQuery.of(_context!).size.height;
}

double get layerWidth {
  return MediaQuery.of(_context!).size.width;
}

EdgeInsets get layerPadding {
  return MediaQuery.of(_context!).padding;
}

double get layerPaddingBottom {
  return MediaQuery.of(_context!).padding.bottom;
}

double get layerPaddingTop {
  return MediaQuery.of(_context!).padding.top;
}

EdgeInsets get layerViewPadding {
  return MediaQuery.of(_context!).viewPadding;
}

Size get windowSize => MediaQueryData.fromView(View.of(_context!)).size;

double get heightContent => layerHeight - kToolbarHeight - layerPaddingTop;
