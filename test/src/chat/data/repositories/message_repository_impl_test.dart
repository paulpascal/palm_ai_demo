import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:palm_ai_demo/core/errors/errors.dart';
import 'package:palm_ai_demo/src/chat/data/data.dart';
import 'package:palm_ai_demo/src/chat/domain/domain.dart';

class MockMessageRemoteDatasource extends Mock
    implements MessageRemoteDatasource {}

void main() {
  late MessageRemoteDatasource remoteDatasource;
  late MessageRepositoryImpl repositoryImpl;

  setUp(() {
    remoteDatasource = MockMessageRemoteDatasource();
    repositoryImpl = MessageRepositoryImpl(remoteDatasource);
  });

  const tParams = SendMessageParams.empty();
  const tException = ServerException.unknown();
  const tResponse = '_empty.ref';

  group('sendMessage', () {
    test(
        'should call [RemoteDatasource.sendMessage] and complete successfully when the call to the remote source is successful',
        () async {
      // Arrange
      when(
        () => remoteDatasource.sendMessage(
          messageText: any(named: 'messageText'),
        ),
      ).thenAnswer((_) async => tResponse);

      // Act
      final result =
          await repositoryImpl.sendNewMessage(messageText: tParams.messageText);

      // Assert
      expect(result, equals(const Right<dynamic, MessageRef>(tResponse)));
      verify(
        () => remoteDatasource.sendMessage(messageText: tParams.messageText),
      ).called(1);
      verifyNoMoreInteractions(remoteDatasource);
    });

    test(
        'should call [RemoteDatasource.sendMessage] and return [ServerFailure] when the call to the remote source is unsuccessful',
        () async {
      // Arrange
      when(
        () => remoteDatasource.sendMessage(
          messageText: any(named: 'messageText'),
        ),
      ).thenThrow(const ServerException.unknown());

      // Act
      final result =
          await repositoryImpl.sendNewMessage(messageText: tParams.messageText);

      // Assert
      expect(
        result,
        equals(
          Left<Failure, dynamic>(ServerFailure.fromException(tException)),
        ),
      );
      verify(
        () => remoteDatasource.sendMessage(messageText: tParams.messageText),
      ).called(1);
      verifyNoMoreInteractions(remoteDatasource);
    });
  });
}
