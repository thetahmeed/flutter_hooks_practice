import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// HomePage is a HookWidget that demonstrates practical usage of Flutter hooks.
///
/// HookWidget is similar to StatelessWidget but allows the use of hooks.
/// Hooks let you use state and other Flutter features without writing a StatefulWidget.
class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // ========== EXAMPLE 01: useState Hook ==========
    // useState creates a piece of local state that persists across rebuilds.
    // Similar to State's member variables, but more concise.
    // Returns a ValueNotifier that automatically triggers rebuild when changed.
    final count = useState(0);

    // ========== EXAMPLE 02: useState for Boolean State ==========
    // Another example of useState for managing a boolean toggle state.
    // Perfect for switches, checkboxes, or any on/off state.
    final isSwitchedOn = useState(false);

    // ========== EXAMPLE 03: useEffect Hook with Timer ==========
    // useState for countdown timer
    final timeLeft = useState(30);

    // useEffect runs side effects and manages lifecycle.
    // Similar to initState, didUpdateDependencies, and dispose combined.
    // The empty array [] means this effect runs only once (like initState).
    useEffect(
      () {
        // Create a periodic timer that ticks every second
        final timer = Timer.periodic(Duration(seconds: 1), (t) {
          if (timeLeft.value > 0) {
            timeLeft.value--; // Decrement the timer
          }
        });

        // Return a cleanup function (like dispose in StatefulWidget)
        // This will be called when the widget is disposed or dependencies change
        return timer.cancel;
      },
      [],
    ); // Empty dependency array = run once on mount, cleanup on unmount // Empty dependency array = run once on mount, cleanup on unmount

    // ========== EXAMPLE 04: useAnimationController and useAnimation ==========
    // useAnimationController creates an AnimationController without needing
    // a TickerProvider or manual disposal. The controller is automatically
    // disposed when the widget is removed from the tree.
    final controller = useAnimationController(
      duration: const Duration(seconds: 1),
    );

    // Start the animation only once when the widget is first built.
    // Without this effect, the animation would restart on every rebuild.
    useEffect(() {
      controller.repeat(
        reverse: true,
      ); // Start repeating animation with reverse
      return null; // No specific cleanup needed (controller auto-disposed)
    }, []); // Empty array ensures this runs only once

    // useAnimation subscribes to an Animation and rebuilds when it changes.
    // This creates a smooth scaling animation from 1.0 to 1.5 and back.
    final animation = useAnimation(
      Tween<double>(begin: 1.0, end: 1.5).animate(controller),
    );

    // Bonus: TextEditingController with useTextEditingController
    final myController = useTextEditingController(text: "Flutter Hooks");
    useListenable(myController);
    // What is useListenable(myController)?
    // By default, when you type in a text box, the "Smart Pen" knows
    // the text changed, but it doesn't tell the screen to "Re-draw."
    // Adding useListenable(myController) tells the Hook: "Hey, every
    // time a letter is typed, refresh this widget so I can show the
    // text on the screen immediately!"

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Flutter Hooks Practice',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          // ========== EXAMPLE 01 UI: Counter ==========
          // Display the counter value from useState
          Text('Count: ${count.value}'),
          ElevatedButton(
            onPressed: () {
              // Incrementing the value automatically triggers a rebuild
              count.value++;
            },
            child: const Text('Increment'),
          ),

          // ========== EXAMPLE 02 UI: Switch Toggle ==========
          // Switch widget bound to the useState boolean
          Switch(
            value: isSwitchedOn.value,
            onChanged: (value) => isSwitchedOn.value = value,
          ),

          // ========== EXAMPLE 03 UI: Countdown Timer ==========
          // Display the countdown timer value
          Text('Time left: ${timeLeft.value} seconds'),

          // ========== EXAMPLE 04 UI: Animated Icon ==========
          // Icon that scales smoothly using the animation value
          Transform.scale(
            scale: animation, // animation value changes smoothly over time
            child: Icon(Icons.favorite, color: Colors.pink, size: 50),
          ),

          // ========== BONUS UI: TextField with Controller ==========
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: myController,
              decoration: InputDecoration(
                labelText: "Type something here...",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          // This shows what you typed in real-time!
          Text(
            "You are typing: ${myController.text}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
