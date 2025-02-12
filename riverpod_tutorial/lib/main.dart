import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'activity.dart';
import 'provider.dart';

part 'main.g.dart';

// We create a "provider", which will store a value (here "Hello world").
// By using a provider, this allows us to mock/override the value exposed.
@riverpod
String helloWorld(Ref ref) {
  return 'Hello world';
}

void main() {
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final AsyncValue<Activity> activity = ref.watch(activityProvider);

        print(activity);

        return Center(
          child: switch (activity) {
            AsyncData(:final value) => Text('Activity: ${value.activity}'),
            AsyncError() => const Text('Oops, something unexpected happened'),
            _ => const CircularProgressIndicator(),
          },
        );
      },
    );
  }
}

// Extend ConsumerWidget instead of StatelessWidget, which is exposed by Riverpod
// class MyApp extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final String value = ref.watch(helloWorldProvider);

//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Example')),
//         body: Center(
//           child: Text(value),
//         ),
//       ),
//     );
//   }
// }
