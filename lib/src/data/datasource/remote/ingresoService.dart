import 'package:dio/dio.dart';
import 'package:tickets_ingresos/src/domain/models/response/IngresoResponse.dart';

class IngresoServices {
  Future<IngresoResponse> ingresoEvento(String qr) async {
    final Dio _dio = Dio();

    try {
      print("Enviando QR => $qr");

      final response = await _dio.post(
        "https://tickets.dnpmotors.com/BackTK/public/api/boletas/validar-ingreso",
        data: {'qr_data': qr},
        options: Options(validateStatus: (_) => true),
      );

      print("Response  => ${response.data}");

      final statusCode = response.statusCode ?? 500;
      final responseData = response.data;

      if (statusCode == 200 || statusCode == 201) {
        return IngresoResponse.fromJson(responseData);
      }

      print("DIOS ES AMOR  => ${response.data}");

      // aunque venga "success:false" también lo parseamos con el factory
      return IngresoResponse.fromJson(responseData);
    } on DioException catch (e) {
      return IngresoResponse(
        success: false,
        message: e.response?.data?['message'] ??
            (e.type == DioExceptionType.connectionTimeout
                ? "Tiempo de conexión agotado"
                : "Error de conexión"),
        data: null,
      );
    } catch (e, s) {
      print("Error inesperado: $e");
      print("Stack: $s");
      return IngresoResponse(
        success: false,
        message: "Error desconocido",
        data: null,
      );
    }
  }
}
