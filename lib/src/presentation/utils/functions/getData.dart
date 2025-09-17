 import 'dart:convert';
import 'dart:ui';

import 'package:tickets_ingresos/src/config/app_theme.dart';
import 'package:tickets_ingresos/src/data/datasource/local/SharefPref.dart';
import 'package:tickets_ingresos/src/domain/models/request/configurate_request.dart';
import 'package:tickets_ingresos/src/presentation/utils/const/PreferenceKeys.dart';


class DataApp {
  Future<ConfigurateRequest?> getConfiguratePreference() async {
    final prefs = SharefPref();
    final jsonString = await prefs.read(PreferenceKeys.appConfiguration);

    if (jsonString == null) {
      return ConfigurateRequest(
      name: "NOMBRE APP",
      apiName: "",
      logo: "",
      needScan: false,
      colorPrimary: AppColors.primary.value.toRadixString(16).padLeft(8, '0').substring(2),
      colorSecondary: const Color.fromARGB(255, 236, 233, 229).value.toRadixString(16).padLeft(8, '0').substring(2),
    );
    }

    final Map<String, dynamic> jsonData = jsonDecode(jsonString);

    return ConfigurateRequest(
      name: jsonData["name"],
      apiName: jsonData["apiName"],
      logo: jsonData["logo"],
      needScan: jsonData["needScan"] ?? false,
      colorPrimary: jsonData["colorPrimary"],
      colorSecondary: jsonData["colorSecondary"],
    );
  }
}
