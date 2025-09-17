import 'package:flutter/material.dart';
import 'package:tickets_ingresos/src/config/app_routes.dart';
import 'package:tickets_ingresos/src/config/app_theme.dart';
import 'package:tickets_ingresos/src/domain/models/request/configurate_request.dart';
import 'package:tickets_ingresos/src/presentation/utils/functions/getData.dart';
import 'package:tickets_ingresos/src/presentation/widget/Button/DefaultButton.dart';
import 'package:tickets_ingresos/src/presentation/widget/TextField/DefaultText.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

    final dataApp = DataApp(); // Instanciamos la clase
  ConfigurateRequest? config;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loanding();
  }

  void loanding()async{
     config = await dataApp.getConfiguratePreference();
     setState(() {
       
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/onbordingnnnn.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultText(
                      text: '¡Bienvenido a ${config!.name.toString()}!',
                      textAlign: TextAlign.center,
                      fontSize: 24,
                      color: AppColors.textPrimary, // O usa config.colorPrimary convertido a Color
                    ),
            
                    const SizedBox(height: 16),

                   const DefaultText(
                      text: 'Administra tus tickets de manera rápida y sencilla.',
                      textAlign: TextAlign.center,
                      fontSize: 16,
                      fontFamily: 'MontserratRegular',
                      color: AppColors.textLightGrey, 
                    ),
                   
                    const SizedBox(height: 32),

                   DefaultButton(
                      label: "Scannear",
                      icon: Icons.qr_code_scanner,
                      backgroundHex: config!.colorPrimary.toString(), 
                      textHex:config!.colorSecondary.toString(),       
                      onPressed: () {
                        if(config!.apiName.isNotEmpty){
                            Navigator.pushNamed(context, AppRoutes.ingreso);
                        }else{
                          print("debes irte a la configuracion");
                        }
                      },
                    ),

                    SizedBox(height: 10),
                    DefaultButton(
                      label: "Configuración",
                      icon: Icons.settings,
                      backgroundHex: config!.colorPrimary.toString(), 
                      textHex:config!.colorSecondary.toString(),       
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.configurations);
                      },
                    ),
                    
                    

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
