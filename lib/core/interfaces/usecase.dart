import 'package:palm_ai_demo/core/core.dart';

abstract class UseCaseWithParams<ReturnType, Params> {
  const UseCaseWithParams();

  FutureResult<ReturnType> call(Params params);
}

abstract class UseCaseWithoutParams<ReturnType> {
  const UseCaseWithoutParams();

  FutureResult<ReturnType> call();
}

abstract class UseCaseStreamWithParams<ReturnType, Params> {
  const UseCaseStreamWithParams();

  StreamResult<ReturnType> call(Params params);
}
