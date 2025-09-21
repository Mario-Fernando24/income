import 'dart:convert';
import 'package:dio/dio.dart';

class IngresoServices {
  final Dio _dio;

  IngresoServices()
      : _dio = Dio(BaseOptions(
          baseUrl: "https://tickets.dnpmotors.com/BackTK/public/api",
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {'Content-Type': 'application/json'},
        ));

  /// Valida el QR en la API y devuelve un Map con resultado
  Future<Map<String, dynamic>> ingresoEvento(String qr) async {
    try {
      print("📡 Enviando QR: $qr");

      final response = await _dio.post(
        "/boletas/validar-ingreso",
        data: jsonEncode({'qr_data': qr}),
        options: Options(
          validateStatus: (status) => true, // evita excepción de Dio
        ),
      );

      print("✅ Status: ${response.statusCode}, Data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "success": true,
          "data": response.data,
        };
      } else {
        return {
          "success": false,
          "message":
              response.data?['message'] ?? "Error en la validación del QR",
          "status": response.statusCode,
          "data": response.data,
        };
      }
    } on DioException catch (e) {
      print("❌ DioException: ${e.message}");
      return {
        "success": false,
        "message": e.response?.data?['message'] ?? "Error de conexión",
        "status": e.response?.statusCode,
      };
    } catch (e) {
      print("⚠️ Error inesperado: $e");
      return {
        "success": false,
        "message": "Error desconocido",
      };
    }
  }
}
