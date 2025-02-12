// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'activity.dart';
// import 'provider.dart';

// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (context, ref, child) {
//         final AsyncValue<Activity> activity = ref.watch(activityProvider);

//         return Center(
//           child: switch (activity) {
//             AsyncData(:final value) => Text('Activity: ${value.activity}'),
//             AsyncError() => const Text('Oops, something unexpected happened'),
//             _ => const CircularProgressIndicator(),
//           },
//         );
//       },
//     );
//   }
// }
