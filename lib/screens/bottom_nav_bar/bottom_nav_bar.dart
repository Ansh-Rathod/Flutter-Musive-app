import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:spotify_clone/utils/bottom_nav_bar/persistent-tab-view.dart';
import '../../controllers/main_controller.dart';
import '../../utils/bottom_nav_bar/persistent-tab-view.widget.dart';
import '../current_playing/current_player.dart';
import '../library/library.dart';
import '../search_page/search_page.dart';

import '../../utils/bottom_nav_bar_widget.dart';
import '../../utils/bottom_play_widget.dart';
import '../home/home_screen.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  String _currentPage = "Page1";
  List<String> pageKeys = ["Page1", "Page2", "Page3"];
  final Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Page1": GlobalKey<NavigatorState>(),
    "Page2": GlobalKey<NavigatorState>(),
    "Page3": GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "Page1") {
            _selectTab("Page1", 1);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: ChangeNotifierProvider(
        create: (context) => MainController()..init(),
        child: Consumer<MainController>(
          builder: (context, con, child) {
            return Scaffold(
              extendBody: true,
              resizeToAvoidBottomInset: true,
              body: Stack(
                children: <Widget>[
                  _buildOffstageNavigator(con, "Page1"),
                  _buildOffstageNavigator(con, "Page2"),
                  _buildOffstageNavigator(con, "Page3"),
                ],
              ),
              bottomNavigationBar: CustomCupertinoTabBar(
                bottomPlayWidget: PlayWidget(
                    con: con,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        isDismissible: false,
                        builder: (context) => CurrentPlayer(
                          con: con,
                        ),
                      );
                      // Navigator.push(
                      //     context,
                      //     CupertinoPageRoute(
                      //       builder: (context) => CurrentPlayer(
                      //         con: con,
                      //       ),
                      //     ));
                    }),
                activeColor: Colors.white,
                backgroundColor: Colors.transparent,
                iconSize: 24.0,
                onTap: (int index) {
                  _selectTab(pageKeys[index], index);
                },
                currentIndex: _selectedIndex,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(LineIcons.home),
                    label: 'Home',
                    activeIcon: Icon(LineIcons.home),
                  ),
                  BottomNavigationBarItem(
                    activeIcon: Icon(CupertinoIcons.search),
                    label: 'Search',
                    icon: Icon(CupertinoIcons.search),
                  ),
                  BottomNavigationBarItem(
                    label: 'Library',
                    activeIcon: Icon(CupertinoIcons.music_albums),
                    icon: Icon(CupertinoIcons.music_albums),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(MainController con, String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        con: con,
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}

class TabNavigator extends StatelessWidget {
  const TabNavigator({
    Key? key,
    required this.navigatorKey,
    required this.tabItem,
    required this.con,
  }) : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;
  final MainController con;

  @override
  Widget build(BuildContext context) {
    Widget child = Container();
    if (tabItem == "Page1") {
      child = HomeScreen(con: con);
    } else if (tabItem == "Page2") {
      child = SearchPage(con: con);
    } else if (tabItem == "Page3") {
      child = Library(con: con);
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return CupertinoPageRoute(builder: (context) => child);
      },
    );
  }
}

class BottomNavBarThree extends StatefulWidget {
  const BottomNavBarThree({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavBarThree> createState() => _BottomNavBarThreeState();
}

class _BottomNavBarThreeState extends State<BottomNavBarThree> {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);
  @override
  void initState() {
    super.initState();
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          inactiveIcon: const Icon(LineIcons.home),
          activeColorSecondary: Colors.white,
          activeColorPrimary: Colors.grey),
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.search),
          inactiveIcon: const Icon(CupertinoIcons.search),
          activeColorSecondary: Colors.white,
          activeColorPrimary: Colors.grey),
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.music_albums),
          inactiveIcon: const Icon(CupertinoIcons.music_albums),
          activeColorSecondary: Colors.white,
          activeColorPrimary: Colors.grey),
    ];
  }

  List<Widget> _buildScreens(con) {
    return [HomeScreen(con: con), SearchPage(con: con), Library(con: con)];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MainController()..init(),
        child: Consumer<MainController>(builder: (context, con, child) {
          return PersistentTabView(
            context,
            controller: controller,
            playWidget: Material(
              child: PlayWidget(
                  con: con,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      isDismissible: false,
                      builder: (context) => CurrentPlayer(
                        con: con,
                      ),
                    );
                    // Navigator.push(
                    //     context,
                    //     CupertinoPageRoute(
                    //       builder: (context) => CurrentPlayer(
                    //         con: con,
                    //       ),
                  }),
            ),
            screens: _buildScreens(con),
            items: _navBarsItems(),
            confineInSafeArea: true,
            backgroundColor: Colors.black,
            handleAndroidBackButtonPress: true,
            hideNavigationBarWhenKeyboardShows: true,
            resizeToAvoidBottomInset: true,
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            navBarStyle: NavBarStyle.simple,
            navBarHeight: 55,
            padding: const NavBarPadding.all(0),
          );
        }));
  }
}
