// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';

import '../persistent-tab-view.dart';

class PersistentBottomNavBar extends StatelessWidget {
  const PersistentBottomNavBar({
    Key? key,
    this.navBarEssentials,
    this.margin,
    required this.playWidget,
    this.navBarDecoration,
    this.navBarStyle,
    this.customNavBarWidget,
    this.confineToSafeArea,
    this.hideNavigationBar,
    this.onAnimationComplete,
    this.isCustomWidget = false,
  }) : super(key: key);

  final NavBarEssentials? navBarEssentials;
  final EdgeInsets? margin;
  final Widget playWidget;
  final NavBarDecoration? navBarDecoration;
  final NavBarStyle? navBarStyle;
  final Widget? customNavBarWidget;
  final bool? confineToSafeArea;
  final bool? hideNavigationBar;
  final Function(bool, bool)? onAnimationComplete;
  final bool? isCustomWidget;

  Widget _navBarWidget() => Padding(
        padding: margin!,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            playWidget,
            Container(
              decoration: getNavBarDecoration(
                decoration: navBarDecoration,
                showBorder: false,
                color: navBarEssentials!.backgroundColor,
                opacity: navBarEssentials!
                    .items![navBarEssentials!.selectedIndex!].opacity,
              ),
              child: ClipRRect(
                borderRadius:
                    navBarDecoration!.borderRadius ?? BorderRadius.zero,
                child: Container(
                  height: 55,
                  decoration: getNavBarDecoration(
                    showOpacity: false,
                    decoration: navBarDecoration,
                    color: navBarEssentials!.backgroundColor,
                    opacity: navBarEssentials!
                        .items![navBarEssentials!.selectedIndex!].opacity,
                  ),
                  child: SafeArea(
                    top: false,
                    right: false,
                    left: false,
                    bottom: navBarEssentials!.navBarHeight == 0.0 ||
                            (hideNavigationBar ?? false)
                        ? false
                        : confineToSafeArea ?? true,
                    child: getNavBarStyle()!,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return hideNavigationBar == null
        ? _navBarWidget()
        : OffsetAnimation(
            hideNavigationBar: hideNavigationBar,
            navBarHeight: navBarEssentials!.navBarHeight,
            onAnimationComplete: (isAnimating, isComplete) {
              onAnimationComplete!(isAnimating, isComplete);
            },
            child: _navBarWidget(),
          );
  }

  PersistentBottomNavBar copyWith(
      {int? selectedIndex,
      double? iconSize,
      int? previousIndex,
      Color? backgroundColor,
      Duration? animationDuration,
      List<PersistentBottomNavBarItem>? items,
      ValueChanged<int>? onItemSelected,
      double? navBarHeight,
      EdgeInsets? margin,
      NavBarStyle? navBarStyle,
      double? horizontalPadding,
      Widget? customNavBarWidget,
      Function(int)? popAllScreensForTheSelectedTab,
      bool? popScreensOnTapOfSelectedTab,
      NavBarDecoration? navBarDecoration,
      NavBarEssentials? navBarEssentials,
      bool? confineToSafeArea,
      ItemAnimationProperties? itemAnimationProperties,
      Function? onAnimationComplete,
      bool? hideNavigationBar,
      bool? isCustomWidget,
      Widget? playWidget,
      EdgeInsets? padding}) {
    return PersistentBottomNavBar(
        playWidget: playWidget ?? this.playWidget,
        confineToSafeArea: confineToSafeArea ?? this.confineToSafeArea,
        margin: margin ?? this.margin,
        navBarStyle: navBarStyle ?? this.navBarStyle,
        hideNavigationBar: hideNavigationBar ?? this.hideNavigationBar,
        customNavBarWidget: customNavBarWidget ?? this.customNavBarWidget,
        onAnimationComplete:
            onAnimationComplete as dynamic Function(bool, bool)? ??
                this.onAnimationComplete,
        navBarEssentials: navBarEssentials ?? this.navBarEssentials,
        isCustomWidget: isCustomWidget ?? this.isCustomWidget,
        navBarDecoration: navBarDecoration ?? this.navBarDecoration);
  }

  bool opaque(int? index) {
    return navBarEssentials!.items == null
        ? true
        : !(navBarEssentials!.items![index!].opacity < 1.0);
  }

  Widget? getNavBarStyle() {
    if (isCustomWidget!) {
      return customNavBarWidget;
    } else {
      return BottomNavSimple(
        navBarEssentials: navBarEssentials,
      );
    }
  }
}
