// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' show ImageFilter;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Standard iOS 10 tab bar height.

const Color _kDefaultTabBarBorderColor = CupertinoDynamicColor.withBrightness(
  color: Color(0x4C000000),
  darkColor: Color(0x29000000),
);
const Color _kDefaultTabBarInactiveColor = CupertinoColors.inactiveGray;

class CustomCupertinoTabBar extends StatelessWidget
    implements PreferredSizeWidget {
  /// Creates a tab bar in the iOS style.
  const CustomCupertinoTabBar({
    Key? key,
    required this.items,
    required this.bottomPlayWidget,
    this.onTap,
    this.currentIndex = 0,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor = _kDefaultTabBarInactiveColor,
    this.iconSize = 30.0,
    this.border = const Border(
      top: BorderSide(
        color: _kDefaultTabBarBorderColor,
        width: 0.0, // 0.0 means one physical pixel
      ),
    ),
  })  : assert(
          items.length >= 2,
          "Tabs need at least 2 items to conform to Apple's HIG",
        ),
        assert(0 <= currentIndex && currentIndex < items.length),
        super(key: key);

  final List<BottomNavigationBarItem> items;
  final Widget bottomPlayWidget;

  final ValueChanged<int>? onTap;

  final int currentIndex;
  final Color? backgroundColor;
  final Color? activeColor;
  final Color inactiveColor;
  final double iconSize;
  final Border? border;

  @override
  Size get preferredSize => const Size.fromHeight(100);

  /// Indicates whether the tab bar is fully opaque or can have contents behind
  /// it show through it.
  bool opaque(BuildContext context) {
    final Color backgroundColor =
        this.backgroundColor ?? CupertinoTheme.of(context).barBackgroundColor;
    return CupertinoDynamicColor.resolve(backgroundColor, context).alpha ==
        0xFF;
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    final Color backgroundColor = CupertinoDynamicColor.resolve(
      this.backgroundColor ?? CupertinoTheme.of(context).barBackgroundColor,
      context,
    );

    BorderSide resolveBorderSide(BorderSide side) {
      return side == BorderSide.none
          ? side
          : side.copyWith(
              color: CupertinoDynamicColor.resolve(side.color, context));
    }

    final Border? resolvedBorder =
        border == null || border.runtimeType != Border
            ? border
            : Border(
                top: resolveBorderSide(border!.top),
                left: resolveBorderSide(border!.left),
                bottom: resolveBorderSide(border!.bottom),
                right: resolveBorderSide(border!.right),
              );

    final Color inactive =
        CupertinoDynamicColor.resolve(inactiveColor, context);
    Widget result = DecoratedBox(
      decoration: BoxDecoration(
        border: resolvedBorder,
        color: Colors.black,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          bottomPlayWidget,
          Container(
            child: IconTheme.merge(
              // Default with the inactive state.
              data: IconThemeData(color: inactive, size: iconSize),
              child: DefaultTextStyle(
                // Default with the inactive state.
                style: CupertinoTheme.of(context)
                    .textTheme
                    .tabLabelTextStyle
                    .copyWith(color: inactive),
                child: Semantics(
                  explicitChildNodes: true,
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                      child: Container(
                        color: Colors.black.withOpacity(.7),
                        padding:
                            EdgeInsets.only(bottom: bottomPadding, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: _buildTabItems(context),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return result;
  }

  List<Widget> _buildTabItems(BuildContext context) {
    final List<Widget> result = <Widget>[];
    final CupertinoLocalizations localizations =
        CupertinoLocalizations.of(context);

    for (int index = 0; index < items.length; index += 1) {
      final bool active = index == currentIndex;
      result.add(
        _wrapActiveItem(
          context,
          SizedBox(
            width: 115,
            child: Semantics(
              selected: active,
              hint: localizations.tabSemanticsLabel(
                tabIndex: index + 1,
                tabCount: items.length,
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onTap == null
                    ? null
                    : () {
                        onTap!(index);
                      },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _buildSingleTabItem(items[index], active),
                  ),
                ),
              ),
            ),
          ),
          active: active,
        ),
      );
    }

    return result;
  }

  List<Widget> _buildSingleTabItem(BottomNavigationBarItem item, bool active) {
    return <Widget>[
      const SizedBox(height: 5),
      Center(child: active ? item.activeIcon : item.icon),
      const SizedBox(height: 4),
      if (item.label != null) Text(item.label!),
    ];
  }

  /// Change the active tab item's icon and title colors to active.
  Widget _wrapActiveItem(BuildContext context, Widget item,
      {required bool active}) {
    if (!active) return item;

    final Color activeColor = CupertinoDynamicColor.resolve(
      this.activeColor ?? CupertinoTheme.of(context).primaryColor,
      context,
    );
    return IconTheme.merge(
      data: IconThemeData(color: activeColor),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: activeColor),
        child: item,
      ),
    );
  }

  /// Create a clone of the current [CustomCupertinoTabBar] but with provided
  /// parameters overridden.
  CustomCupertinoTabBar copyWith({
    Key? key,
    List<BottomNavigationBarItem>? items,
    Color? backgroundColor,
    Color? activeColor,
    Color? inactiveColor,
    double? iconSize,
    Border? border,
    int? currentIndex,
    Widget? bottomPlayWidget,
    ValueChanged<int>? onTap,
  }) {
    return CustomCupertinoTabBar(
      bottomPlayWidget: bottomPlayWidget ?? this.bottomPlayWidget,
      key: key ?? this.key,
      items: items ?? this.items,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      activeColor: activeColor ?? this.activeColor,
      inactiveColor: inactiveColor ?? this.inactiveColor,
      iconSize: iconSize ?? this.iconSize,
      border: border ?? this.border,
      currentIndex: currentIndex ?? this.currentIndex,
      onTap: onTap ?? this.onTap,
    );
  }
}
