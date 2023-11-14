import 'package:dartz/dartz.dart';
import 'package:palm_ai_demo/core/core.dart';

typedef FutureResult<T> = Future<Either<Failure, T>>;
typedef StreamResult<T> = Either<Failure, Stream<T>>;

typedef VoidResult = FutureResult<void>;

typedef DataMap = Map<String, dynamic>;
