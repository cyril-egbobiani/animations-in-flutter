import 'package:flutter/material.dart';

import '../widgets/principle_notes_card.dart';

class StraightAheadPoseScreen extends StatefulWidget {
  const StraightAheadPoseScreen({super.key});

  @override
  State<StraightAheadPoseScreen> createState() => _StraightAheadPoseScreenState();
}

class _StraightAheadPoseScreenState extends State<StraightAheadPoseScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _forward = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _playStraightAhead() async {
    if (_forward) {
      await _controller.forward(from: 0);
    } else {
      await _controller.reverse(from: 1);
    }
    _forward = !_forward;
  }

  Future<void> _playPoseToPose() async {
    if (_forward) {
      await _controller.animateTo(0.35, duration: const Duration(milliseconds: 260), curve: Curves.easeOut);
      await _controller.animateTo(0.8, duration: const Duration(milliseconds: 220), curve: Curves.easeInOut);
      await _controller.animateTo(1, duration: const Duration(milliseconds: 200), curve: Curves.easeOutBack);
    } else {
      await _controller.animateTo(0.65, duration: const Duration(milliseconds: 260), curve: Curves.easeOut);
      await _controller.animateTo(0.2, duration: const Duration(milliseconds: 220), curve: Curves.easeInOut);
      await _controller.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.easeOutBack);
    }
    _forward = !_forward;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Straight Ahead vs Pose-to-Pose')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const PrincipleNotesCard(
              title: 'Straight Ahead / Pose-to-Pose',
              observe: 'Continuous motion versus key-pose checkpoints with controlled beats.',
              apply: 'Use straight ahead for organic motion, pose-to-pose for precise UX pacing.',
              avoid: 'Mixing both styles without intent in one microinteraction.',
            ),
            const SizedBox(height: 16),
            Expanded(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final x = Tween<double>(begin: -130, end: 130).transform(_controller.value);
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 320,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.indigo.withValues(alpha: 0.08),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(x, 0),
                        child: const Icon(Icons.airplanemode_active, size: 38, color: Colors.indigo),
                      ),
                    ],
                  );
                },
              ),
            ),
            Wrap(
              spacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: _playStraightAhead,
                  icon: const Icon(Icons.timeline),
                  label: const Text('Straight Ahead'),
                ),
                OutlinedButton.icon(
                  onPressed: _playPoseToPose,
                  icon: const Icon(Icons.alt_route),
                  label: const Text('Pose-to-Pose'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
