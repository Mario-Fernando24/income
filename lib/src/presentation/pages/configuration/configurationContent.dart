import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickets_ingresos/src/config/sample_config.dart';
import 'package:tickets_ingresos/src/presentation/bloc/configuration_bloc/ConfigurationBloc.dart';
import 'package:tickets_ingresos/src/presentation/bloc/configuration_bloc/ConfigurationEvent.dart';
import 'package:tickets_ingresos/src/presentation/bloc/configuration_bloc/ConfigurationState.dart';
import 'package:tickets_ingresos/src/presentation/utils/blocFormItem.dart';
import 'package:tickets_ingresos/src/presentation/widget/Button/AppButton.dart';
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

  @override
  void initState() {
    super.initState();
    // Apenas se monta el widget, pedimos cargar la configuración
    context.read<ConfigurationBloc>().add(LoadConfiguration());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConfigurationBloc, ConfigurationState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, newState) {
        if (newState.status == FormStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✅ Configuración guardada con éxito!'),
            ),
          );
        }

        if (newState.status == FormStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '❌ ${newState.errorMessage ?? "Error al guardar configuración"}',
              ),
            ),
          );
        }
      },
      builder: (context, newState) {
        state = newState;
        return Stack(
          children: [
            Scaffold(
              appBar: const CustomAppBar(title: 'Tickets'),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: state.formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        HeaderPreview(
                          name: (state.name.value?.isNotEmpty ?? false)
                            ? state.name.value!
                            : AppConfig.sampleConfig.displayName,
                          primaryHex: state.colorPrimary.value ??
                              AppConfig.sampleConfig.primary,
                          accentHex: state.colorSecundary.value ??
                              AppConfig.sampleConfig.accent,
                        ),

                        const SizedBox(height: 16),
                        const SectionTitle('Organización'),
                        DefaultTextField(
                          initialValue: state.name.value,
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
                          initialValue: state.apiName.value,
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
                          initialHex: state.colorPrimary.value ??
                              AppConfig.sampleConfig.primary,
                          onColorPicked: (hex) {
                            context.read<ConfigurationBloc>().add(
                                  ColorPrimaryChanged(
                                    colorPrimary:
                                        BlocFormItem<String>(value: hex),
                                  ),
                                );
                          },
                        ),

                        const SizedBox(height: 12),
                        ColorPickerField(
                          label: 'Color secundario',
                          initialHex: state.colorSecundary.value ??
                              AppConfig.sampleConfig.accent,
                          onColorPicked: (hex) {
                            context.read<ConfigurationBloc>().add(
                                  ColorSecundaryChanged(
                                    colorSecundary:
                                        BlocFormItem<String>(value: hex),
                                  ),
                                );
                          },
                        ),

                        const SizedBox(height: 12),
                        const SectionTitle('Logo'),
                        DefaultTextField(
                          initialValue: state.logo.value,
                          onChanged: (text) {
                            context.read<ConfigurationBloc>().add(
                                  LogoChanged(
                                    logo: BlocFormItem(value: text),
                                  ),
                                );
                          },
                          text: 'link del logo',
                          icon: Icons.image_outlined,
                          validate: (_) => state.logo.error,
                        ),

                        const SizedBox(height: 24),
                        AppButton(
                          label: "Guardar",
                          icon: Icons.save,
                          type: AppButtonType.primary,
                          onPressed: () {
                            if (state.formkey!.currentState!.validate()) {
                              context
                                  .read<ConfigurationBloc>()
                                  .add(FormSubmit());
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
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        );
      },
    );
  }
}
