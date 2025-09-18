//IngresoContent
import 'package:flutter/material.dart';
import 'package:tickets_ingresos/src/config/app_theme.dart';
import 'package:tickets_ingresos/src/presentation/utils/functions/toggleTorch.dart';
import 'package:tickets_ingresos/src/presentation/widget/CustomAppBar.dart';
import 'package:tickets_ingresos/src/presentation/widget/ingreso/CameraPlaceholder.dart';
import 'package:tickets_ingresos/src/presentation/widget/ingreso/ChipCounter.dart';
import 'package:tickets_ingresos/src/presentation/widget/ingreso/ScanFrame.dart';

class IngresoContent extends StatefulWidget {
  const IngresoContent({super.key});

  @override
  State<IngresoContent> createState() => _IngresoContentState();
}


class _IngresoContentState extends State<IngresoContent>
    with SingleTickerProviderStateMixin {
  bool torchOn = false;

  @override
  void dispose() {
    super.dispose();
    toggleTorch(false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
       appBar: const CustomAppBar(title: 'Control de acceso'),
      body: Stack(
        children: [
          // 1) Vista de cámara
          Positioned.fill(
            child: Container(
              color: Colors.black,
              child: const CameraPlaceholder(), // TODO: reemplaza por tu preview real
            ),
          ),

          // 2) Marco de escaneo
          Positioned.fill(child: ScanFrame()),

          // 3) Barra de estado superior (overlay)
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.45),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 18,
                    spreadRadius: 0,
                    color: Colors.green,
                  )
                ],
              ),
              child: Column(
                children: [
                  ChipCounter(icon: Icons.check,  value: 1, color: const Color(0xFF2563EB)),
                  const SizedBox(width: 8),
                  ChipCounter(icon: Icons.close, value: 39, color: const Color(0xFFDC2626)),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      Icon(Icons.center_focus_strong_rounded, color: Colors.white),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "EXITOSO",
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(Icons.refresh, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // 4) Botonera inferior
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16 + 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: const [
                  BoxShadow(blurRadius: 18, color: Colors.black26, offset: Offset(0, -4)),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () {},
                        icon: Icon(Icons.qr_code ,
                        ),
                        label: Text('Escanear'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton.filledTonal(
                      onPressed: (){
                        setState(() {
                          torchOn = !torchOn;
                          toggleTorch(torchOn);
                        });
                      },
                      icon: Icon(torchOn ? Icons.flash_on_rounded : Icons.flash_off_rounded),
                      tooltip: 'Linterna',
                      style: IconButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                    ),
                     Icon(Icons.refresh, size: 30,color: AppColors.textPrimary,weight: 30.0,),

                    const SizedBox(width: 8),
                 
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


