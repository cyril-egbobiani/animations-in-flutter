import 'package:flutter/material.dart';

import '../widgets/principle_notes_card.dart';

class TimingComparisonScreen extends StatefulWidget {
  const TimingComparisonScreen({super.key});

  @override
  State<TimingComparisonScreen> createState() => _TimingComparisonScreenState();
}

class _TimingComparisonScreenState extends State<TimingComparisonScreen> {
  Duration _duration = const Duration(milliseconds: 120);
  bool _atEnd = false;

  void _setDuration(Duration value) {
    setState(() => _duration = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timing Demo')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PrincipleNotesCard(
              title: 'Timing',
              observe: 'Identical movement feels different at 120ms, 300ms, and 700ms.',
              apply: 'Fast for feedback, medium for transitions, slower for emphasis.',
              avoid: 'One fixed duration for every interaction.',
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('120ms'),
                  selected: _duration.inMilliseconds == 120,
                  onSelected: (_) => _setDuration(const Duration(milliseconds: 120)),
                ),
                ChoiceChip(
                  label: const Text('300ms'),
                  selected: _duration.inMilliseconds == 300,
                  onSelected: (_) => _setDuration(const Duration(milliseconds: 300)),
                ),
                ChoiceChip(
                  label: const Text('700ms'),
                  selected: _duration.inMilliseconds == 700,
                  onSelected: (_) => _setDuration(const Duration(milliseconds: 700)),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Same movement, different timing:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.indigo.withValues(alpha: 0.08),
              ),
              child: AnimatedAlign(
                duration: _duration,
                curve: Curves.easeInOutCubic,
                alignment: _atEnd ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 52,
                  height: 52,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: const BoxDecoration(
                    color: Colors.indigo,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Current duration: ${_duration.inMilliseconds}ms'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => setState(() => _atEnd = !_atEnd),
        icon: const Icon(Icons.compare_arrows),
        label: const Text('Play'),
      ),
    );
  }
}
