// Author: Bilal Shahid
// For queries, contact me at bilalscheema@gmail.com

// ignore_for_file: overridden_fields

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'persistent-tab-view.dart';

class PersistentTabView extends PersistentTabViewBase {
  ///Screens that will be displayed on tapping of persistent bottom navigation bar items.
  @override
  final List<Widget> screens;
  final Widget playWidget;

  ///Controller for persistent bottom navigation bar. Will be declared if left empty.
  @override
  final PersistentTabController? controller;

  ///Background color of bottom navigation bar. `white` by default.
  @override
  final Color backgroundColor;

  ///A custom widget which is displayed at the bottom right of the display at all times.
  @override
  final Widget? floatingActionButton;

  ///Specifies the navBarHeight
  ///
  ///Defaults to `kBottomNavigationBarHeight` which is `56.0`.
  //final double navBarHeight;

  ///The margin around the navigation bar.
  @override
  final EdgeInsets margin;

  ///Will confine the NavBar's items in the safe area defined by the device.
  @override
  final bool confineInSafeArea;

  ///Handles android back button actions. Defaults to `true`.
  ///
  ///Action based on scenarios:
  ///1. If the you are on the first tab with all screens popped of the given tab, the app will close.
  ///2. If you are on another tab with all screens popped of that given tab, you will be switched to first tab.
  ///3. If there are screens pushed on the selected tab, a screen will pop on a respective back button press.
  @override
  final bool handleAndroidBackButtonPress;

  ///Bottom margin of the screen.
  @override
  final double? bottomScreenMargin;

  @override
  final bool resizeToAvoidBottomInset;

  ///Preserves the state of each tab's screen. `true` by default.
  @override
  final bool stateManagement;

  ///If you want to perform a custom action on Android when exiting the app, you can write your logic here. Returns context of the selected screen.
  @override
  final Future<bool> Function(BuildContext?)? onWillPop;

  ///Returns the context of the selected tab.
  @override
  final Function(BuildContext?)? selectedTabScreenContext;

  ///Screen transition animation properties when switching tabs.
  @override
  final ScreenTransitionAnimation screenTransitionAnimation;

  @override
  final bool hideNavigationBarWhenKeyboardShows;

  ///Hides the navigation bar with an transition animation. Use it in conjuction with [Provider](https://pub.dev/packages/provider) for better results.
  @override
  final bool? hideNavigationBar;

  @override
  final BuildContext context;

  PersistentTabView(this.context,
      {Key? key,
      required this.playWidget,
      List<PersistentBottomNavBarItem>? items,
      required this.screens,
      this.controller,
      double navBarHeight = kBottomNavigationBarHeight,
      this.margin = EdgeInsets.zero,
      this.backgroundColor = CupertinoColors.white,
      ValueChanged<int>? onItemSelected,
      this.floatingActionButton,
      NavBarPadding padding = const NavBarPadding.all(null),
      NavBarDecoration decoration = const NavBarDecoration(),
      this.resizeToAvoidBottomInset = false,
      this.bottomScreenMargin,
      this.selectedTabScreenContext,
      this.hideNavigationBarWhenKeyboardShows = true,
      bool popAllScreensOnTapOfSelectedTab = true,
      PopActionScreensType popActionScreens = PopActionScreensType.all,
      this.confineInSafeArea = true,
      this.onWillPop,
      this.stateManagement = true,
      this.handleAndroidBackButtonPress = true,
      ItemAnimationProperties? itemAnimationProperties,
      this.hideNavigationBar,
      this.screenTransitionAnimation = const ScreenTransitionAnimation(),
      NavBarStyle navBarStyle = NavBarStyle.simple})
      : super(
          key: key,
          context: context,
          screens: screens,
          controller: controller,
          margin: margin,
          items: items,
          padding: padding,
          decoration: decoration,
          hideNavigationBarWhenKeyboardShows:
              hideNavigationBarWhenKeyboardShows,
          itemAnimationProperties: itemAnimationProperties,
          navBarStyle: navBarStyle,
          popActionScreens: popActionScreens,
          popAllScreensOnTapOfSelectedTab: popAllScreensOnTapOfSelectedTab,
          navBarHeight: navBarHeight,
          backgroundColor: backgroundColor,
          onItemSelected: onItemSelected,
          floatingActionButton: floatingActionButton,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          bottomScreenMargin: bottomScreenMargin,
          onWillPop: onWillPop,
          isCustomWidget: false,
          confineInSafeArea: confineInSafeArea,
          stateManagement: stateManagement,
          handleAndroidBackButtonPress: handleAndroidBackButtonPress,
          hideNavigationBar: hideNavigationBar,
          screenTransitionAnimation: screenTransitionAnimation,
        ) {
    assert(items != null,
        "Items can only be null in case of custom navigation bar style. Please add the items!");
    assert(true,
        "NavBar styles 15-18 only accept 3 or 5 PersistentBottomNavBarItem items.");
    assert(items!.length == screens.length,
        "screens and items length should be same. If you are using the onPressed callback function of 'PersistentBottomNavBarItem', enter a dummy screen like Container() in its place in the screens");
    assert(items!.length >= 2 && items.length <= 6,
        "NavBar should have at least 2 or maximum 6 items (Except for styles 15-18)");
  }

