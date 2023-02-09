import 'package:base_de_test/features/counter_app/domain/data/adapter/safe_convert.dart';

class Environment {
  Environment(
      {required this.supabaseUrl,
      required this.supabaseAnonKey,
      String? supabaseAuthCallbackUrlHostname});

  final String supabaseUrl;
  final String supabaseAnonKey;
  String? supabaseAuthCallbackUrlHostname;

  factory Environment.fromJson(Map<String, dynamic> json) => Environment(
      supabaseUrl: asT<String>(json, 'url'),
      supabaseAnonKey: asT<String>(json, 'anon_key'),
      supabaseAuthCallbackUrlHostname: asT<String>(json, 'hostname'));
}
