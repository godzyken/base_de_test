import 'package:base_de_test/config/providers.dart' as providers;
import 'package:base_de_test/flavors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<ProviderContainer> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer(
    overrides: [
      // supabaseProvider.overrideWith((ref) => Supabase.instance),
    ],
    observers: [if (F.appFlavor == Flavor.local) _Logger()],
  );

  await providers.initializeProvider(container);
  return container;
}

class _Logger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase<dynamic> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    debugPrint('''{
      "provider": "${provider.name ?? provider.runtimeType}",
      "newValue": "$newValue",
      }''');
  }
}
