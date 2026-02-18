import 'package:flutter/material.dart';

import '../widgets/bouncy_button.dart';
import '../widgets/principle_notes_card.dart';
import 'add_to_cart_arc_screen.dart';
import 'appeal_screen.dart';
import 'anticipation_launch_screen.dart';
import 'exaggeration_screen.dart';
import 'follow_through_screen.dart';
import 'secondary_action_screen.dart';
import 'slow_in_out_screen.dart';
import 'solid_drawing_screen.dart';
import 'staging_focus_screen.dart';
import 'staggered_list_screen.dart';
import 'straight_ahead_pose_screen.dart';
import 'timing_comparison_screen.dart';

class DemoHomeScreen extends StatelessWidget {
  const DemoHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('12 Principles in Flutter')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Start with these practical demos:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Center(
            child: BouncyButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Squash + stretch + exaggeration')),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Text(
                  'Try Bouncy Button',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          const PrincipleNotesCard(
            title: 'Squash & Stretch',
            observe: 'Button compresses on press and rebounds on release.',
            apply: 'Tap feedback for primary actions and cards.',
            avoid: 'Very frequent list taps where subtle feedback is enough.',
          ),
          const SizedBox(height: 24),
          ListTile(
            leading: const Icon(Icons.view_agenda_outlined),
            title: const Text('Staggered List Demo'),
            subtitle: const Text('Overlapping action + slow in/out'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const StaggeredListScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart_checkout_outlined),
            title: const Text('Add to Cart Arc Demo'),
            subtitle: const Text('Arc motion + anticipation'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const AddToCartArcScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.center_focus_weak),
            title: const Text('Staging Demo'),
            subtitle: const Text('Direct attention with focus layering'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const StagingFocusScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.rocket_launch_outlined),
            title: const Text('Anticipation Demo'),
            subtitle: const Text('Pull back before forward motion'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const AnticipationLaunchScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.blur_on),
            title: const Text('Follow Through Demo'),
            subtitle: const Text('Main motion stops, secondary settles later'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const FollowThroughScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications_active_outlined),
            title: const Text('Secondary Action Demo'),
            subtitle: const Text('Badge animates after primary card motion'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const SecondaryActionScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.timer_outlined),
            title: const Text('Timing Comparison Demo'),
            subtitle: const Text('Compare 120ms, 300ms, and 700ms motion'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const TimingComparisonScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.route),
            title: const Text('Straight Ahead vs Pose-to-Pose'),
            subtitle: const Text('Sequential flow vs key-pose planning'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const StraightAheadPoseScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.speed),
            title: const Text('Slow In / Slow Out'),
            subtitle: const Text('Compare linear vs eased curves'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const SlowInOutScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.auto_graph),
            title: const Text('Exaggeration Demo'),
            subtitle: const Text('Subtle motion vs expressive overshoot'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const ExaggerationScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.layers_outlined),
            title: const Text('Solid Drawing Demo'),
            subtitle: const Text('Keep hierarchy and depth coherent'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const SolidDrawingScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: const Text('Appeal Demo'),
            subtitle: const Text('Polish with rhythm, hierarchy, and style'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const AppealScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
