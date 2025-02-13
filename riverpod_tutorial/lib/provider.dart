import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider.g.dart';

@riverpod
Future<bool> result(Ref ref) async {
  print("⭐️");
  final url = Uri.parse(
      'https://umayadia-apisample.azurewebsites.net/api/persons/Shakespeare');
  final response = await http.get(url);

  print("⭐️⭐️");
  final json = jsonDecode(response.body);
  final success = json['success'] as bool;
  // 最終的にMapをActivityインスタンスに変換します。
  return success;
}
