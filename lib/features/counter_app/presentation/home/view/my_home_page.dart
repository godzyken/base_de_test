import 'dart:developer';

import 'package:base_de_test/features/common/presentation/utils/extensions/ui_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  int _count = 0;
  static const _platform = MethodChannel('godzy.com/channel');

  @override
  void initState() {
    super.initState();
  }

  Future<void> _generateRandomNumber() async {
    int random;
    try {
      random = await _platform.invokeMethod('getRandomNumber');
    } on PlatformException catch (e) {
      log('error random cause by: ${e.message}');
      random = 0;
    }

    setState(() {
      _count = random;
    });
  }

  @override
  Widget build(BuildContext context) {
/*
    final authenticationState = ref.watch(authStateProvider);

    Widget getHome() {
      if (authenticationState.status == AuthStatus.authenticated) {
        return const ProfileScreen();
      } else if (authenticationState.status == AuthStatus.unauthenticated) {
        return const AuthScreen();
      } else {
        return const AuthScreen();
      }
    }
*/

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_count',
              style: context.textTheme.displaySmall,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _generateRandomNumber,
        tooltip: 'Random',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
