import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:interview_mockup/business/business.dart';


class MockCardItemBloc extends MockBloc<CardItemEvent, int> implements CardItemBloc {}
abstract class CardItemEvent {}

class AddCardItemEvent extends CardItemEvent {}
class EditCardItemEvent extends CardItemEvent {}
class ListCardItem extends CardItemEvent {}
class RemoveCardItemEvent extends CardItemEvent {}

class CardItemBloc extends Bloc<CardItemEvent, int> {
  CardItemBloc() : super(0) {
    on<AddCardItemEvent>((event, emit) => emit(state));
    on<EditCardItemEvent>((event, emit) => emit(state+1));
    on<ListCardItem>((event, emit) => emit(state+2));
    on<RemoveCardItemEvent>((event, emit) => emit(state+3));
  }
}

class MockSplashScreenBloc extends MockBloc<SplashScreenEvent, int> implements SplashScreenBloc {}
abstract class SplashScreenEvent {}
class AuthenticateUser extends SplashScreenEvent {}

class SplashScreenBloc extends Bloc<SplashScreenEvent, int> {
  SplashScreenBloc() : super(0) {
    on<AuthenticateUser>((event, emit) => emit(state));
  }
}

void main() {
  //Mock Bloc
  group('CardItemBlocTest', () {
    group('whenListen', () {

      test("Let's mock the CardItemBloc's stream!", () {
        // Create Mock CounterBloc Instance
        final bloc = MockCardItemBloc();

        // Stub the listen with a fake Stream
        whenListen(bloc, Stream.fromIterable([0, 1, 2, 3]));

        // Expect that the CounterBloc instance emitted the stubbed Stream of
        // states
        expectLater(bloc.stream, emitsInOrder(<int>[0, 1, 2, 3]));
      });
    });

    test("Testing Get Access Token", () async {
      final result = await AccessTokenAPI.getAccessToken("token");
      expect(result, true);
    });

    blocTest<CardItemBloc, int>(
      'emits [] when nothing is added',
      build: () => CardItemBloc(),
      expect: () => const <int>[],
    );

    blocTest<CardItemBloc, int>(
      'emits [0] when AddCardItemEvent is fired',
      build: () => CardItemBloc(),
      act: (bloc) => bloc.add(AddCardItemEvent()),
      expect: () => const <int>[0],
    );

    blocTest<CardItemBloc, int>(
      'emits [1] when EditCardItemEvent is fired',
      build: () => CardItemBloc(),
      act: (bloc) => bloc.add(EditCardItemEvent()),
      expect: () => const <int>[1],
    );

    blocTest<CardItemBloc, int>(
      'emits [2] when ListCardItem is fired',
      build: () => CardItemBloc(),
      act: (bloc) => bloc.add(ListCardItem()),
      expect: () => const <int>[2],
    );

    blocTest<CardItemBloc, int>(
      'emits [3] when RemoveCardItemEvent is fired',
      build: () => CardItemBloc(),
      act: (bloc) => bloc.add(RemoveCardItemEvent()),
      expect: () => const <int>[3],
    );


    blocTest<SplashScreenBloc, int>(
      'emits [0] when AuthenticateUser is fired',
      build: () => SplashScreenBloc(),
      act: (bloc) => bloc.add(AuthenticateUser()),
      expect: () => const <int>[0],
    );


  });
}
