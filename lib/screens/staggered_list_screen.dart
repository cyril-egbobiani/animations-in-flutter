import 'package:flutter/material.dart';

import '../widgets/principle_notes_card.dart';

class StaggeredListScreen extends StatefulWidget {
  const StaggeredListScreen({super.key});

  @override
  State<StaggeredListScreen> createState() => _StaggeredListScreenState();
}

class _StaggeredListScreenState extends State<StaggeredListScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Future<List<String>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _itemsFuture = _loadItems();
  }

  Future<List<String>> _loadItems() async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    return List<String>.generate(10, (index) => 'Lesson card ${index + 1}');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Staggered List Demo')),
      body: FutureBuilder<List<String>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final items = snapshot.data!;
          if (_controller.status == AnimationStatus.dismissed) {
            _controller.forward();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: items.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const PrincipleNotesCard(
                  title: 'Overlapping Action',
                  observe: 'Each row starts before the previous row fully finishes.',
                  apply: 'List entrances, onboarding steps, and feed hydration.',
                  avoid: 'Dense data tables where instant scan is more important than motion.',
                );
              }
              final itemIndex = index - 1;
              final start = (itemIndex * 0.07).clamp(0, 0.8).toDouble();
              final end = (start + 0.35).clamp(0, 1).toDouble();

              final curved = CurvedAnimation(
                parent: _controller,
                curve: Interval(start, end, curve: Curves.easeOutQuart),
              );

              return FadeTransition(
                opacity: curved,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.2),
                    end: Offset.zero,
                  ).animate(curved),
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      title: Text(items[itemIndex]),
                      subtitle: const Text('Overlapping action in sequence'),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
