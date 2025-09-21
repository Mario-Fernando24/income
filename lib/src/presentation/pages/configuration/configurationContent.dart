import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickets_ingresos/src/config/app_routes.dart';
import 'package:tickets_ingresos/src/config/sample_config.dart';
import 'package:tickets_ingresos/src/presentation/bloc/configuration_bloc/ConfigurationBloc.dart';
import 'package:tickets_ingresos/src/presentation/bloc/configuration_bloc/ConfigurationEvent.dart';
import 'package:tickets_ingresos/src/presentation/bloc/configuration_bloc/ConfigurationState.dart';
import 'package:tickets_ingresos/src/presentation/utils/blocFormItem.dart';
import 'package:tickets_ingresos/src/presentation/widget/Button/DefaultButton.dart';
import 'package:tickets_ingresos/src/presentation/widget/CustomAppBar.dart';
import 'package:tickets_ingresos/src/presentation/widget/Switch/ToggleSwitch.dart';
import 'package:tickets_ingresos/src/presentation/widget/TextField/TextFormField.dart';
import 'package:tickets_ingresos/src/presentation/widget/colores/ColorPickerField.dart';
import 'package:tickets_ingresos/src/presentation/widget/headers/HeaderPreview.dart';
import 'package:tickets_ingresos/src/presentation/widget/Title/sectionTitle.dart';

// ignore: must_be_immutable
class ConfigurationContent extends StatefulWidget {
  final ConfigurationState state;
  const ConfigurationContent(this.state, {super.key});

  @override
  State<ConfigurationContent> createState() => _ConfigurationContentState();
}

class _ConfigurationContentState extends State<ConfigurationContent> {
  late ConfigurationState state;

  final _formKey = GlobalKey<FormState>(); // ✅ aquí

  // Controllers y FocusNodes estables
  final _nameCtrl = TextEditingController();
  final _apiCtrl = TextEditingController();
  final _logoCtrl = TextEditingController();

  final _nameFocus = FocusNode();
  final _apiFocus = FocusNode();
  final _logoFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    context.read<ConfigurationBloc>().add(LoadConfiguration());
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _apiCtrl.dispose();
    _logoCtrl.dispose();
    _nameFocus.dispose();
    _apiFocus.dispose();
    _logoFocus.dispose();
    super.dispose();
  }

  // Sincroniza SOLO cuando el usuario no está escribiendo en ese campo.
  void _syncControllers(ConfigurationState s) {
    final name = s.name.value ?? '';
    final api = s.apiName.value ?? '';
    final logo = s.logo.value ?? '';

    if (!_nameFocus.hasFocus && _nameCtrl.text != name) _nameCtrl.text = name;
    if (!_apiFocus.hasFocus && _apiCtrl.text != api) _apiCtrl.text = api;
    if (!_logoFocus.hasFocus && _logoCtrl.text != logo) _logoCtrl.text = logo;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConfigurationBloc, ConfigurationState>(
      // ✅ Solo escuchamos cambios de status para no spamear SnackBars
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, newState) {
        // Sincroniza cuando el bloc termina una operación (éxito/fallo)
        _syncControllers(newState);

        if (newState.status == FormStatus.success) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('✅ Configuración guardada con éxito!'),
              ),
            );

          Navigator.pushNamed(context, AppRoutes.welcome);

          // Opcional: pide resetear el status si tu bloc no lo hace
          // context.read<ConfigurationBloc>().add(ResetStatus());
        } else if (newState.status == FormStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  '❌ ${newState.errorMessage ?? "Error al guardar configuración"}',
                ),
              ),
            );
          // context.read<ConfigurationBloc>().add(ResetStatus());
        }
      },
      builder: (context, newState) {
        state = newState;

        // Asegura la primera sincronización (ej. primer frame post-carga)
        _syncControllers(newState);

        return Stack(
          children: [
            Scaffold(
              appBar: const CustomAppBar(title: 'Tickets'),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                     key: _formKey, // ✅ usar key estable del State
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        HeaderPreview(
                          name:
                              (_nameCtrl.text.isNotEmpty)
                                  ? _nameCtrl.text
                                  : AppConfig.sampleConfig.displayName,
                          primaryHex:
                              state.colorPrimary.value ??
                              AppConfig.sampleConfig.primary,
                          accentHex:
                              state.colorSecundary.value ??
                              AppConfig.sampleConfig.accent,
                        ),

                        const SizedBox(height: 16),
                        const SectionTitle('Organización'),
                        DefaultTextField(
                          controller: _nameCtrl,
                          focusNode: _nameFocus,
                          onChanged: (text) {
                            context.read<ConfigurationBloc>().add(
                              NameChanged(name: BlocFormItem(value: text)),
                            );
                          },
                          text: 'Nombre de la app',
                          icon: Icons.apps_outlined,
                          validate: (_) => state.name.error,
                        ),

                        const SizedBox(height: 12),
                        const SectionTitle('Api'),
                        DefaultTextField(
                          controller: _apiCtrl,
                          focusNode: _apiFocus,
                          onChanged: (text) {
                            context.read<ConfigurationBloc>().add(
                              ApiNameChanged(
                                apiName: BlocFormItem(value: text),
                              ),
                            );
                          },
                          text: 'https://api.App.com',
                          icon: Icons.link_outlined,
                          validate: (_) => state.apiName.error,
                        ),

                        const SizedBox(height: 12),
                        const SectionTitle('Sonido'),
                        ToggleSwitch(
                          title: "Modo Beep on Scan",
                          subtitle: "Activa o desactiva",
                          initialValue: state.beedScanear.value,
                          onChanged: (val) {
                            context.read<ConfigurationBloc>().add(
                              BeedScanearChanged(
                                beedScanear: BlocFormItem<bool>(value: val),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 12),
                        const SectionTitle('Colores'),
                        ColorPickerField(
                          label: 'Color primario',
                          initialHex:
                              state.colorPrimary.value ??
                              AppConfig.sampleConfig.primary,
                          onColorPicked: (hex) {
                            context.read<ConfigurationBloc>().add(
                              ColorPrimaryChanged(
                                colorPrimary: BlocFormItem<String>(value: hex),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 12),
                        ColorPickerField(
                          label: 'Color secundario',
                          initialHex:
                              state.colorSecundary.value ??
                              AppConfig.sampleConfig.accent,
                          onColorPicked: (hex) {
                            context.read<ConfigurationBloc>().add(
                              ColorSecundaryChanged(
                                colorSecundary: BlocFormItem<String>(
                                  value: hex,
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 12),
                        const SectionTitle('Logo'),
                        DefaultTextField(
                          controller: _logoCtrl,
                          focusNode: _logoFocus,
                          onChanged: (text) {
                            context.read<ConfigurationBloc>().add(
                              LogoChanged(logo: BlocFormItem(value: text)),
                            );
                          },
                          text: 'link del logo',
                          icon: Icons.image_outlined,
                          validate: (_) => state.logo.error,
                        ),

                        const SizedBox(height: 24),

                        DefaultButton(
                          label: "Guardar",
                          icon: Icons.save_alt,
                          backgroundHex:
                              state.colorPrimary.value ??
                              AppConfig.sampleConfig.primary, // Verde
                          textHex:
                              state.colorSecundary.value ??
                              AppConfig.sampleConfig.accent, // Blanco
                          onPressed: () {
                                if (_formKey.currentState?.validate() ?? false) {                                    
                                  context.read<ConfigurationBloc>().add(FormSubmit(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            if (state.status == FormStatus.submitting)
              Container(
                color: Colors.black38,
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        );
      },
    );
  }

 

}
