import 'package:flutter/material.dart';

class NavigationItemModel {
  final int index;
  final String name;
  final IconData icon;
  final String path;
  final Widget widget;

  NavigationItemModel({
    required this.index,
    required this.name,
    required this.icon,
    required this.path,
    required this.widget,
  });
}
