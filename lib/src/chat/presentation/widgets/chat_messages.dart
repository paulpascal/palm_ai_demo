import 'package:flutter/widgets.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart' hide Message;
import 'package:palm_ai_demo/core/constants/assets.dart';
import 'package:palm_ai_demo/src/chat/domain/domain.dart';

class ChatMessagesWidget extends StatelessWidget {
  final List<Message> messages;
  final Function(String) onSubmit;

  const ChatMessagesWidget({
    super.key,
    required this.messages,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    const user = types.User(
      id: 'user',
      firstName: 'Me',
      imageUrl: Assets.userImage,
      role: types.Role.user,
    );
    const bot = types.User(
      id: 'bot',
      firstName: 'Palm Ai',
      imageUrl: Assets.palmAIImage,
      role: types.Role.agent,
    );

    return Chat(
      messages: messages.reversed
          .map(
            (message) => types.TextMessage(
              id: message.toString(),
              author: message.type == MessageType.response ? bot : user,
              type: types.MessageType.text,
              text: message.text,
            ),
          )
          .toList(),
      onAttachmentPressed: null,
      onMessageTap: (_, __) {},
      onPreviewDataFetched: (_, __) {},
      onSendPressed: (partialText) => onSubmit(partialText.text),
      showUserAvatars: true,
      showUserNames: true,
      user: user,
    );
  }
}
