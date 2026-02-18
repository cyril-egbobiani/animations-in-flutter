import 'package:flutter/material.dart';

import '../widgets/principle_notes_card.dart';

class AppealScreen extends StatefulWidget {
  const AppealScreen({super.key});

  @override
  State<AppealScreen> createState() => _AppealScreenState();
}

class _AppealScreenState extends State<AppealScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _header;
  late final Animation<double> _card;
  late final Animation<double> _button;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 950),
    );
    _header = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOutCubic),
    );
    _card = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.18, 0.72, curve: Curves.easeOutCubic),
    );
    _button = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.5, 1.0, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _play() {
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appeal Demo')),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PrincipleNotesCard(
                  title: 'Appeal',
                  observe: 'Stagger, typography, and color work together as one visual story.',
                  apply: 'First impressions, onboarding, and hero sections.',
                  avoid: 'Inconsistent motion language across screens.',
                ),
                Opacity(
                  opacity: _header.value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - _header.value)),
                    child: const Text(
                      'Polished Motion',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Opacity(
                  opacity: _card.value,
                  child: Transform.translate(
                    offset: Offset(0, 26 * (1 - _card.value)),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF344CB7), Color(0xFF4A7CFF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Appeal = coherent style, strong timing, clear hierarchy.',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Center(
                  child: Transform.scale(
                    scale: _button.value,
                    child: FilledButton.icon(
                      onPressed: _play,
                      icon: const Icon(Icons.auto_fix_high),
                      label: const Text('Replay Entrance'),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _play,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
