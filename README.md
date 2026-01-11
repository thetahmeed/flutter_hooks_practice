# Flutter Hooks Practice

A comprehensive Flutter project demonstrating the practical usage of Flutter Hooks - a powerful way to manage state and lifecycle in Flutter applications.

## Table of Contents

- [What is a Hook?](#what-is-a-hook)
- [Why We Need Hooks](#why-we-need-hooks)
- [How to Use Hooks in Flutter](#how-to-use-hooks-in-flutter)
- [Common Hooks](#common-hooks)
- [Examples in This Project](#examples-in-this-project)
- [Getting Started](#getting-started)
- [Resources](#resources)

---

## What is a Hook?

**Hooks** are special functions that let you "hook into" Flutter's state and lifecycle features from `HookWidget` (similar to `StatelessWidget`) without needing to write a `StatefulWidget`.

Hooks are inspired by React Hooks and provide a way to:
- Reuse stateful logic between widgets
- Manage state in a more functional and composable way
- Reduce boilerplate code
- Make code more readable and maintainable

### Key Characteristics:
- **Must be called inside a `HookWidget`'s build method**
- **Always start with "use" prefix** (e.g., `useState`, `useEffect`, `useAnimationController`)
- **Called in the same order every time** (don't call hooks conditionally)
- **Automatically handle disposal** (no need for manual cleanup in most cases)

---

## Why We Need Hooks

### Problems with Traditional StatefulWidget:

1. **Verbose Code**: StatefulWidget requires creating two classes (Widget and State)
2. **Manual Lifecycle Management**: Need to override `initState`, `dispose`, etc.
3. **Difficult to Share Logic**: Hard to extract and reuse stateful logic
4. **Memory Leaks**: Easy to forget disposing controllers, listeners, etc.
5. **Complex State Management**: Managing multiple pieces of state requires more boilerplate

### How Hooks Solve These Problems:

✅ **Less Boilerplate**: Write state logic in a single widget class  
✅ **Automatic Cleanup**: Hooks automatically dispose resources  
✅ **Reusable Logic**: Create custom hooks to share stateful logic  
✅ **Easier Testing**: Functional approach makes testing simpler  
✅ **Better Composition**: Combine multiple hooks easily  
✅ **Clearer Code**: Logic is co-located with where it's used  

### Example Comparison:

**Without Hooks (StatefulWidget):**
```dart
class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => setState(() => count++),
      child: Text('Count: $count'),
    );
  }
}
```

**With Hooks (HookWidget):**
```dart
class Counter extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final count = useState(0);
    return ElevatedButton(
      onPressed: () => count.value++,
      child: Text('Count: ${count.value}'),
    );
  }
}
```

---

## How to Use Hooks in Flutter

### Step 1: Add Dependency

Add `flutter_hooks` to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_hooks: ^0.20.0  # Use latest version
```

Then run:
```bash
flutter pub get
```

### Step 2: Import the Package

```dart
import 'package:flutter_hooks/flutter_hooks.dart';
```

### Step 3: Create a HookWidget

Replace `StatelessWidget` or `StatefulWidget` with `HookWidget`:

```dart
class MyWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // Use hooks here!
    return Container();
  }
}
```

### Step 4: Use Hooks

Call hook functions inside the `build` method:

```dart
class MyWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // useState hook
    final counter = useState(0);
    
    // useEffect hook
    useEffect(() {
      print('Widget mounted');
      return () => print('Widget disposed');
    }, []);
    
    return Text('Counter: ${counter.value}');
  }
}
```

### Important Rules:

1. **Only call hooks inside HookWidget's build method**
2. **Don't call hooks conditionally** (must be in the same order every time)
3. **Always call hooks at the top level** (not inside loops, conditions, or nested functions)

---

## Common Hooks

### 1. **useState**
Creates a local state that persists across rebuilds.

```dart
final count = useState(0);
count.value++;  // Triggers rebuild
```

**Use Cases:**
- Simple counters
- Toggle states
- Form inputs
- Any local widget state

---

### 2. **useEffect**
Runs side effects and manages lifecycle (like `initState` + `dispose`).

```dart
useEffect(() {
  // Runs on mount and when dependencies change
  print('Effect running');
  
  return () {
    // Cleanup function (like dispose)
    print('Cleaning up');
  };
}, [dependency]); // Re-run when dependency changes
```

**Use Cases:**
- API calls
- Subscriptions
- Timers
- Event listeners
- Animation initialization

**Dependency Array:**
- `[]` - Run once on mount, cleanup on unmount
- `[value]` - Run when `value` changes
- No array - Run on every rebuild (rarely used)

---

### 3. **useAnimationController**
Creates an `AnimationController` with automatic disposal.

```dart
final controller = useAnimationController(
  duration: Duration(seconds: 2),
);
```

**Benefits:**
- No need for `TickerProviderStateMixin`
- Automatic disposal
- Cleaner animation code

---

### 4. **useAnimation**
Subscribes to an animation and rebuilds on value changes.

```dart
final animation = useAnimation(
  Tween<double>(begin: 0, end: 1).animate(controller),
);
```

---

### 5. **useMemoized**
Caches expensive computations (like `useMemo` in React).

```dart
final expensiveValue = useMemoized(
  () => computeExpensiveValue(input),
  [input], // Recompute only when input changes
);
```

---

### 6. **useTextEditingController**
Creates a `TextEditingController` with automatic disposal.

```dart
final controller = useTextEditingController();
```

---

### 7. **useFuture**
Handles Future/async operations with loading states.

```dart
final snapshot = useFuture(fetchData());
if (snapshot.hasData) return Text(snapshot.data!);
if (snapshot.hasError) return Text('Error');
return CircularProgressIndicator();
```

---

### 8. **useStream**
Subscribes to a Stream with automatic cleanup.

```dart
final snapshot = useStream(myStream);
```

---

## Examples in This Project

This project demonstrates four practical examples:

### 1. **Counter (useState)**
Simple state management for incrementing a counter.

### 2. **Switch Toggle (useState)**
Boolean state for toggling a switch on/off.

### 3. **Countdown Timer (useState + useEffect)**
Periodic timer that counts down from 30 seconds, demonstrating side effects and cleanup.

### 4. **Animated Icon (useAnimationController + useAnimation + useEffect)**
Smooth scaling animation without needing TickerProvider or manual disposal.

Check [lib/home_page.dart](lib/home_page.dart) for detailed implementations with comments!

---

## Getting Started

### Prerequisites
- Flutter SDK installed
- Code editor (VS Code, Android Studio, etc.)

### Running the Project

1. Clone this repository:
```bash
git clone <your-repo-url>
cd flutter_hooks_practice
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

4. Explore the code in `lib/home_page.dart` to see hooks in action!

---

## Resources

### Official Documentation
- [Flutter Hooks Package](https://pub.dev/packages/flutter_hooks)
- [Flutter Documentation](https://docs.flutter.dev/)

### Learn More About Hooks
- [React Hooks Documentation](https://react.dev/reference/react) (Inspiration for Flutter Hooks)
- [Flutter Hooks GitHub](https://github.com/rrousselGit/flutter_hooks)

### Flutter Resources
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

---

## Best Practices

1. **Start Simple**: Begin with `useState` and `useEffect` before exploring advanced hooks
2. **Custom Hooks**: Create reusable hooks for shared logic across widgets
3. **Dependencies**: Always specify dependencies correctly in `useEffect` to avoid bugs
4. **Performance**: Use `useMemoized` for expensive computations
5. **Testing**: Hooks make testing easier - test logic separately from UI

---

## Contributing

Feel free to open issues or submit pull requests to improve this practice project!

---

## License

This project is open source and available under the MIT License.
