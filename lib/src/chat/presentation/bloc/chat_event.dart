part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class GetChatMessageStreamEvent extends ChatEvent {
  final String messageRef;

  const GetChatMessageStreamEvent({required this.messageRef});

  @override
  List<Object> get props => [messageRef];
}

class SendChatMessageEvent extends ChatEvent {
  final String messageText;

  const SendChatMessageEvent({required this.messageText});

  @override
  List<Object> get props => [messageText];
}

class ResetChatEvent extends ChatEvent {
  const ResetChatEvent();
}
