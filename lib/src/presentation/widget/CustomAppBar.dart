import 'package:flutter/material.dart';
import 'package:tickets_ingresos/src/config/app_theme.dart';
import 'package:tickets_ingresos/src/domain/models/request/configurate_request.dart';
import 'package:tickets_ingresos/src/presentation/utils/functions/getData.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  final double elevation;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.centerTitle = true,
    this.elevation = 2.0,
    this.showBackButton = true,
  });

  // Función para convertir string hex a Color
  Color _hexToColor(String? hex, {Color fallback = Colors.white}) {
    if (hex == null || hex.isEmpty) return fallback;
    String formatted = hex.replaceAll('#', '');
    if (formatted.length == 6) formatted = 'FF$formatted';
    return Color(int.parse(formatted, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    final dataApp = DataApp();

    return FutureBuilder<ConfigurateRequest?>(
      future: dataApp.getConfiguratePreference(),
      builder: (context, snapshot) {
        final config = snapshot.data;
        final primaryColor = _hexToColor(config?.colorPrimary, fallback: Theme.of(context).primaryColor);
        final secondaryColor = _hexToColor(config?.colorSecondary, fallback: AppColors.textLightWhite);

        return AppBar(
          leading: showBackButton
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  color: secondaryColor,
                  onPressed: () => Navigator.of(context).pop(),
                )
              : null,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: secondaryColor,
              fontFamily: 'MontserratSemiBold',
            ),
          ),
          actions: actions,
          centerTitle: centerTitle,
          elevation: elevation,
          backgroundColor: primaryColor,
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
