import 'package:palm_ai_demo/core/core.dart';
import 'package:palm_ai_demo/src/chat/domain/domain.dart';

abstract class MessageRepository {
  const MessageRepository();

  FutureResult<MessageRef> sendNewMessage({required String messageText});
  StreamResult<Message> getMessageStream({required String messageRef});
}
