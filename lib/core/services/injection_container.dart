import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:palm_ai_demo/src/chat/data/datasources/datasources.dart';
import 'package:palm_ai_demo/src/chat/data/repositories/message_repository_impl.dart';
import 'package:palm_ai_demo/src/chat/domain/domain.dart';
import 'package:palm_ai_demo/src/chat/presentation/presentation.dart';

final sl = GetIt.instance;

Future<void> initDependencyInjection() async {
  sl.registerFactory(() => ChatBloc(
        getMessageStream: sl<GetMessageStream>(),
        sendMessage: sl<SendMessage>(),
      ));

  sl.registerLazySingleton<GetMessageStream>(
    () => GetMessageStream(sl<MessageRepository>()),
  );
  sl.registerLazySingleton<SendMessage>(
    () => SendMessage(sl<MessageRepository>()),
  );

  sl.registerLazySingleton<MessageRepository>(
    () => MessageRepositoryImpl(sl<MessageRemoteDatasource>()),
  );

  sl.registerLazySingleton<MessageRemoteDatasource>(
    () => FirestoreMessageRemoteDatasource(sl<FirebaseFirestore>()),
  );

  sl.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
}
