import 'package:flutter/material.dart';
import 'package:tickets_ingresos/src/config/sample_config.dart';
import 'package:tickets_ingresos/src/presentation/widget/CustomAppBar.dart';
import 'package:tickets_ingresos/src/presentation/widget/Switch/disableSwitch.dart';
import 'package:tickets_ingresos/src/presentation/widget/TextField/ColorField.dart';
import 'package:tickets_ingresos/src/presentation/widget/TextField/ModernField.dart';
import 'package:tickets_ingresos/src/presentation/widget/headers/HeaderPreview.dart';
import 'package:tickets_ingresos/src/presentation/widget/title/sectionTitle.dart';

class ConfigurationContent extends StatefulWidget {
  const ConfigurationContent({super.key});

  @override
  State<ConfigurationContent> createState() => _ConfigurationContentState();
}

class _ConfigurationContentState extends State<ConfigurationContent> {
  final nameAppController = TextEditingController();
  final nameEmpresaController = TextEditingController();
  final apiController = TextEditingController();
  final logoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Tickets'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeaderPreview(
                name: AppConfig.sampleConfig.displayName,
                primaryHex: AppConfig.sampleConfig.primary,
                accentHex: AppConfig.sampleConfig.accent,
              ),
              const SizedBox(height: 16),
              const SectionTitle('Organización'),
              ModernField(hint: 'App', controller: nameAppController),
              ModernField(
                controller: nameEmpresaController,
                hint: 'Nombre visible de la App',
              ),

              const SizedBox(height: 12),
              const SectionTitle('COLORES'),
              Row(
                children: [
                  Expanded(
                    child: ColorField(
                      label: 'Primary (#RRGGBB)',
                      initial: AppConfig.sampleConfig.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ColorField(
                      label: 'Accent (#RRGGBB)',
                      initial: AppConfig.sampleConfig.accent,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              const SectionTitle('API'),
              ModernField(
                controller: apiController,
                hint: 'https://api.App.com',
                keyboard: TextInputType.url,
              ),

              const SizedBox(height: 12),
              const SectionTitle('FEATURES'),
              // Switches deshabilitados para mantener "sin lógica"
              DisabledSwitch(
                title: 'Beep on Scan',
                value: AppConfig.sampleConfig.beepOnScan,
                subtitle: 'Reproducir sonido al validar',
              ),

              const SizedBox(height: 12),
              const SectionTitle('ASSETS'),
              ModernField(
                controller: logoController,
                hint: 'assets/App/logo.png',
              ),

              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: null,
                icon: const Icon(Icons.save),
                label: const Text('Guardar (UI Only)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

