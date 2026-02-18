import 'package:flutter/material.dart';

import '../widgets/principle_notes_card.dart';

class AddToCartArcScreen extends StatefulWidget {
  const AddToCartArcScreen({super.key});

  @override
  State<AddToCartArcScreen> createState() => _AddToCartArcScreenState();
}

class _AddToCartArcScreenState extends State<AddToCartArcScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey _cartKey = GlobalKey();
  final GlobalKey _buttonKey = GlobalKey();

  late final AnimationController _controller;
  late final Animation<double> _progress;

  OverlayEntry? _overlay;

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
        weight: 15,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -0.12, end: 1)
            .chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 85,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _overlay?.remove();
    _controller.dispose();
    super.dispose();
  }

  Offset _centerOf(GlobalKey key) {
    final box = key.currentContext!.findRenderObject()! as RenderBox;
    return box.localToGlobal(box.size.center(Offset.zero));
  }

  Future<void> _runAnimation() async {
    _overlay?.remove();

    final start = _centerOf(_buttonKey);
    final end = _centerOf(_cartKey);
    final direction = (start - end);
    final length = direction.distance == 0 ? 1.0 : direction.distance;
    final pullbackOffset = start + (direction / length) * 22;
    final arcTween = MaterialPointArcTween(begin: start, end: end);

    _overlay = OverlayEntry(
      builder: (context) {
        return IgnorePointer(
          child: AnimatedBuilder(
            animation: _progress,
            builder: (context, child) {
              final t = _progress.value;
              final position = t < 0
                  ? Offset.lerp(start, pullbackOffset, (-t / 0.12).clamp(0, 1))!
                  : arcTween.transform(t);

              return Stack(
                children: [
                  Positioned(
                    left: position.dx - 8,
                    top: position.dy - 8,
                    child: child!,
                  ),
                ],
              );
            },
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: Colors.deepOrange,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlay!);
    await _controller.forward(from: 0);
    _overlay?.remove();
    _overlay = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add to Cart Arc Demo'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.shopping_cart, key: _cartKey),
          ),
        ],
      ),
      body: Column(
        children: const [
          PrincipleNotesCard(
            title: 'Arcs + Anticipation',
            observe: 'The dot pulls back first, then follows a curved route to the cart.',
            apply: 'Use for object-to-target transitions like add-to-cart or drag confirmations.',
            avoid: 'The action is frequent and needs ultra-fast feedback.',
          ),
          Expanded(
            child: Center(
              child: Text(
                'Tap the button to launch an item into the cart.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton.icon(
        key: _buttonKey,
        onPressed: _runAnimation,
        icon: const Icon(Icons.add_shopping_cart),
        label: const Text('Add to cart'),
      ),
    );
  }
}
