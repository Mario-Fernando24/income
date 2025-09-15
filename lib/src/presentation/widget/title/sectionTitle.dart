import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 6,left: 20),
    child: Text(
      text,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
        letterSpacing: 1.1,
        fontFamily: 'MontserratSemiBold',
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
  );
}