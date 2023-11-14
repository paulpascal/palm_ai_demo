import 'package:equatable/equatable.dart';
import 'package:palm_ai_demo/core/core.dart';
import 'package:palm_ai_demo/src/chat/domain/domain.dart';

class GetMessageStream
    extends UseCaseStreamWithParams<Message, GetMessageStreamParams> {
  final MessageRepository _repository;

  const GetMessageStream(this._repository);

  @override
  StreamResult<Message> call(GetMessageStreamParams params) =>
      _repository.getMessageStream(messageRef: params.messageRef);
}

class GetMessageStreamParams extends Equatable {
  final String messageRef;

  const GetMessageStreamParams({
    required this.messageRef,
  });

  const GetMessageStreamParams.empty() : this(messageRef: '_empty.string');

  @override
  List<Object?> get props => [messageRef];
}
