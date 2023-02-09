import 'package:base_de_test/bootstrap.dart';
import 'package:base_de_test/flavors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

void main() async {
  F.appFlavor = Flavor.development;
  runApp(UncontrolledProviderScope(
      container: await bootstrap(), child: const MyApp()));
}
