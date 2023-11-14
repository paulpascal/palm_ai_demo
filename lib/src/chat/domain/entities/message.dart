import 'package:equatable/equatable.dart';

enum MessageType { prompt, response }

typedef MessageRef = String;

class Message extends Equatable {
  final String text;
  final String status;
  final MessageType type;

  const Message({
    required this.type,
    required this.text,
    required this.status,
  });

  const Message.empty()
      : this(
          text: '_empty.string',
          status: 'COMPLETED',
          type: MessageType.prompt,
        );

  @override
  List<Object> get props => [status, text, type];
}
