import 'package:torch_light/torch_light.dart';

/// Encender o apagar la linterna
/// Retorna `true` si la linterna está encendida, `false` si está apagada
Future<void> toggleTorch(bool isOn) async {
  try {
    if (isOn) {
      await TorchLight.enableTorch(); // Enciende la linterna
    } else {
      await TorchLight.disableTorch(); // Apaga la linterna
    }
  } on Exception {
    // Si hay un error (no hay linterna, permisos, etc.)
    print("error al encender la linterna");
  }
}
