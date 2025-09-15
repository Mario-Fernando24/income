import 'package:flutter/material.dart';
import 'package:tickets_ingresos/src/config/app_theme.dart';

class ToggleSwitch extends StatefulWidget {
  final String title;
  final String? subtitle;
  final bool initialValue;
  final ValueChanged<bool>? onChanged; // 👉 Callback opcional

  const ToggleSwitch({
    super.key,
    required this.title,
    this.subtitle,
    this.initialValue = false,
    this.onChanged,
  });

  @override
  State<ToggleSwitch> createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    fontFamily: 'MontserratLight',
                  ),
                ),
                if (widget.subtitle != null)
                  Text(
                    widget.subtitle!,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      fontFamily: 'MontserratMedium',
                    ),
                  ),
              ],
            ),
          ),
          Switch.adaptive(
            value: _value,
            onChanged: (val) {
              setState(() {
                _value = val;
              });
              widget.onChanged?.call(val);
            },
          ),
        ],
      ),
    );
  }
}
