import 'package:base_de_test/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bootstrap.dart';
import 'flavors.dart';

void main() async {
  F.appFlavor = Flavor.production;
  runApp(
    UncontrolledProviderScope(
      container: await bootstrap(),
      child: const MyApp(),
    ),
  );
}
