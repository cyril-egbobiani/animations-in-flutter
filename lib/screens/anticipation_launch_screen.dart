import 'package:flutter/material.dart';

import '../widgets/principle_notes_card.dart';

class AnticipationLaunchScreen extends StatefulWidget {
  const AnticipationLaunchScreen({super.key});

  @override
  State<AnticipationLaunchScreen> createState() =>
      _AnticipationLaunchScreenState();
}

class _AnticipationLaunchScreenState extends State<AnticipationLaunchScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _progress = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: -0.12)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 18,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -0.12, end: 1)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 82,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Anticipation Demo')),
      body: Column(
        children: [
          const PrincipleNotesCard(
            title: 'Anticipation',
            observe: 'The object briefly moves opposite to the final direction before launch.',
            apply: 'Signal intent before major motion like sending, flying, or expanding.',
            avoid: 'Microinteractions that must feel instant.',
          ),
          Expanded(
            child: Center(
              child: SizedBox(
                width: 320,
                height: 120,
                child: AnimatedBuilder(
                  animation: _progress,
                  child: const Icon(Icons.send, size: 30, color: Colors.indigo),
                  builder: (context, child) {
                    final t = _progress.value;
                    final x = t < 0 ? t * 120 : t * 260;
                    return Stack(
                      children: [
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.flag, size: 32, color: Colors.teal),
                        ),
                        Positioned(left: 20 + x, top: 44, child: child!),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _controller.forward(from: 0),
        label: const Text('Launch'),
        icon: const Icon(Icons.play_arrow),
      ),
    );
  }
}
