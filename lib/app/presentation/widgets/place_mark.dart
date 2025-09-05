import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:mobile_tol_guard/app/presentation/widgets/button.dart';
import 'package:mobile_tol_guard/core/util/navigation.dart';

class PlacemarkWidget extends StatelessWidget {
  const PlacemarkWidget({
    super.key,
    required this.placemark,
  });

  final geo.Placemark placemark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(maxWidth: 700),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 20,
            offset: Offset.zero,
            color: Colors.grey.withOpacity(0.5),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  placemark.street!,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  '${placemark.subLocality}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Button(
                    onPressed: () {
                      navigatePop(true);
                    },
                    text: 'Select This Location',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
