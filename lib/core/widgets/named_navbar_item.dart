import 'package:flutter/widgets.dart';

class NamedNavbarItem extends BottomNavigationBarItem {
  final String initialLocation;

  NamedNavbarItem({required this.initialLocation, required Widget icon, String? label}) : super(icon: icon, label: label);
}
