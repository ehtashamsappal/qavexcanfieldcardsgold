import 'package:flutter/material.dart';
import 'package:qavexcanfieldcardsgold/core/app_state.dart';
import 'package:qavexcanfieldcardsgold/widgets/ui.dart';

class HowToScreen extends StatelessWidget {
  const HowToScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBuilder(
      builder: (context, s) => QxScaffold(
        title: 'How to Play',
        body: ListView(
          children: const [
            QxCard(
              child: Text('HOW TO PLAY\n\nGoal: build all four foundations from the dealt base card upward in suit, wrapping from King to Ace.\n\n- One random base card opens the first foundation; the other three foundations start on the same rank when it appears.\n- Build the four columns downward in alternating colors.\n- The 13-card reserve feeds the tableau one top card at a time.\n- Empty columns refill from the reserve first, then from the waste.\n- The stock draws three at a time with unlimited redeals.\n- Only a King (or a stack led by a King) may otherwise fill an empty column.\n\nMODES\n- Classic: the pure salon, no timer.\n- Timed Run: 10 minutes; leftover time becomes bonus points.\n- Daily Challenge: one seeded table per day; streaks earn bonus Reserve Coins.\n- Zen Table: no timer, free hints and undo.\n- Puzzle Levels: 24 curated salons with par scores; clear one to unlock the next.\n- Kids Mode: extra hints and friendly guidance.\n- Practice: free play with auto-hints.',
                  style: TextStyle(fontSize: 15, height: 1.5)),
            ),
          ],
        ),
      ),
    );
  }
}
