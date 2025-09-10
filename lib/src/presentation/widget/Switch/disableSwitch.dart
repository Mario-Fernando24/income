import 'package:flutter/material.dart';

class DisabledSwitch extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool value;
  
  const DisabledSwitch({super.key, 
    required this.title,
    required this.value,
    this.subtitle,
  });
  @override
  Widget build(BuildContext context) {
    return SwitchListTile.adaptive(
      value: value,
      onChanged: null, // deshabilitado → sin lógica
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      contentPadding: EdgeInsets.zero,
    );
  }
}
