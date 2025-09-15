import 'dart:math' show max;
import 'package:flutter/material.dart';

class ColorPickerField extends StatefulWidget {
  final String label;
  final String initialHex; // "#RRGGBB"
  final ValueChanged<String> onColorPicked;

  const ColorPickerField({
    super.key,
    required this.label,
    required this.initialHex,
    required this.onColorPicked,
  });

  @override
  State<ColorPickerField> createState() => _ColorPickerFieldState();
}

class _ColorPickerFieldState extends State<ColorPickerField> {
  late Color _color;
  late String _hex;

  @override
  void initState() {
    super.initState();
    _hex = _sanitizeHex(widget.initialHex);
    _color = _hexToColor(_hex);
  }

  @override
  void didUpdateWidget(covariant ColorPickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialHex != widget.initialHex) {
      _hex = _sanitizeHex(widget.initialHex);
      _color = _hexToColor(_hex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () async {
        final picked = await showDialog<Color>(
          context: context,
          builder: (_) => _ColorGridDialog(initial: _color),
        );
        if (picked != null) {
          setState(() {
            _color = picked;
            _hex = _colorToHex(picked);
          });
          widget.onColorPicked(_hex);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Row(
          children: [
            _ColorSwatchBox(color: _color),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.label, style: textStyle),
                  const SizedBox(height: 2),
                  Text(_hex, style: textStyle?.copyWith(fontFamily: 'MontserratLight')),
                ],
              ),
            ),
            const Icon(Icons.color_lens_outlined),
          ],
        ),
      ),
    );
  }

  // Helpers
  String _sanitizeHex(String input) {
    final v = input.trim().toUpperCase();
    if (v.startsWith('#') && v.length == 7) return v;
    final onlyHex = v.replaceAll(RegExp('[^0-9A-F]'), '');
    return '#${onlyHex.padLeft(6, '0').substring(0, 6)}';
  }

  Color _hexToColor(String hex) {
    final cleaned = hex.replaceAll('#', '');
    final value = int.parse(cleaned, radix: 16);
    return Color(0xFF000000 | value); // opaco
  }

  String _colorToHex(Color color) {
    final r = color.red.toRadixString(16).padLeft(2, '0');
    final g = color.green.toRadixString(16).padLeft(2, '0');
    final b = color.blue.toRadixString(16).padLeft(2, '0');
    return '#${(r + g + b).toUpperCase()}';
  }
}

class _ColorSwatchBox extends StatelessWidget {
  final Color color;
  const _ColorSwatchBox({required this.color});

  @override
  Widget build(BuildContext context) {
    final borderColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white12
        : Colors.black12;
    return Container(
      width: 36,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor),
      ),
    );
  }
}

class _ColorGridDialog extends StatelessWidget {
  final Color initial;
  const _ColorGridDialog({required this.initial});

  @override
  Widget build(BuildContext context) {
    final palette = _materialPalette();
    return AlertDialog(
      title: const Text('Elige un color', style: TextStyle(fontFamily: 'MontserratMedium', fontSize: 14),),
      content: SizedBox(
        width: 360,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final c in palette)
              _PickDot(
                color: c,
                selected: _sameColor(c, initial),
                onTap: () => Navigator.of(context).pop(c),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).maybePop(),
          child: const Text('Cancelar', style: TextStyle(fontFamily: 'MontserratMedium', fontSize: 14),),
        ),
      ],
    );
  }

  bool _sameColor(Color a, Color b) =>
      a.red == b.red && a.green == b.green && a.blue == b.blue;

  List<Color> _materialPalette() {
    // Toma tonos 500 (o similares) de la paleta Material + algunos neutros.
    const materialSwatches = <MaterialColor>[
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.brown,
      Colors.blueGrey,
      Colors.grey,
    ];
    final list = <Color>[
      ...materialSwatches.map((m) => m.shade500),
      Colors.black,
      Colors.white,
    ];
    return list;
  }
}

class _PickDot extends StatelessWidget {
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const _PickDot({
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = selected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).dividerColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: max(2, selected ? 2.0 : 1.0)),
        ),
      ),
    );
  }
}
