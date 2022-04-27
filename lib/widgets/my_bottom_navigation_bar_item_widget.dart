import "package:flutter/material.dart";
import "my_bottom_navigation_bar_item.dart";

class MyBottomNavigationBarItemWidget extends StatelessWidget {
final bool isSelected;
final double iconSize;
final Color backgroundColor;
final Duration animationDuration;
final double itemCornerRadius;
final MyBottomNavigationBarItem item;
final Curve curve;

const MyBottomNavigationBarItemWidget({
    Key? key,
    required this.isSelected,
    required this.iconSize,
    required this.backgroundColor,
    required this.animationDuration,
    required this.itemCornerRadius,
    required this.item,
    this.curve = Curves.linear,
}) : super(key: key);

@override
Widget build(BuildContext context) {
return Semantics(
selected: isSelected,
container: true,
child: AnimatedContainer(
duration: animationDuration,
curve: curve,
width: isSelected ? 120 : 60,
height: double.maxFinite,
decoration: BoxDecoration(
color: isSelected ? item.activeColor?.withOpacity(0.2) : backgroundColor,
borderRadius: BorderRadius.circular(itemCornerRadius),
),
child: SingleChildScrollView(
physics: NeverScrollableScrollPhysics(),
scrollDirection: Axis.horizontal,
child: Container(
padding: EdgeInsets.symmetric(horizontal: 10),
width: isSelected ? 120 : 60,
child: Row(
crossAxisAlignment: CrossAxisAlignment.center,
mainAxisAlignment: MainAxisAlignment.start,
mainAxisSize: MainAxisSize.max,
children: <Widget>[
IconTheme(
data: IconThemeData(
size: iconSize,
color: isSelected
? item.activeColor?.withOpacity(1)
: item.inactiveColor == null
? item.activeColor
: item.inactiveColor,
),
child: item.icon,
),
if (isSelected)
Expanded(
child: Container(
padding: EdgeInsets.symmetric(horizontal: 4),
child: DefaultTextStyle.merge(
child: item.title,
textAlign: item.textAlign,
style: TextStyle(
color: item.activeColor,
fontWeight: FontWeight.bold,
),
maxLines: 1,
),
),
),
],
),
),
),
),
);
}
}