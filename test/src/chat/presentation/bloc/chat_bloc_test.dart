import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:palm_ai_demo/core/core.dart';
import 'package:palm_ai_demo/src/chat/domain/domain.dart';
import 'package:palm_ai_demo/src/chat/presentation/presentation.dart';

class MockGetMessageStream extends Mock implements GetMessageStream {}

class MockSendMessage extends Mock implements SendMessage {}

void main() {
  late ChatBloc bloc;
  late SendMessage sendMessage;
  late GetMessageStream getMessageStream;

  setUp(() {
    sendMessage = MockSendMessage();
    getMessageStream = MockGetMessageStream();

    bloc = ChatBloc(
      getMessageStream: getMessageStream,
      sendMessage: sendMessage,
    );
  });

  tearDown(() => bloc.close());

  final tServerFailure = ServerFailure.fromException(
    const ServerException.unknown(),
  );

  test('should be initialy in [ChatInitial] state', () async {
    // Assert
    expect(bloc.state.status, ChatStatus.initial);
  });

  const tParams = SendMessageParams.empty();
  const tResponse = '_empty.ref';
  const tMessage = Message.empty();

  const tInitialState = ChatState(
    messages: [],
    status: ChatStatus.initial,
    chatMessage: null,
    errorMessage: null,
  );
  final tSubmittingState = tInitialState.copyWith(
    messages: const [tMessage],
    status: ChatStatus.submiting,
    chatMessage: tMessage.text,
    errorMessage: null,
  );
  final tThinkingState = tSubmittingState.copyWith(
    status: ChatStatus.thinking,
  );
  final tProcessingState = tSubmittingState.copyWith(
    status: ChatStatus.processing,
  );

  final tErrorState = tSubmittingState.copyWith(
    status: ChatStatus.error,
    errorMessage: tServerFailure.errorMessage,
  );

  const tGetMessageParams = GetMessageStreamParams(messageRef: '_empty.ref');

  final tProcessingMessage = Message(
      text: tMessage.text, status: 'PROCESSING', type: MessageType.response);
  final tResponseMessage = Message(
      text: tMessage.text, status: tMessage.status, type: MessageType.response);
  final tCompletedState =
      tSubmittingState.copyWith(status: ChatStatus.completed, messages: [
    ...tSubmittingState.messages,
    tResponseMessage,
  ]);

  group('sendMessage', () {
    blocTest<ChatBloc, ChatState>(
      'should emits [ChatState.sumbitting, ChatState.thinking, ChatState.processing, ChatState.processed] when message is sent.',
      build: () {
        // Arrange
        when(
          () => sendMessage(tParams),
        ).thenAnswer((_) async => const Right(tResponse));

        when(
          () => getMessageStream(tGetMessageParams),
        ).thenAnswer(
          (_) => Right(Stream<Message>.fromIterable(
            [tProcessingMessage, tResponseMessage],
          )),
        );

        return bloc;
      },
      act: (bloc) => bloc.add(
        SendChatMessageEvent(messageText: tParams.messageText),
      ),
      expect: () => <ChatState>[
        tSubmittingState,
        tThinkingState,
        tProcessingState,
        tCompletedState
      ],
      // verify: (_) {
      //   verify(() => sendMessage(tParams)).called(1);
      //   verifyNoMoreInteractions(sendMessage);
      // },
    );

    blocTest<ChatBloc, ChatState>(
      'should emits [ChatState.sumbitting, ChatState.error] when is unsuccesful.',
      build: () {
        // Arrange
        when(
          () => sendMessage(tParams),
        ).thenAnswer((_) async => Left(tServerFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(
        SendChatMessageEvent(messageText: tParams.messageText),
      ),
      expect: () => <ChatState>[tSubmittingState, tErrorState],
      verify: (_) {
        verify(() => sendMessage(tParams)).called(1);
        verifyNoMoreInteractions(sendMessage);
      },
    );
  });

  group('clearChat', () {
    blocTest<ChatBloc, ChatState>(
      'should emits [ChatState.initial] when cleared.',
      build: () => bloc,
      act: (bloc) => bloc.add(
        const ResetChatEvent(),
      ),
      expect: () => <ChatState>[tInitialState],
      verify: (_) {
        verifyNoMoreInteractions(sendMessage);
        verifyNoMoreInteractions(getMessageStream);
      },
    );
  });
}
