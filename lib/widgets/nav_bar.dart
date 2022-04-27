import "package:flutter/material.dart";
import "my_bottom_navigation_bar_item.dart";
import "my_bottom_navigation_bar_item_widget.dart";
class MyBottomNavigationBar extends StatelessWidget {

MyBottomNavigationBar({
    Key? key,
    this.containerHeight = 56,
    this.itemCornerRadius = 50,
    this.curve = Curves.linear,
    this.bgColor,
    this.showElevation = true,
    this.selectedPosition = 1,
    required this.onItemSelected,
    required this.items,
    this.iconSize = 24,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,

}) : assert(items.length >= 2 && items.length <= 5),
super(key: key);

final List<MyBottomNavigationBarItem> items;
final int selectedPosition;
final Duration animationDuration;
final bool showElevation;
final double iconSize;
final Color? bgColor;
final Curve curve;
final double itemCornerRadius;
final double containerHeight;
final MainAxisAlignment mainAxisAlignment;
final ValueChanged<int> onItemSelected;

@override
Widget build(BuildContext context) {
final backgroundColor = bgColor ?? Theme.of(context).bottomAppBarColor;

return Container(
decoration: BoxDecoration(
color: backgroundColor,
boxShadow: [
if (showElevation)
const BoxShadow(
color: Colors.black12,
blurRadius: 2,
),
],
),
child: SafeArea(
child: Container(
padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
width: double.infinity,
height: containerHeight,
child: Row(
mainAxisAlignment: mainAxisAlignment,
children: items.map((item) {
var index = items.indexOf(item);
return GestureDetector(
onTap: () => onItemSelected(index),
child: MyBottomNavigationBarItemWidget(
iconSize: iconSize,
isSelected: index == selectedPosition,
backgroundColor: backgroundColor,
animationDuration: animationDuration,
item: item,
itemCornerRadius: itemCornerRadius,
curve: curve,
),
);
}).toList(),
),
),
),
);
}
}