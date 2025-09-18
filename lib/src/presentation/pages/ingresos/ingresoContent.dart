// main.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tickets_ingresos/src/data/datasource/local/SharefPref.dart';
import 'package:tickets_ingresos/src/presentation/widget/CustomAppBar.dart';

class IngresoContent extends StatefulWidget {
  const IngresoContent({super.key});
  @override
  State<IngresoContent> createState() => _IngresoContentState();
}

// ... imports y clase iguales

class _IngresoContentState extends State<IngresoContent> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    torchEnabled: false,
    formats: const <BarcodeFormat>[
      BarcodeFormat.qrCode,
      BarcodeFormat.pdf417,
      BarcodeFormat.code128,
      BarcodeFormat.code39,
      BarcodeFormat.code93,
      BarcodeFormat.ean13,
      BarcodeFormat.ean8,
      BarcodeFormat.upcA,
      BarcodeFormat.upcE,
      BarcodeFormat.itf,
      BarcodeFormat.dataMatrix,
      BarcodeFormat.aztec,
      BarcodeFormat.codabar,
    ],
  );

  final SharefPref prefs = SharefPref();

  bool scanning = false; // indica si procesamos lecturas
  bool torchOn = false;
  String? lastValue;
  int scanCount = 0;

  static const Color successTint = Color(0xFF16A34A);
  static const Color neutralTint = Colors.transparent;
  Color bgColor = neutralTint;

  @override
  void initState() {
    super.initState();
    _ensureCounter();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _ensureCounter() async {
    final value = await prefs.read('scan_count');
    final loaded = (value is int) ? value : 0;
    setState(() => scanCount = loaded);
    if (value == null) await prefs.save('scan_count', 0);
  }

  Future<void> _saveCounter() async => prefs.save('scan_count', scanCount);

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (!scanning) return;                // 👈 ignorar si no estamos escaneando
    if (capture.barcodes.isEmpty) return;

    print("llegoo mario${capture.barcodes.first}");

    final b = capture.barcodes.first;
        print("llegoo mario${b.rawValue}");
        print("llegoo mario${b.displayValue }");

    final value = b.rawValue ?? b.displayValue ?? '';
    // aqui es donde viene la logica del bloc mario fernando munoz rivera
    setState(() {
      lastValue = value;
      scanCount += 1;
      bgColor = successTint.withOpacity(0.9);
    });
    await _saveCounter();

    // **No desmontamos el widget**; solo detenemos la cámara
    await _controller.stop();
    if (!mounted) return;
    setState(() => scanning = false);     // mostramos pantalla de éxito
  }

  Future<void> _toggleScan() async {

    if (scanning) {
      await _controller.stop();
      setState(() {
        scanning = false;
        bgColor = neutralTint;
        lastValue = null;
      });
    } else {
      setState(() {
        lastValue = null;
        bgColor = neutralTint;
      });
      await _controller.start();          // ✅ ya está adjunto, no se desmonta
      setState(() => scanning = true);
    }
  }

  Future<void> _toggleTorch() async {
    await _controller.toggleTorch();
    setState(() => torchOn = !torchOn);
  }

  Future<void> _resetAll({bool resetCounter = false}) async {
    setState(() {
      lastValue = null;
      bgColor = neutralTint;
    });
    if (resetCounter) {
      setState(() => scanCount = 0);
      await prefs.save('scan_count', 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool showSuccessScreen = !scanning && (lastValue != null);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Control de Acceso'),
      body: Stack(
        children: [
          // 👇 SIEMPRE montado: así el controller está adjunto
          Positioned.fill(
            child: MobileScanner(
              controller: _controller,
              onDetect: _onDetect,
            ),
          ),

          // Éxito (cubre toda la pantalla cuando ya leyó)
          if (showSuccessScreen)
            Positioned.fill(
              child: Container(
                color: bgColor,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle_rounded,
                        size: 96, color: Colors.white),
                    const SizedBox(height: 16),
                    Text('¡Lectura exitosa!',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        )),
                    const SizedBox(height: 12),
                    if (lastValue != null && lastValue!.isNotEmpty)
                      Text(lastValue!,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          )),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: _toggleScan, // volver a escanear
                      icon: const Icon(Icons.qr_code_scanner),
                      label: const Text('Escanear de nuevo'),
                    ),
                  ],
                ),
              ),
            ),

          // Barra superior + contador (igual que antes)
          Positioned(
            top: 16, left: 16, right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.45),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Icon(
                    showSuccessScreen
                        ? Icons.check_circle_outline
                        : Icons.center_focus_strong_rounded,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      showSuccessScreen
                          ? 'Listo. Pulsa “Escanear de nuevo”.'
                          : (scanning ? 'Escaneando…' : 'Listo para escanear'),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.qr_code_scanner, color: Colors.white, size: 18),
                            const SizedBox(width: 6),
                            Text('$scanCount',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error, color: Colors.white, size: 18),
                        const SizedBox(width: 6),
                        Text('$scanCount',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                    ],
                  ),

                 
                ],
              ),
            ),
          ),

          // Botonera inferior
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: const [BoxShadow(blurRadius: 18, color: Colors.black26, offset: Offset(0, -4))],
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _toggleScan,
                        icon: Icon(scanning ? Icons.pause_circle_filled_rounded : Icons.qr_code_scanner),
                        label: Text(scanning ? 'Pausar' : 'Escanear'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton.filledTonal(
                      onPressed: scanning ? _toggleTorch : null,
                      icon: Icon(torchOn ? Icons.flash_on_rounded : Icons.flash_off_rounded),
                      tooltip: 'Linterna',
                      style: IconButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () => _resetAll(resetCounter: true),
                      icon: const Icon(Icons.refresh, size: 28),
                      tooltip: 'Reiniciar contador a 0',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
