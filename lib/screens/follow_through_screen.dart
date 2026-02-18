import 'package:flutter/material.dart';

import '../widgets/principle_notes_card.dart';

class FollowThroughScreen extends StatefulWidget {
  const FollowThroughScreen({super.key});

  @override
  State<FollowThroughScreen> createState() => _FollowThroughScreenState();
}

class _FollowThroughScreenState extends State<FollowThroughScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _main;
  late final Animation<double> _settle;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );
    _main = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _settle = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.55, 1.0, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Follow Through Demo')),
      body: Column(
        children: [
          const PrincipleNotesCard(
            title: 'Follow Through',
            observe: 'Primary icon stops first; ring settles after with delay.',
            apply: 'Sheet settles, badges, glow, or shadows trailing main motion.',
            avoid: 'You need hard-stop precision like financial tickers.',
          ),
          Expanded(
            child: Center(
              child: SizedBox(
                width: 320,
                height: 180,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final iconX =
                        Tween<double>(begin: -120, end: 0).transform(_main.value);
                    final ringScale =
                        Tween<double>(begin: 0.4, end: 1).transform(_settle.value);
                    final ringOpacity =
                        Tween<double>(begin: 0, end: 0.35).transform(_settle.value);

                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Opacity(
                          opacity: ringOpacity,
                          child: Transform.scale(
                            scale: ringScale,
                            child: Container(
                              width: 92,
                              height: 92,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.indigo, width: 3),
                              ),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(iconX, 0),
                          child: const Icon(
                            Icons.bolt,
                            size: 56,
                            color: Colors.indigo,
                          ),
                        ),
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
        icon: const Icon(Icons.motion_photos_on),
        label: const Text('Animate'),
      ),
    );
  }
}
