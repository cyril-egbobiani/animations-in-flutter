import 'package:flutter/material.dart';

import '../widgets/principle_notes_card.dart';

class SolidDrawingScreen extends StatefulWidget {
  const SolidDrawingScreen({super.key});

  @override
  State<SolidDrawingScreen> createState() => _SolidDrawingScreenState();
}

class _SolidDrawingScreenState extends State<SolidDrawingScreen> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Solid Drawing (UI Consistency)')),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const PrincipleNotesCard(
              title: 'Solid Drawing (UI Consistency)',
              observe: 'Scale, elevation, and opacity shift while structure stays readable.',
              apply: 'Cards, profile modules, and expandable panels.',
              avoid: 'Animating layout in ways that scramble hierarchy.',
            ),
            const SizedBox(height: 18),
            AnimatedContainer(
              duration: const Duration(milliseconds: 420),
              curve: Curves.easeInOutCubic,
              width: double.infinity,
              height: _expanded ? 220 : 130,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: _expanded ? 24 : 10,
                    offset: Offset(0, _expanded ? 14 : 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 420),
                        width: _expanded ? 56 : 44,
                        height: _expanded ? 56 : 44,
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade100,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.person, color: Colors.indigo),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'User Profile',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 260),
                    opacity: _expanded ? 1 : 0.65,
                    child: const Text(
                      'Information scales smoothly without breaking layout rhythm.',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => setState(() => _expanded = !_expanded),
        icon: const Icon(Icons.flip),
        label: const Text('Toggle State'),
      ),
    );
  }
}
