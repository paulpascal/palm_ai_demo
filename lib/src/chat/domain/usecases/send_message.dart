import 'package:equatable/equatable.dart';
import 'package:palm_ai_demo/core/core.dart';
import 'package:palm_ai_demo/src/chat/domain/domain.dart';

class SendMessage extends UseCaseWithParams<MessageRef, SendMessageParams> {
  final MessageRepository _repository;

  const SendMessage(this._repository);

  @override
  FutureResult<MessageRef> call(params) async =>
      _repository.sendNewMessage(messageText: params.messageText);
}

class SendMessageParams extends Equatable {
  final String messageText;

  const SendMessageParams({
    required this.messageText,
  });

  const SendMessageParams.empty() : this(messageText: '_empty.string');

  @override
  List<Object?> get props => [messageText];
}
