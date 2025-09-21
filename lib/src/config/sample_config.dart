import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tickets_ingresos/src/data/datasource/local/SharefPref.dart';

class AppConfig {
  static const sampleConfig = (
    id: 'Nombre App',
    displayName: 'Configuración',
    primary: '#195E3D',
    accent: '#FAFFFD',
    apiBase: 'https://api.App.com',
    beepOnScan: true,
    logo: 'assets/App/logo.png',
    soundOk: 'assets/App/ok.mp3',
    soundDeny: 'assets/App/deny.mp3',
  );

  static const String _prefsKey = "appConfiguration";

  final SharefPref _prefs = SharefPref();

  /// Guardar configuración en preferencias
  Future<void> save(Map<String, dynamic> config) async {
    final jsonConfig = jsonEncode(config);
    await _prefs.save(_prefsKey, jsonConfig);
  }

  /// Cargar configuración desde preferencias o usar por defecto
  Future<Map<String, dynamic>> load() async {
    final jsonString = await _prefs.read(_prefsKey);
    if (jsonString != null) {
      try {
        return jsonDecode(jsonString) as Map<String, dynamic>;
      } catch (e) {
        debugPrint("❌ Error cargando config, usando default: $e");
        return sampleConfigToMap();
      }
    }
    return sampleConfigToMap();
  }

  /// Convertir el record `sampleConfig` en Map
  Map<String, dynamic> sampleConfigToMap() {
    return {
      "id": sampleConfig.id,
      "displayName": sampleConfig.displayName,
      "primary": sampleConfig.primary,
      "accent": sampleConfig.accent,
      "apiBase": sampleConfig.apiBase,
      "beepOnScan": sampleConfig.beepOnScan,
      "logo": sampleConfig.logo,
      "soundOk": sampleConfig.soundOk,
      "soundDeny": sampleConfig.soundDeny,
    };
  }

  /// Obtener color primario
  Future<String> getPrimaryColor() async {
    final config = await load();
    return config["primary"] ?? sampleConfig.primary;
  }

  /// Obtener color secundario
  Future<String> getSecondaryColor() async {
    final config = await load();
    return config["accent"] ?? sampleConfig.accent;
  }


}
