import "package:flutter/material.dart";

class MyBottomNavigationBarItem {

final Widget title;
final Widget icon;
final TextAlign? textAlign;
final Color? activeColor;
final Color? inactiveColor;

MyBottomNavigationBarItem({
    required this.title,
    required this.icon,
    this.textAlign,
    this.activeColor,
    this.inactiveColor,
});

}