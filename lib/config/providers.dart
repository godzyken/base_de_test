import 'dart:convert';

import 'package:base_de_test/features/auth/auth_provider.dart';
import 'package:base_de_test/features/counter_app/infrastructure/entities/environment.dart';
import 'package:base_de_test/features/transactions/transaction_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../flavors.dart';

final databaseProvider = Provider((ref) => TransactionProvider.instance);

final sharedPreferencesProvider =
    FutureProvider((ref) => SharedPreferences.getInstance());

final supabaseProvider = FutureProvider<supabase.Supabase>((ref) async {
  final configFile = await rootBundle.loadString(F.envFileName);
  final env =
      Environment.fromJson(json.decode(configFile) as Map<String, dynamic>);

  return supabase.Supabase.initialize(
    url: env.supabaseUrl,
    anonKey: env.supabaseAnonKey,
    debug: kDebugMode,
  );
});

final supabaseClientProvider = Provider<supabase.SupabaseClient>(
    (ref) => ref.read(supabaseProvider).asData!.value.client);

Future<void> initializeProvider(ProviderContainer container) async {
  await container.read(sharedPreferencesProvider.future);
  await container.read(supabaseProvider.future);

  container.read(authControllerProvider);
}
