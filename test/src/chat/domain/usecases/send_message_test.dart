import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:palm_ai_demo/src/chat/domain/domain.dart';

class MockMessageRepo extends Mock implements MessageRepository {}

void main() {
  late SendMessage usecase;
  late MessageRepository repository;

  setUp(() {
    repository = MockMessageRepo();
    usecase = SendMessage(repository);
  });

  const tParams = SendMessageParams.empty();
  const tResponse = '_empty.ref';

  test('should call the [MessageRepo.sendMessage]', () async {
    // Arrange

    // STUB the repo call
    when(
      () => repository.sendNewMessage(
        messageText: any(named: 'messageText'),
      ),
    ).thenAnswer(
      (_) async => const Right(tResponse),
    );

    // Act
    final result = await usecase(tParams);

    // Assert
    expect(result, equals(const Right<dynamic, MessageRef>(tResponse)));

    verify(
      () => repository.sendNewMessage(messageText: tParams.messageText),
    ).called(1);

    verifyNoMoreInteractions(repository);
  });
}
