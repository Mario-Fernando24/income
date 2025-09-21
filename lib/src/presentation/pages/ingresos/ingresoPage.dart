import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickets_ingresos/src/presentation/bloc/ingreso_bloc/IngresoBloc.dart';
import 'package:tickets_ingresos/src/presentation/bloc/ingreso_bloc/IngresoState.dart';
import 'package:tickets_ingresos/src/presentation/pages/ingresos/ingresoContent.dart';

class IngresoPage extends StatelessWidget {
  const IngresoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<IngresoBloc, IngresoState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        child: BlocBuilder<IngresoBloc, IngresoState>(
          builder: (context, state) {
            return Stack(
              children: [
                IngresoContent(state)
              ],
            );
          },
        ),
      ),
    );
  
  }
}
