class IngresoResponse {
  final bool success;
  final String message;
  final IngresoData? data;
  final String? fechaIngresoAnterior;

  IngresoResponse({
    required this.success,
    required this.message,
    this.data,
    this.fechaIngresoAnterior,
  });

  factory IngresoResponse.fromJson(Map<String, dynamic> json) {
    return IngresoResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json.containsKey('data') && json['data'] != null)
          ? IngresoData.fromJson(json['data'])
          : null, // 👈 solo lo mapea si existe
      fechaIngresoAnterior: json['fecha_ingreso_anterior'],
    );
  }
}

class IngresoData {
  final int boletaId;
  final String eventoTransaccionId;
  final String evento;
  final String zona;
  final Persona persona;
  final String fechaIngreso;

  IngresoData({
    required this.boletaId,
    required this.eventoTransaccionId,
    required this.evento,
    required this.zona,
    required this.persona,
    required this.fechaIngreso,
  });

  factory IngresoData.fromJson(Map<String, dynamic> json) {
    return IngresoData(
      boletaId: json['boleta_id'],
      eventoTransaccionId: json['evento_transaccion_id'],
      evento: json['evento'],
      zona: json['zona'],
      persona: Persona.fromJson(json['persona']),
      fechaIngreso: json['fecha_ingreso'],
    );
  }
}

class Persona {
  final String nombres;
  final String apellido1;
  final String apellido2;
  final String documento;

  Persona({
    required this.nombres,
    required this.apellido1,
    required this.apellido2,
    required this.documento,
  });

  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(
      nombres: json['nombres'],
      apellido1: json['apellido_1'],
      apellido2: json['apellido_2'],
      documento: json['documento'],
    );
  }
}
