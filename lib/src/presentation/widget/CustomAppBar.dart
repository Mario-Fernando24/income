import 'package:flutter/material.dart';
import 'package:tickets_ingresos/src/config/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool centerTitle;
  final Color ?color;
  final double elevation;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.backgroundColor,
    this.centerTitle = true,
    this.color = AppColors.textLightWhite,
    this.elevation = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style:  TextStyle(
          fontSize: 20,
          color: color,
          fontFamily: 'MontserratSemiBold',
        ),
      ),
      actions: actions,
      centerTitle: centerTitle,
      elevation: elevation,
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
