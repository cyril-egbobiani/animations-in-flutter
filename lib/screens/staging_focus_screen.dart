import 'package:flutter/material.dart';

import '../widgets/principle_notes_card.dart';

class StagingFocusScreen extends StatefulWidget {
  const StagingFocusScreen({super.key});

  @override
  State<StagingFocusScreen> createState() => _StagingFocusScreenState();
}

class _StagingFocusScreenState extends State<StagingFocusScreen> {
  bool _showFocusCard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Staging Demo')),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 11,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const PrincipleNotesCard(
                  title: 'Staging',
                  observe: 'Background is visible but de-emphasized while focus content is elevated.',
                  apply: 'Dialogs, confirm flows, and critical input moments.',
                  avoid: 'Small non-critical actions that can stay inline.',
                );
              }
              return Card(
                child: ListTile(
                  title: Text('Background item $index'),
                  subtitle: const Text('Context remains visible but de-emphasized'),
                ),
              );
            },
          ),
          IgnorePointer(
            ignoring: !_showFocusCard,
            child: AnimatedOpacity(
              opacity: _showFocusCard ? 1 : 0,
              duration: const Duration(milliseconds: 250),
              child: Container(color: Colors.black54),
            ),
          ),
          Center(
            child: AnimatedScale(
              scale: _showFocusCard ? 1 : 0.9,
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutCubic,
              child: AnimatedOpacity(
                opacity: _showFocusCard ? 1 : 0,
                duration: const Duration(milliseconds: 220),
                child: Card(
                  elevation: 16,
                  child: SizedBox(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Primary Action',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Staging guides attention to the most important element.',
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: FilledButton(
                              onPressed: () {
                                setState(() => _showFocusCard = false);
                              },
                              child: const Text('Close'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => setState(() => _showFocusCard = true),
        label: const Text('Show Focus'),
        icon: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}
