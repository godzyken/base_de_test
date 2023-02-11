import 'package:base_de_test/features/auth/auth_provider.dart';
import 'package:base_de_test/features/auth/infrastructure/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_controller_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthRepository>()])
void main() {
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
  });

  tearDown(() {
    resetMockitoState();
  });

  ProviderContainer makeProviderContainer(MockAuthRepository authRepository) {
    final container = ProviderContainer(overrides: [
      authRepositoryProvider.overrideWithValue(authRepository),
    ]);
    addTearDown(container.dispose);
    return container;
  }

  test('initialiser les données asynchrone', () {
    final authRepository = MockAuthRepository();

    final container = makeProviderContainer(authRepository);

    // when(authRepository.authClient.signUp(password: 'password'))
    //     .thenAnswer((value) async {
    //   return http.Response('{"password": "password"}', 200);
    // });

    final listener = Listener<AsyncValue<void>>();

    container.listen(authControllerProvider, (previous, next) => listener,
        fireImmediately: true);

    verify(
      () => listener(null, const AsyncData<void>(null)),
    );

    verifyNoMoreInteractions(listener);

    verifyNever(authRepository.signInWithGoogle());
  });

  test('sign-in success', () async {
    final authRepository = MockAuthRepository();

    when(authRepository.signInWithGoogle()).thenAnswer((_) => Future.value());

    final container = makeProviderContainer(authRepository);

    final listener = Listener<AsyncValue<void>>();

    container.listen(authControllerProvider, (previous, next) => listener,
        fireImmediately: true);

    const data = AsyncData<void>(null);

    verify(() => listener(null, data));

    final controller = container.read(authControllerProvider.notifier);
    // run
    await controller.signOut();
    // verify
    verifyInOrder([
      // transition from data to loading state
      () => listener(data, const AsyncLoading<void>()),
      // transition from loading state to data
      () => listener(const AsyncLoading<void>(), data),
    ]);
    verifyNoMoreInteractions(listener);
    verify(authRepository.signInWithGoogle()).called(1);
  });
}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}