  PersistentTabView.custom(
    this.context, {
    Key? key,
    required this.screens,
    required this.playWidget,
    this.controller,
    this.margin = EdgeInsets.zero,
    this.floatingActionButton,
    required Widget customWidget,
    required int itemCount,
    this.resizeToAvoidBottomInset = false,
    this.bottomScreenMargin,
    this.selectedTabScreenContext,
    this.hideNavigationBarWhenKeyboardShows = true,
    this.backgroundColor = CupertinoColors.white,
    CutsomWidgetRouteAndNavigatorSettings routeAndNavigatorSettings =
        const CutsomWidgetRouteAndNavigatorSettings(),
    this.confineInSafeArea = true,
    this.onWillPop,
    this.stateManagement = true,
    this.handleAndroidBackButtonPress = true,
    this.hideNavigationBar,
    this.screenTransitionAnimation = const ScreenTransitionAnimation(),
  }) : super(
          key: key,
          context: context,
          screens: screens,
          controller: controller,
          margin: margin,
          routeAndNavigatorSettings: routeAndNavigatorSettings,
          backgroundColor: backgroundColor,
          floatingActionButton: floatingActionButton,
          customWidget: customWidget,
          itemCount: itemCount,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          bottomScreenMargin: bottomScreenMargin,
          onWillPop: onWillPop,
          confineInSafeArea: confineInSafeArea,
          stateManagement: stateManagement,
          handleAndroidBackButtonPress: handleAndroidBackButtonPress,
          hideNavigationBar: hideNavigationBar,
          screenTransitionAnimation: screenTransitionAnimation,
          isCustomWidget: true,
          decoration: const NavBarDecoration(),
        ) {
    assert(itemCount == screens.length,
        "screens and items length should be same. If you are using the onPressed callback function of 'PersistentBottomNavBarItem', enter a dummy screen like Container() in its place in the screens");
    assert(
        routeAndNavigatorSettings.navigatorKeys == null ||
            routeAndNavigatorSettings.navigatorKeys != null &&
                routeAndNavigatorSettings.navigatorKeys!.length !=
                    items!.length,
        "Number of 'Navigator Keys' must be equal to the number of bottom navigation tabs.");
  }
}

class PersistentTabViewBase extends StatefulWidget {
  ///List of persistent bottom navigation bar items to be displayed in the navigation bar.
  final List<PersistentBottomNavBarItem>? items;

  ///Screens that will be displayed on tapping of persistent bottom navigation bar items.
  final List<Widget>? screens;

  ///Controller for persistent bottom navigation bar. Will be declared if left empty.
  final PersistentTabController? controller;

  ///Background color of bottom navigation bar. `white` by default.
  final Color? backgroundColor;

  ///Callback when page or tab change is detected.
  final ValueChanged<int>? onItemSelected;

  ///Specifies the curve properties of the NavBar.
  final NavBarDecoration? decoration;

  ///`padding` for the persistent navigation bar content. Accepts `NavBarPadding` instead of `EdgeInsets`.
  ///
  ///`USE WITH CAUTION, MAY CAUSE LAYOUT ISSUES`.
  final NavBarPadding? padding;

  ///Style for persistent bottom navigation bar. Accepts `NavBarStyle` to determine the theme.
  final NavBarStyle? navBarStyle;

  ///Style the `neumorphic` navigation bar item.
  ///
  ///Works only with style `neumorphic`.

  ///A custom widget which is displayed at the bottom right of the display at all times.
  final Widget? floatingActionButton;

