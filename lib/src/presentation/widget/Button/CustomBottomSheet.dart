import 'package:flutter/material.dart';
import 'package:tickets_ingresos/src/config/app_theme.dart';

class CustomBottomSheet extends StatelessWidget {
  final String message;

  const CustomBottomSheet({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.35,
      maxChildSize: 0.4,
      minChildSize: 0.2,
      builder: (_, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 1,
              )
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 5,
                width: 50,
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const Icon(Icons.info_outline, size: 40, color: AppColors.textLightGrey),
              const SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontFamily: 'MontserratRegular'),
              ),
              const SizedBox(height: 20),
             
            ],
          ),
        );
      },
    );
  }
}
