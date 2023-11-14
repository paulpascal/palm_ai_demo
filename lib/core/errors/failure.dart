import 'package:equatable/equatable.dart';
import 'package:palm_ai_demo/core/core.dart';

abstract class Failure extends Equatable {
  final String message;
  final String code;

  const Failure({
    required this.message,
    required this.code,
  });

  String get errorMessage => 'Error: $message';

  @override
  List<Object> get props => [message, code];
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    required super.code,
  });

  factory ServerFailure.fromException(ServerException exception) =>
      ServerFailure(
        code: exception.code,
        message: exception.message,
      );
}
