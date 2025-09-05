import 'package:flutter/material.dart';
import 'package:mobile_tol_guard/app/domain/entities/constant.dart';
import 'package:mobile_tol_guard/app/presentation/pages/add_place/add_place_page.dart';
import 'package:mobile_tol_guard/app/presentation/pages/maps/maps_page.dart';
import 'package:mobile_tol_guard/app/presentation/widgets/base_page.dart';
import 'package:mobile_tol_guard/core/static_data/static_data.dart';
import 'package:mobile_tol_guard/core/util/app_theme.dart';
import 'package:mobile_tol_guard/core/util/navigation.dart';

import '../../../domain/entities/map_item_data.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<MapItemData> streetEvent = [];

  @override
  void initState() {
    super.initState();
    // temp data, change if backend api is ready
    streetEvent = StaticData.streetEvent;
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: Constant.appName,
      body: body(),
      padding: EdgeInsets.all(24),
      floatingActionButton: floatingActionButton(),
      hideBackButton: true,
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        children: streetEvent.map((e) {
          return InkWell(
            onTap: () => navigateTo(MapsPage(
              firstPlace: e,
            )),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                spacing: 10,
                children: [
                  Row(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        e.imageUrl,
                        width: 150,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                      Expanded(
                        child: Column(
                          spacing: 16,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.name ?? '',
                              maxLines: 2,
                              textAlign: TextAlign.justify,
                              style: AppTheme.title(),
                            ),
                            Text(
                              e.latLng.toString(),
                              maxLines: 2,
                              textAlign: TextAlign.justify,
                              style: AppTheme.caption(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: AppTheme.grey,
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget floatingActionButton() {
    return FloatingActionButton(
      onPressed: () => navigateTo(AddPlacePage()),
      child: Icon(Icons.add),
    );
  }
}
