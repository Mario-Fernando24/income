import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tickets_ingresos/src/data/datasource/local/SharefPref.dart';
import 'package:tickets_ingresos/src/domain/models/request/configurate_request.dart';
import 'package:tickets_ingresos/src/presentation/utils/const/PreferenceKeys.dart';

class Configurateservices {

  Future<bool> saveConfigurate(ConfigurateRequest config) async {
    final prefs = SharefPref();

    final jsonConfig = jsonEncode({
      "name": config.name,
      "apiName": config.apiName,
      "logo": config.logo,
      "needScan": config.needScan,
      "colorPrimary": config.colorPrimary,
      "colorSecondary": config.colorSecondary,
    });
    await prefs.save(PreferenceKeys.appConfiguration, jsonConfig);
    
    return true;
    
  }

  Future<ConfigurateRequest?> getConfigurate() async {
    final prefs = SharefPref();
    final jsonString = await prefs.read(PreferenceKeys.appConfiguration);

    if (jsonString == null) return null;

    final Map<String, dynamic> jsonData = jsonDecode(jsonString);

    print("OBJETOOOOOOOOOOO PETICION");

   print(jsonData);
    print("OBJETOOOOOOOOOOO PETICION");

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




