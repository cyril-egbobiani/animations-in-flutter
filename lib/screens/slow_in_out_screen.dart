import 'package:flutter/material.dart';

import '../widgets/principle_notes_card.dart';

class SlowInOutScreen extends StatefulWidget {
  const SlowInOutScreen({super.key});

  @override
  State<SlowInOutScreen> createState() => _SlowInOutScreenState();
}

class _SlowInOutScreenState extends State<SlowInOutScreen> {
  bool _move = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Slow In / Slow Out')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const PrincipleNotesCard(
              title: 'Slow In / Slow Out',
              observe: 'Eased curves accelerate and decelerate naturally near endpoints.',
              apply: 'Most enter/exit and transform transitions in product UI.',
              avoid: 'Mechanical linear motion for human-centered interactions.',
            ),
            _CurveRow(
              title: 'Linear',
              curve: Curves.linear,
              move: _move,
              color: Colors.grey.shade700,
            ),
            const SizedBox(height: 16),
            _CurveRow(
              title: 'EaseInOutCubic',
              curve: Curves.easeInOutCubic,
              move: _move,
              color: Colors.indigo,
            ),
            const SizedBox(height: 16),
            _CurveRow(
              title: 'EaseOutQuart',
              curve: Curves.easeOutQuart,
              move: _move,
              color: Colors.teal,
            ),
            const Spacer(),
            const Text('Compare entry/exit speed near the endpoints.'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => setState(() => _move = !_move),
        icon: const Icon(Icons.play_arrow),
        label: const Text('Play'),
      ),
    );
  }
}

class _CurveRow extends StatelessWidget {
  const _CurveRow({
    required this.title,
    required this.curve,
    required this.move,
    required this.color,
  });

  final String title;
  final Curve curve;
  final bool move;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Container(
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color.withValues(alpha: 0.08),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 1100),
            curve: curve,
            alignment: move ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 34,
              height: 34,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          ),
        ),
      ],
    );
  }
}
