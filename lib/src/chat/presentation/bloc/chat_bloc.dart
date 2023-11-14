import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palm_ai_demo/src/chat/domain/domain.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetMessageStream _getMessageStream;
  final SendMessage _sendMessage;

  ChatBloc({
    required GetMessageStream getMessageStream,
    required SendMessage sendMessage,
  })  : _getMessageStream = getMessageStream,
        _sendMessage = sendMessage,
        super(const ChatState()) {
    on<SendChatMessageEvent>(_sendChatMessage);
    on<ResetChatEvent>(_resetChat);
  }

  FutureOr<void> _sendChatMessage(
      SendChatMessageEvent event, Emitter<ChatState> emit) async {
    emit(
      state.copyWith(
        status: ChatStatus.submiting,
        chatMessage: event.messageText,
        messages: [
          ...state.messages,
          Message(
              type: MessageType.prompt,
              text: event.messageText,
              status: 'COMPLETED'),
        ],
      ),
    );

    final result =
        await _sendMessage(SendMessageParams(messageText: event.messageText));

    await result.fold(
      (failure) {
        emit(state.copyWith(
          errorMessage: failure.errorMessage,
          status: ChatStatus.error,
        ));
      },
      (messageRef) async {
        emit(state.copyWith(status: ChatStatus.thinking));

        final messageStreamResult = _getMessageStream(
          GetMessageStreamParams(messageRef: messageRef),
        );

        await messageStreamResult.fold(
          (failure) {
            emit(state.copyWith(errorMessage: failure.errorMessage));
          },
          (messageStream) async {
            await for (final message in messageStream) {
              if (message.status == 'COMPLETED' &&
                  message.type == MessageType.response) {
                emit(state.copyWith(
                  status: ChatStatus.completed,
                  messages: [...state.messages, message],
                ));
              } else if (message.status == 'PROCESSING') {
                emit(state.copyWith(status: ChatStatus.processing));
              } else if (message.status == 'ERRORED') {
                emit(state.copyWith(
                  errorMessage: 'Something went wrong',
                  status: ChatStatus.error,
                ));
              }
            }
          },
        );
      },
    );
  }

  FutureOr<void> _resetChat(ResetChatEvent event, Emitter<ChatState> emit) {
    emit(state.copyWith(
      status: ChatStatus.initial,
      messages: [],
      chatMessage: null,
      errorMessage: null,
    ));
  }
}
