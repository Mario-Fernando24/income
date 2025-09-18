import 'dart:convert';

import 'package:dio/dio.dart';

class IngresoServices {
  Future<bool> ingresoEvento(String qr) async {
    try {
      Dio dio = Dio();
      String url =
          "https://tickets.dnpmotors.com/BackTK/public/api/boletas/validar-ingreso";
      dio.options.headers = {'Content-Type': 'application/json'};
      Map<String, dynamic> body = {'qr_data': qr};
      final response = await dio.post(url, data: json.encode(body));

      print("ingresooooooooooooooo");
      print(response.data);
      print("ingresooooooooooooooo");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (e is DioException) {
        return false;
      } else {
        return false;
      }
    }
  }
}
