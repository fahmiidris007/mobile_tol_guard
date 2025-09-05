import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_tol_guard/core/util/app_theme.dart';
import 'package:mobile_tol_guard/core/util/layer_size.dart';
import 'package:mobile_tol_guard/core/util/spacing.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class BasePage extends StatefulWidget {
  final String title;
  final EdgeInsets? padding;
  final bool hideBackButton;
  final Function()? backNavigation;
  final bool appBarHide;
  final Color? appBarColor;
  final Widget? appbarLeading;
  final Widget? appbarTrailing;
  final Color? backgroundColour;
  final Widget body;
  final Widget? footer;
  final EdgeInsets paddingFooter;
  final bool? resizeToAvoidBottomInset;
  final bool extendBodyBehindAppBar;
  final String? backgroundImage;
  final bool hasScrollBody;
  final bool nestedFooter;
  final bool progressPage;
  final int totalProgressPage;
  final int currentProgressPage;
  final Widget? floatingActionButton;

  const BasePage({
    super.key,
    this.title = '',
    this.padding,
    this.hideBackButton = false,
    this.backNavigation,
    this.appBarHide = false,
    this.appBarColor = AppTheme.white,
    this.appbarLeading,
    this.appbarTrailing,
    this.backgroundColour = AppTheme.white,
    required this.body,
    this.footer,
    this.paddingFooter = EdgeInsets.zero,
    this.resizeToAvoidBottomInset = true,
    this.extendBodyBehindAppBar = false,
    this.backgroundImage,
    this.hasScrollBody = false,
    this.nestedFooter = false,
    this.progressPage = false,
    this.totalProgressPage = 1,
    this.currentProgressPage = 1,
    this.floatingActionButton,
  });

  @override
  State<StatefulWidget> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  Size appBarSize = Size.zero;
  double contentHeight = layerHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        appBar: widget.appBarHide ? null : _appBar(),
        body: _body(),
        floatingActionButton: widget.floatingActionButton,
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: widget.appBarColor,
      elevation: 0,
      centerTitle: true,
      leading: Row(
        children: [
          if (!widget.hideBackButton)
            IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: widget.backNavigation ?? () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppTheme.black,
              ),
            ),
          if (widget.appbarLeading != null) widget.appbarLeading!,
        ],
      ),
      title: Text(
        widget.title,
        style: AppTheme.custom(
          size: 16,
          weight: FontWeight.w600,
          color: AppTheme.black,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        widget.appbarTrailing ?? Container(),
      ],
      bottom: widget.progressPage
          ? PreferredSize(
              preferredSize: Size(layerWidth, 4),
              child: StepProgressIndicator(
                totalSteps: widget.totalProgressPage,
                currentStep: widget.currentProgressPage,
                size: 4,
                padding: 0,
                unselectedColor: AppTheme.black20,
                roundedEdges: const Radius.circular(2),
                selectedGradientColor: AppTheme.gradientViolet,
              ),
            )
          : null,
    );
  }

  Widget _body() {
    appBarSize = widget.appBarHide ? Size.zero : (_appBar().preferredSize);
    contentHeight =
        layerHeight - (!widget.extendBodyBehindAppBar ? appBarSize.height : 0);

    return Center(
      child: Container(
        height: contentHeight,
        width: layerWidth > 550 ? 550 : layerWidth,
        decoration: BoxDecoration(
          color: widget.backgroundColour,
          image: widget.backgroundImage != null
              ? DecorationImage(
                  image: AssetImage(widget.backgroundImage!),
                  fit: BoxFit.fill,
                )
              : null,
        ),
        child: widget.nestedFooter
            ? body()
            : CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: widget.hasScrollBody,
                    child: body(),
                  ),
                ],
              ),
      ),
    );
  }

  Widget body() {
    return Padding(
      padding: !widget.nestedFooter
          ? EdgeInsets.only(
              left: widget.padding?.left ?? 0,
              right: widget.padding?.right ?? 0,
            )
          : EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!widget.nestedFooter) verticalSpacing(widget.padding?.top),
          Expanded(
            child: widget.nestedFooter
                ? CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: widget.padding?.left ?? 0,
                            right: widget.padding?.right ?? 0,
                          ),
                          child: Column(
                            children: [
                              verticalSpacing(widget.padding?.top),
                              widget.body,
                              verticalSpacing(widget.padding?.bottom),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : widget.body,
          ),
          if (!widget.nestedFooter) verticalSpacing(),
          if (widget.footer != null)
            Padding(
              padding: widget.paddingFooter,
              child: Padding(
                padding: widget.nestedFooter
                    ? EdgeInsets.only(
                        left: widget.padding?.left ?? 0,
                        right: widget.padding?.right ?? 0,
                      )
                    : EdgeInsets.zero,
                child: Column(
                  children: [
                    verticalSpacing(widget.paddingFooter.top > 0
                        ? widget.paddingFooter.top
                        : 16),
                    widget.footer!,
                    verticalSpacing(widget.paddingFooter.bottom > 0
                        ? widget.paddingFooter.bottom
                        : layerPaddingBottom >= 24
                            ? layerPaddingBottom
                            : 24)
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
