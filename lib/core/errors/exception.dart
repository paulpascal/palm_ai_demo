import 'package:equatable/equatable.dart';

abstract class Exception extends Equatable {
  final String message;
  final String code;

  const Exception({
    required this.message,
    required this.code,
  });

  @override
  List<Object> get props => [message, code];
}

class ServerException extends Exception {
  const ServerException({
    required super.message,
    required super.code,
  });

  const ServerException.unknown()
      : this(
          code: 'unknown_server_exception',
          message: 'Unknown Server Exception',
        );
}
