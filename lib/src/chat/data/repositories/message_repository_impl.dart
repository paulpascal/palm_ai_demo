import 'package:dartz/dartz.dart';
import 'package:palm_ai_demo/core/core.dart';
import 'package:palm_ai_demo/src/chat/data/data.dart';
import 'package:palm_ai_demo/src/chat/domain/domain.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDatasource remoteDatasource;

  const MessageRepositoryImpl(this.remoteDatasource);

  @override
  StreamResult<Message> getMessageStream({required String messageRef}) {
    try {
      final messages =
          remoteDatasource.getMessageStream(messageRef: messageRef);
      return Right(messages);
    } on Exception catch (err) {
      return Left(
        ServerFailure(code: err.code, message: err.message),
      );
    } catch (err) {
      return Left(
        ServerFailure(code: 'cannot_get_messages', message: err.toString()),
      );
    }
  }

  @override
  FutureResult<MessageRef> sendNewMessage({required String messageText}) async {
    try {
      final messageRef =
          await remoteDatasource.sendMessage(messageText: messageText);
      return Right(messageRef);
    } on Exception catch (err) {
      return Left(
        ServerFailure(code: err.code, message: err.message),
      );
    } catch (err) {
      return Left(
        ServerFailure(code: 'cannot_send_message', message: err.toString()),
      );
    }
  }
}
