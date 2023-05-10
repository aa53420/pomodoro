import 'package:flutter/material.dart';
import 'package:pomodoro/screens/about/about_screen.dart';
import 'package:pomodoro/screens/config/config_screen.dart';
import 'package:pomodoro/screens/timer/timer_screen.dart';
import '../models/navigation_item_model.dart';

class NavigationService {
  NavigationService._privateConstructor();

  static final NavigationService _instance =
      NavigationService._privateConstructor();

  factory NavigationService() {
    return _instance;
  }

  int _currentIndex = 0;
  int _oldIndex = 0;

  final List<NavigationItemModel> _items = [
    NavigationItemModel(
      index: 0,
      name: "Timer",
      icon: Icons.home,
      path: "/timer",
      widget: const TimerScreen(),
    ),
    NavigationItemModel(
      index: 1,
      name: "Config",
      icon: Icons.settings,
      path: "/config",
      widget: const ConfigScreen(),
    ),
    // NavigationItemModel(
    //   index: 2,
    //   name: "About",
    //   icon: Icons.help,
    //   path: "/about",
    //   widget: const AboutScreen(),
    // ),
  ];

  NavigationItemModel _findItemByIndex(int targetIndex) {
    NavigationItemModel item = _items.firstWhere(
        (item) => item.index == targetIndex,
        orElse: () => _items[0]);
    return item;
  }

  int getCurrentIndex() {
    return _currentIndex;
  }

  int getOldIndex() {
    return _oldIndex;
  }

  String getNameByCurrentIndex() {
    return _findItemByIndex(_currentIndex).name;
  }

  String getPathByIndex(int index) {
    return _findItemByIndex(index).path;
  }

  Widget getWidgetByIndex(int index) {
    return _findItemByIndex(index).widget;
  }

  void _routePushReplacementByIndex({
    required BuildContext context,
    required int index,
  }) {
    int oldIndex = NavigationService().getOldIndex();
    if (oldIndex == index) {
      return;
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
            NavigationService().getWidgetByIndex(index),
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }

  BottomNavigationBar getBottomNavigationBar({
    Color? backgroundColor,
    required BuildContext context,
    void Function(int)? onTab,
  }) {
    return BottomNavigationBar(
      backgroundColor: backgroundColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: _currentIndex,
      onTap: (index) {
        _oldIndex = _currentIndex;
        _currentIndex = index;

        onTab == null
            ? _routePushReplacementByIndex(context: context, index: index)
            : onTab(index);
      },
      items: [
        for (var i = 0; i < _items.length; i++)
          BottomNavigationBarItem(
            icon: Icon(_items[i].icon),
            label: _items[i].name,
          )
      ],
    );
  }
}

class NavigationUtil {
  static void routeByIndex({
    required BuildContext context,
    required int index,
  }) {}
}