  ///Specifies the navBarHeight
  ///
  ///Defaults to `kBottomNavigationBarHeight` which is `56.0`.
  final double? navBarHeight;

  ///The margin around the navigation bar.
  final EdgeInsets? margin;

  ///Custom navigation bar widget. To be only used when `navBarStyle` is set to `NavBarStyle.custom`.
  final Widget? customWidget;

  ///If using `custom` navBarStyle, define this instead of the `items` property
  final int? itemCount;

  ///Will confine the NavBar's items in the safe area defined by the device.
  final bool? confineInSafeArea;

  ///Handles android back button actions. Defaults to `true`.
  ///
  ///Action based on scenarios:
  ///1. If the you are on the first tab with all screens popped of the given tab, the app will close.
  ///2. If you are on another tab with all screens popped of that given tab, you will be switched to first tab.
  ///3. If there are screens pushed on the selected tab, a screen will pop on a respective back button press.
  final bool? handleAndroidBackButtonPress;

  ///Bottom margin of the screen.
  final double? bottomScreenMargin;

  ///If an already selected tab is pressed/tapped again, all the screens pushed on that particular tab will pop until the first screen in the stack. Defaults to `true`.
  final bool? popAllScreensOnTapOfSelectedTab;

  ///If set all pop until to first screen else set once pop once
  final PopActionScreensType? popActionScreens;

  final bool? resizeToAvoidBottomInset;

  ///Preserves the state of each tab's screen. `true` by default.
  final bool? stateManagement;

  ///If you want to perform a custom action on Android when exiting the app, you can write your logic here.
  final Future<bool> Function(BuildContext)? onWillPop;

  ///Screen transition animation properties when switching tabs.
  final ScreenTransitionAnimation? screenTransitionAnimation;

  final bool? hideNavigationBarWhenKeyboardShows;

  ///This controls the animation properties of the items of the NavBar.
  final ItemAnimationProperties? itemAnimationProperties;

  ///Hides the navigation bar with an transition animation. Use it in conjuction with [Provider](https://pub.dev/packages/provider) for better results.
  final bool? hideNavigationBar;

  ///Define navigation bar route name and settings here.
  ///
  ///If you want to programmatically pop to initial screen on a specific use this route name when popping.
  final CutsomWidgetRouteAndNavigatorSettings? routeAndNavigatorSettings;

  final bool? isCustomWidget;

  final BuildContext? context;

  final Function(BuildContext)? selectedTabScreenContext;

  const PersistentTabViewBase({
    Key? key,
    this.screens,
    this.controller,
    this.floatingActionButton,
    this.margin,
    this.confineInSafeArea,
    this.handleAndroidBackButtonPress,
    this.bottomScreenMargin,
    this.resizeToAvoidBottomInset,
    this.stateManagement,
    this.screenTransitionAnimation,
    this.hideNavigationBar,
    this.context,
    this.items,
    this.backgroundColor,
    this.onItemSelected,
    this.decoration,
    this.padding,
    this.navBarStyle,
    this.navBarHeight,
    this.customWidget,
    this.itemCount,
    this.popAllScreensOnTapOfSelectedTab,
    this.popActionScreens,
    this.onWillPop,
    this.hideNavigationBarWhenKeyboardShows,
    this.itemAnimationProperties,
    this.isCustomWidget,
    this.selectedTabScreenContext,
    this.routeAndNavigatorSettings,
  }) : super(key: key);

  @override
  State<PersistentTabView> createState() => _PersistentTabViewState();
}

class _PersistentTabViewState extends State<PersistentTabView> {
  late List<BuildContext?> _contextList;
  PersistentTabController? _controller;
  double? _navBarHeight;
  int? _previousIndex;
  int? _currentIndex;
  bool? _isCompleted;
  bool? _isAnimating;
  late bool _sendScreenContext;

