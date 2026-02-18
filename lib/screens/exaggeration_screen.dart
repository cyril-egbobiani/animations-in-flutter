import 'package:flutter/material.dart';

import '../widgets/principle_notes_card.dart';

class ExaggerationScreen extends StatefulWidget {
  const ExaggerationScreen({super.key});

  @override
  State<ExaggerationScreen> createState() => _ExaggerationScreenState();
}

class _ExaggerationScreenState extends State<ExaggerationScreen> {
  bool _show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exaggeration Demo')),
      body: Column(
        children: [
          const PrincipleNotesCard(
            title: 'Exaggeration',
            observe: 'Elastic overshoot makes emphasis stronger than subtle easing.',
            apply: 'Success states, rewards, and milestone confirmations.',
            avoid: 'High-frequency actions where playful bounce becomes noisy.',
          ),
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _PopupCard(
                    title: 'Subtle',
                    curve: Curves.easeOutCubic,
                    show: _show,
                    color: Colors.blueGrey,
                  ),
                  const SizedBox(width: 18),
                  _PopupCard(
                    title: 'Exaggerated',
                    curve: Curves.elasticOut,
                    show: _show,
                    color: Colors.deepOrange,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => setState(() => _show = !_show),
        icon: const Icon(Icons.auto_awesome),
        label: const Text('Toggle'),
      ),
    );
  }
}

class _PopupCard extends StatelessWidget {
  const _PopupCard({
    required this.title,
    required this.curve,
    required this.show,
    required this.color,
  });

  final String title;
  final Curve curve;
  final bool show;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        AnimatedScale(
          duration: const Duration(milliseconds: 550),
          curve: curve,
          scale: show ? 1 : 0.2,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 260),
            opacity: show ? 1 : 0,
            child: Container(
              width: 130,
              height: 100,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
