import 'package:base_de_test/config/providers.dart' as providers;
import 'package:base_de_test/flavors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

Future<ProviderContainer> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SentryFlutter.init((options) {
    options.environment = 'dev';
    options.dsn =
        'https://2b84c201e9ef4d6abfb1b1e19f63f327@o573314.ingest.sentry.io/4504865137426432';
    options.autoAppStart = true;
    options.enableAutoPerformanceTracing = true;
    options.tracesSampleRate = 1.0;
    options.tracesSampler = (samplingContext) {
      return samplingContext
          .transactionContext.parentSamplingDecision?.sampleRate;
    };
  });

  final container = ProviderContainer(
    overrides: [
      // supabaseProvider.overrideWith((ref) => Supabase.instance),
      /*    AutoDisposeStreamProviderFamily((ref, arg) {
        final newState = ref.state;
        final newArg = arg;
        if (newState.hasError) {
          return const Stream.empty();
        } else if (newState.isLoading) {
          return
        }
  }))*/
    ],
    observers: [if (F.appFlavor == Flavor.local) _Logger()],
  );
  final transaction =
      Sentry.startTransaction('processOrderBatch()', 'task', bindToScope: true);
  try {
    await processOrderBatch(transaction);
  } catch (exception) {
    transaction.throwable = exception;
    transaction.status = const SpanStatus.internalError();
  } finally {
    await transaction.finish();
  }

  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;

    return stack;
  };

  try {
    StackFilter? stackFilter;
    FlutterError.addDefaultStackFilter(stackFilter!);
  } catch (exception, stack_Trace) {
    await Sentry.captureException(
      exception,
      stackTrace: stack_Trace,
    );
  } finally {
    transaction.finished;
  }

  await providers.initializeProvider(container);
  return container;
}

class _Logger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    debugPrint('''{
      "provider": "${provider.name ?? provider.runtimeType}",
      "previousValue": "$previousValue",
      "newValue": "$newValue",
      }''');
  }

  @override
  void didAddProvider(ProviderBase<Object?> provider, Object? value,
      ProviderContainer container) {
    debugPrint('''{
      "provider": "${provider.name ?? provider.runtimeType}",
      "value": "$value",
      "container": "$container",
      }''');
  }

  @override
  void didDisposeProvider(
      ProviderBase<Object?> provider, ProviderContainer container) {
    debugPrint('''{
      "provider": "${provider.name ?? provider.runtimeType}",
      "container": "$container",
      }''');
  }
}

Future<void> processOrderBatch(ISentrySpan span) async {
  // span operation: task, span description: operation
  final innerSpan = span.startChild('task', description: 'operation');

  try {
    // omitted code
    innerSpan.startChild('_Logger()');
    innerSpan.setMeasurement('memoryUsed', 123,
        unit: SentryMeasurementUnit.none);
    innerSpan.setMeasurement('ui.footerComponent.render', 1.3,
        unit: SentryMeasurementUnit.none);
    innerSpan.setMeasurement('localStorageRead', 4);
  } catch (exception) {
    innerSpan.throwable = exception;
    innerSpan.status = const SpanStatus.notFound();
  } finally {
    await innerSpan.finish();
  }
}
