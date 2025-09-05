import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

class Utility {
  static Widget buildImage(String imageUrl) {
    if (imageUrl.startsWith('/data/') || imageUrl.startsWith('file://')) {
      return Image.file(
        File(imageUrl),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          log("Error loading image from file: $imageUrl, Error: $error");
          return Icon(Icons.broken_image, size: 50);
        },
      );
    } else if (imageUrl.startsWith('http://') ||
        imageUrl.startsWith('https://')) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          log("Error loading image from network: $imageUrl, Error: $error");
          return Icon(Icons.broken_image, size: 50);
        },
      );
    } else {
      return Image.asset(
        imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) {
          log("Error loading image from asset: $imageUrl, Error: $error");
          return Icon(Icons.broken_image, size: 50);
        },
      );
    }
  }
}
