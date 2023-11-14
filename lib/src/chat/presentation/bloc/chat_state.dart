part of 'chat_bloc.dart';

enum ChatStatus { initial, submiting, thinking, processing, completed, error }

class ChatState extends Equatable {
  const ChatState({
    this.messages = const [],
    this.status = ChatStatus.initial,
    this.chatMessage,
    this.errorMessage,
  });

  final ChatStatus status;
  final List<Message> messages;
  final String? chatMessage;
  final String? errorMessage;

  ChatState copyWith({
    ChatStatus? status,
    List<Message>? messages,
    String? chatMessage,
    String? errorMessage,
  }) =>
      ChatState(
        chatMessage: chatMessage,
        messages: messages ?? this.messages,
        status: status ?? this.status,
        errorMessage: errorMessage,
      );

  @override
  List<Object?> get props => [messages, status, chatMessage, errorMessage];
}