  @override
  void initState() {
    super.initState();

    _contextList = List<BuildContext?>.filled(
        widget.items == null ? widget.itemCount ?? 0 : widget.items!.length,
        null);

    if (widget.controller == null) {
      _controller = PersistentTabController(initialIndex: 0);
    } else {
      _controller = widget.controller;
    }

    _previousIndex = _controller!.index;
    _currentIndex = _controller!.index;

    _isCompleted = false;
    _isAnimating = false;
    _sendScreenContext = false;

    _controller!.addListener(() {
      if (_controller!.index != _currentIndex) {
        if (widget.selectedTabScreenContext != null) {
          _sendScreenContext = true;
        }
        if (mounted) {
          setState(
            () => _currentIndex = _controller!.index,
          );
        }
      }
    });
    if (widget.selectedTabScreenContext != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.selectedTabScreenContext!(_contextList[_controller!.index]);
      });
    }
  }

  Widget _buildScreen(int index) {
    RouteAndNavigatorSettings routeAndNavigatorSettings = widget.isCustomWidget!
        ? RouteAndNavigatorSettings(
            defaultTitle: widget.routeAndNavigatorSettings!.defaultTitle,
            initialRoute: widget.routeAndNavigatorSettings!.initialRoute,
            navigatorKey:
                widget.routeAndNavigatorSettings!.navigatorKeys == null
                    ? null
                    : widget.routeAndNavigatorSettings!
                        .navigatorKeys![_controller!.index],
            navigatorObservers:
                widget.routeAndNavigatorSettings!.navigatorObservers,
            onGenerateRoute: widget.routeAndNavigatorSettings!.onGenerateRoute,
            onUnknownRoute: widget.routeAndNavigatorSettings!.onUnknownRoute,
            routes: widget.routeAndNavigatorSettings!.routes,
          )
        : widget.items![index].routeAndNavigatorSettings;

    if (widget.floatingActionButton != null) {
      return Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SizedBox.expand(
            child: CustomTabView(
              routeAndNavigatorSettings: routeAndNavigatorSettings,
              builder: (BuildContext screenContext) {
                _contextList[index] = screenContext;
                if (_sendScreenContext) {
                  _sendScreenContext = false;
                  widget.selectedTabScreenContext!(_contextList[index]);
                }
                return Material(elevation: 0, child: widget.screens[index]);
              },
            ),
          ),
          Positioned(
            bottom: widget.decoration!.borderRadius != BorderRadius.zero
                ? 25.0
                : 10.0,
            right: 10.0,
            child: widget.floatingActionButton!,
          ),
        ],
      );
    } else {
      return CustomTabView(
          routeAndNavigatorSettings: routeAndNavigatorSettings,
          builder: (BuildContext screenContext) {
            _contextList[index] = screenContext;
            if (_sendScreenContext) {
              _sendScreenContext = false;
              widget.selectedTabScreenContext!(_contextList[index]);
            }
            return Material(elevation: 0, child: widget.screens[index]);
          });
    }
  }

  Widget navigationBarWidget() => CupertinoPageScaffold(
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        backgroundColor: Colors.transparent,
        child: PersistentTabScaffold(
          controller: _controller,
          itemCount: widget.items == null
              ? widget.itemCount ?? 0
              : widget.items!.length,
          bottomScreenMargin:
              widget.hideNavigationBar != null && widget.hideNavigationBar!
                  ? 0.0
                  : widget.bottomScreenMargin,
          stateManagement: widget.stateManagement,
          screenTransitionAnimation: widget.screenTransitionAnimation,
          hideNavigationBarWhenKeyboardShows:
              widget.hideNavigationBarWhenKeyboardShows,
          resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
          animatePadding: _isAnimating! || _isCompleted!,
          tabBar: PersistentBottomNavBar(
            playWidget: widget.playWidget,
            navBarEssentials: NavBarEssentials(
              selectedIndex: _controller!.index,
              previousIndex: _previousIndex,
              padding: widget.padding,
              selectedScreenBuildContext: _contextList[_controller!.index],
              itemAnimationProperties: widget.itemAnimationProperties,
              items: widget.items,
              backgroundColor: widget.backgroundColor,
              navBarHeight: _navBarHeight,
              popScreensOnTapOfSelectedTab:
                  widget.popAllScreensOnTapOfSelectedTab ?? true,
              onItemSelected: widget.onItemSelected != null
                  ? (int index) {
                      if (_controller!.index != _previousIndex) {
                        _previousIndex = _controller!.index;
                      }
                      if ((widget.popAllScreensOnTapOfSelectedTab ?? true) &&
                          _previousIndex == index) {
                        popAllScreens();
                      }
                      _controller!.index = index;
                      widget.onItemSelected!(index);
                    }
                  : (int index) {
                      if (_controller!.index != _previousIndex) {
                        _previousIndex = _controller!.index;
                      }
                      if ((widget.popAllScreensOnTapOfSelectedTab ?? true) &&
                          _previousIndex == index) {
                        popAllScreens();
                      }
                      _controller!.index = index;
                    },
            ),
            isCustomWidget: widget.isCustomWidget,
            navBarDecoration: widget.decoration,
            margin: widget.margin,
            confineToSafeArea: widget.confineInSafeArea,
            hideNavigationBar: widget.hideNavigationBar,
            navBarStyle: widget.navBarStyle,
            customNavBarWidget: widget.customWidget,
            onAnimationComplete: (isAnimating, isCompleted) {
              if (_isAnimating != isAnimating) {
                setState(() {
                  _isAnimating = isAnimating;
                });
              }
              if (_isCompleted != isCompleted) {
                setState(() {
                  _isCompleted = isCompleted;
                });
              }
            },
          ),
          tabBuilder: (BuildContext context, int index) {
            return SafeArea(
              top: false,
              right: false,
              left: false,
              bottom: (widget.items != null &&
                          widget.items![_controller!.index].opacity < 1.0) ||
                      (widget.hideNavigationBar != null && _isCompleted!)
                  ? false
                  : widget.margin.bottom > 0
                      ? false
                      : widget.confineInSafeArea,
              child: _buildScreen(index),
            );
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    _navBarHeight = (widget.resizeToAvoidBottomInset &&
            MediaQuery.of(widget.context).viewInsets.bottom > 0 &&
            widget.hideNavigationBarWhenKeyboardShows)
        ? 0.0
        : widget.navBarHeight ?? kBottomNavigationBarHeight;
    if (_contextList.length != (widget.itemCount ?? widget.items!.length)) {
      _contextList = List<BuildContext?>.filled(
          (widget.items == null ? widget.itemCount ?? 0 : widget.items!.length),
          null);
    }

    if (widget.handleAndroidBackButtonPress || widget.onWillPop != null) {
      return WillPopScope(
        onWillPop: !widget.handleAndroidBackButtonPress &&
                widget.onWillPop != null
            ? widget.onWillPop!(_contextList[_controller!.index])
                as Future<bool> Function()?
            : widget.handleAndroidBackButtonPress && widget.onWillPop != null
                ? () async {
                    if (_controller!.index == 0 &&
                        !Navigator.canPop(_contextList.first!)) {
                      return widget.onWillPop!(_contextList.first);
                    } else {
                      if (Navigator.canPop(_contextList[_controller!.index]!)) {
                        Navigator.pop(_contextList[_controller!.index]!);
                      } else {
                        if (widget.onItemSelected != null) {
                          widget.onItemSelected!(0);
                        }
                        _controller!.index = 0;
                      }
                      return false;
                    }
                  }
                : () async {
                    if (_controller!.index == 0 &&
                        !Navigator.canPop(_contextList.first!)) {
                      return true;
                    } else {
                      if (Navigator.canPop(_contextList[_controller!.index]!)) {
                        Navigator.pop(_contextList[_controller!.index]!);
                      } else {
                        if (widget.onItemSelected != null) {
                          widget.onItemSelected!(0);
                        }
                        _controller!.index = 0;
                      }
                      return false;
                    }
                  },
        child: navigationBarWidget(),
      );
    } else {
      return navigationBarWidget();
    }
  }

  void popAllScreens() {
    if (widget.popAllScreensOnTapOfSelectedTab!) {
      if (widget.items![_controller!.index]
                  .onSelectedTabPressWhenNoScreensPushed !=
              null &&
          !Navigator.of(_contextList[_controller!.index]!).canPop()) {
        widget.items![_controller!.index]
            .onSelectedTabPressWhenNoScreensPushed!();
      }

      if (widget.popActionScreens == PopActionScreensType.once) {
        if (Navigator.of(_contextList[_controller!.index]!).canPop()) {
          Navigator.of(_contextList[_controller!.index]!).pop(context);
          return;
        }
      } else {
        Navigator.popUntil(
            _contextList[_controller!.index]!,
            ModalRoute.withName(widget.isCustomWidget!
                ? (widget.routeAndNavigatorSettings?.initialRoute ??
                    '/9f580fc5-c252-45d0-af25-9429992db112')
                : widget.items![_controller!.index].routeAndNavigatorSettings
                        .initialRoute ??
                    '/9f580fc5-c252-45d0-af25-9429992db112'));
      }
    }
  }
}

//asserts


