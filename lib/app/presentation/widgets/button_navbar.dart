import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_tol_guard/app/domain/entities/bottom_navbar_data.dart';
import 'package:mobile_tol_guard/core/util/app_theme.dart';
import 'package:mobile_tol_guard/core/util/spacing.dart';

class BottomNavbar extends StatefulWidget {
  final List<BottomNavbarData> listData;
  final String? centerButtonIcon;
  final Function()? centerButtonOnTap;
  final bool hideCenterButton;

  const BottomNavbar({
    super.key,
    required this.listData,
    this.centerButtonIcon,
    this.centerButtonOnTap,
    this.hideCenterButton = false,
  });

  @override
  State<StatefulWidget> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  var bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.listData.map((e) => e.page).toList()[bottomNavIndex],
      floatingActionButton:
          !widget.hideCenterButton && widget.centerButtonIcon != null
              ? InkWell(
                  onTap: widget.centerButtonOnTap ?? () {},
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      shape: BoxShape.circle,
                      boxShadow: AppTheme.boxShadow,
                    ),
                    child: Container(
                      width: 56,
                      height: 54,
                      padding: const EdgeInsets.symmetric(horizontal: 9),
                      decoration: const BoxDecoration(
                        color: AppTheme.black20,
                        shape: BoxShape.circle,
                        gradient: AppTheme.gradientBlue2,
                      ),
                      child: Image.asset(
                        widget.centerButtonIcon!,
                        width: 38,
                        height: 14,
                      ),
                    ),
                  ),
                )
              : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: widget.listData.length,
        tabBuilder: (int index, bool isActive) {
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 16 : 0,
              right: index == (widget.listData.length - 1) ? 16 : 0,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    widget.listData[index].icon,
                    width: 24,
                    height: 24,
                  ),
                  verticalSpacing(4),
                  Text(
                    widget.listData[index].title,
                    style: AppTheme.custom(
                      size: 7,
                      weight: FontWeight.w600,
                      color: AppTheme.black,
                    ),
                  )
                ],
              ),
            ),
          );
        },
        borderColor: AppTheme.white,
        backgroundColor: AppTheme.white,
        elevation: 0,
        activeIndex: bottomNavIndex,
        splashSpeedInMilliseconds: 0,
        notchMargin: 0,
        notchSmoothness: NotchSmoothness.sharpEdge,
        gapLocation:
            widget.hideCenterButton ? GapLocation.none : GapLocation.center,
        onTap: (index) {
          if (widget.listData[index].isPage) {
            setState(() {
              bottomNavIndex = index;
            });
          } else {
            widget.listData[index].onTap?.call();
          }
        },
      ),
    );
  }
}
