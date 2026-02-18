import 'package:flutter/material.dart';

class PrincipleNotesCard extends StatelessWidget {
  const PrincipleNotesCard({
    super.key,
    required this.title,
    required this.observe,
    required this.apply,
    required this.avoid,
  });

  final String title;
  final String observe;
  final String apply;
  final String avoid;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title Notes',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text('Observe: $observe'),
            const SizedBox(height: 4),
            Text('Use in app: $apply'),
            const SizedBox(height: 4),
            Text('Avoid when: $avoid'),
          ],
        ),
      ),
    );
  }
}
