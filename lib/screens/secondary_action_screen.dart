import 'package:flutter/material.dart';

import '../widgets/principle_notes_card.dart';

class SecondaryActionScreen extends StatefulWidget {
  const SecondaryActionScreen({super.key});

  @override
  State<SecondaryActionScreen> createState() => _SecondaryActionScreenState();
}

class _SecondaryActionScreenState extends State<SecondaryActionScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _cardSlide;
  late final Animation<double> _badgePop;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _cardSlide = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _badgePop = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.55, 1.0, curve: Curves.elasticOut),
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
      appBar: AppBar(title: const Text('Secondary Action Demo')),
      body: Column(
        children: [
          const PrincipleNotesCard(
            title: 'Secondary Action',
            observe: 'Main card enters first, then the badge animates as a supporting cue.',
            apply: 'Unread counters, status indicators, and subtle reinforcement.',
            avoid: 'Secondary effect competes with the main task.',
          ),
          Expanded(
            child: Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final slideX = Tween<double>(begin: -60, end: 0).transform(_cardSlide.value);
                  final badgeScale = Tween<double>(begin: 0, end: 1).transform(_badgePop.value);

                  return Transform.translate(
                    offset: Offset(slideX, 0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Card(
                          elevation: 6,
                          child: SizedBox(
                            width: 280,
                            child: ListTile(
                              leading: const Icon(Icons.mail_outline),
                              title: const Text('Inbox'),
                              subtitle: const Text('Main action arrives first'),
                              onTap: () {},
                            ),
                          ),
                        ),
                        Positioned(
                          right: 12,
                          top: -8,
                          child: Transform.scale(
                            scale: badgeScale,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                '3',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _controller.forward(from: 0),
        icon: const Icon(Icons.play_arrow),
        label: const Text('Replay'),
      ),
    );
  }
}
