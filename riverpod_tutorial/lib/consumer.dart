import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'provider.dart';

///  アプリケーションのホームページ
class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<bool> result = ref.watch(resultProvider);

    return Center(
      /// ネットワークリクエストは非同期であり、失敗する可能性があるため、
      /// エラー状態とローディング状態の両方を処理する必要があります。
      /// これにはパターンマッチングを使用できます。
      /// または、`if (result.isLoading) { ... } else if (...)`を使用することもできます。
      child: switch (result) {
        AsyncData(:final value) => Text(
            'result: ${value ? 'Yes' : 'No'}',
          ),
        AsyncError() => const Text(
            'Oops, something unexpected happened',
          ),
        _ => const CircularProgressIndicator(),
      },
    );
  }
}
