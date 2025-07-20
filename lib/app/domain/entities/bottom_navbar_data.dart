class BottomNavbarData {
  String icon;
  String title;
  dynamic page;
  bool isPage;
  Function()? onTap;
  bool visible;

  BottomNavbarData({
    required this.icon,
    required this.title,
    this.page,
    this.isPage = true,
    this.onTap,
    this.visible = true,
  });
}
