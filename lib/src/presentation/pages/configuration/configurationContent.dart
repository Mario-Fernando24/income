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
class ConfigurationContent extends StatelessWidget {
  ConfigurationState? state;

  ConfigurationContent(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Tickets'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: state!.formkey,
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
                DefaultTextField(
                  onChanged:
                      (text) => {
                        context.read<ConfigurationBloc>().add(
                          NameChanged(name: BlocFormItem(value: text)),
                        ),
                      },
                  text: 'Nombre de la app',
                  icon: Icons.apps_outlined,
                  validate: (value) {
                    return context.read<ConfigurationBloc>().state.name.error;
                  },
                ),

                const SizedBox(height: 12),
                const SectionTitle('Api'),
                DefaultTextField(
                  onChanged:
                      (text) => {
                        context.read<ConfigurationBloc>().add(
                          ApiNameChanged(apiName: BlocFormItem(value: text)),
                        ),
                      },
                  text: 'https://api.App.com',
                  icon: Icons.link_outlined,
                  validate: (value) {
                    return context
                        .read<ConfigurationBloc>()
                        .state
                        .apiName
                        .error;
                  },
                ),

                const SizedBox(height: 12),
                const SectionTitle('Sonido'),
                ToggleSwitch(
                  title: "Modo Beep on Scan",
                  subtitle: "Activa o desactiva",
                  initialValue: state!.beedScanear.value,
                  onChanged: (val) {
                  
                    context.read<ConfigurationBloc>().add(
                              BeedScanearChanged(beedScanear: BlocFormItem<bool>(value: val)),
                            );
                  },
                ),

                // --- NUEVO: Colores ---
                const SizedBox(height: 12),
                const SectionTitle('Colores'),
                ColorPickerField(
                  label: 'Color primario',
                  initialHex: state?.colorPrimary.value ?? AppConfig.sampleConfig.primary,
                  onColorPicked: (hex) {
                    print("PRIMARYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY");
                    print(hex);
                    print("PRIMARYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY");
                    context.read<ConfigurationBloc>().add(
                      ColorPrimaryChanged(colorPrimary: BlocFormItem<String>(value: hex.toString()))

                     
                      
                    );
                  },
                ),

                const SizedBox(height: 12),
                ColorPickerField(
                  label: 'Color secundario',
                  initialHex: state?.colorSecundary.value ?? AppConfig.sampleConfig.accent,
                  onColorPicked: (hex) {
                    print("SECUNDARYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY");
                    print(hex);
                    print("SECUNDARYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY");
                     context.read<ConfigurationBloc>().add(
                      ColorSecundaryChanged(colorSecundary: BlocFormItem<String>(value: hex))
                    );
                  },
                ),


                const SizedBox(height: 12),
                const SectionTitle('Logo'),
                DefaultTextField(
                  onChanged:
                      (text) => {
                        context.read<ConfigurationBloc>().add(
                          LogoChanged(logo: BlocFormItem(value: text)),
                        ),
                      },
                  text: 'link del logo',
                  icon: Icons.image_outlined,
                  validate: (value) {
                    return context.read<ConfigurationBloc>().state.logo.error;
                  },
                ),

                const SizedBox(height: 24),
                AppButton(
                  label: "Guardar",
                  icon: Icons.save,
                  type: AppButtonType.primary,
                  onPressed:
                      () => {
                        if (state!.formkey!.currentState!.validate())
                          {
                           
                            context.read<ConfigurationBloc>().add(FormSubmit()),
                          }else{
                            print( "mario fernando##########################################"),
                            print("El formulario no es valido"),
                            print("mario fernando##########################################"),
                          },
                      },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
