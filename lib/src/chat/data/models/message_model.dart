import 'dart:convert';

import 'package:palm_ai_demo/core/core.dart';
import 'package:palm_ai_demo/src/chat/domain/domain.dart';

class MessageModel extends Message {
  const MessageModel({
    required super.text,
    required super.type,
    required super.status,
  });

  const MessageModel.empty()
      : this(
          text: '_empty.string',
          type: MessageType.prompt,
          status: 'COMPLETED',
        );

  MessageModel copyWith({
    String? status,
    String? text,
    MessageType? type,
  }) {
    return MessageModel(
      status: status ?? this.status,
      text: text ?? this.text,
      type: type ?? this.type,
    );
  }

  DataMap toMap() {
    return <String, dynamic>{
      'status': {"state": status},
      'text': text,
      'type': type == MessageType.prompt ? 'PROMPT' : 'RESPONSE',
    };
  }

  factory MessageModel.fromMap(DataMap map) {
    return MessageModel(
      status: map['status']['state'],
      text: map['response'] ?? map['prompt'] ?? map['text'],
      type: map['type'] == 'PROMPT' ? MessageType.prompt : MessageType.response,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
