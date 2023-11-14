import 'package:flutter/widgets.dart';
import 'package:palm_ai_demo/core/core.dart';
import 'package:palm_ai_demo/src/chat/data/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MessageRemoteDatasource {
  const MessageRemoteDatasource();

  Future<String> sendMessage({required String messageText});
  Stream<MessageModel> getMessageStream({required String messageRef});
}

class FirestoreMessageRemoteDatasource implements MessageRemoteDatasource {
  final FirebaseFirestore cloudStoreClient;

  const FirestoreMessageRemoteDatasource(this.cloudStoreClient);

  @override
  Stream<MessageModel> getMessageStream({
    required String messageRef,
    collectionPath = 'discussions',
  }) {
    try {
      final result = cloudStoreClient
          .collection(collectionPath)
          .doc(messageRef)
          .snapshots()
          .where(
        (snapshot) {
          final data = snapshot.data();
          return data != null && data['status'] != null;
        },
      ).map(
        (snapshot) => MessageModel.fromMap(snapshot.data() as DataMap),
      );
      return result;
    } catch (err, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);

      throw ServerException(
        message: err.toString(),
        code: 'cannot_get_messages',
      );
    }
  }

  @override
  Future<String> sendMessage({
    required String messageText,
    collectionPath = 'discussions',
  }) async {
    try {
      final result = await cloudStoreClient
          .collection(collectionPath)
          .add({'prompt': messageText});
      return result.id;
    } on ServerException {
      rethrow;
    } catch (err, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);

      throw ServerException(
        message: err.toString(),
        code: 'cannot_send_message',
      );
    }
  }
}
