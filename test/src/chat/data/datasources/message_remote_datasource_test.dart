import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:palm_ai_demo/core/core.dart';
import 'package:palm_ai_demo/src/chat/data/data.dart';
import 'package:palm_ai_demo/src/chat/domain/domain.dart';

import '../../../../utils/utils.dart';

void main() {
  late FirebaseFirestore cloudStoreClient;
  late FirestoreMessageRemoteDatasource datasource;

  setUp(() {
    cloudStoreClient = FakeFirebaseFirestore();
    datasource = FirestoreMessageRemoteDatasource(cloudStoreClient);
  });

  const tCollectionPath = 't_discussions';
  const tParams = SendMessageParams.empty();
  final tDataItem = {'prompt': tParams.messageText};

  group('sendMessage', () {
    test('should add message to collection', () async {
      // Act
      await datasource.sendMessage(
        messageText: tParams.messageText,
        collectionPath: tCollectionPath,
      );
      // Assert
      final List<DataMap> currentData =
          (await cloudStoreClient.collection(tCollectionPath).get())
              .docs
              .map((snapshot) => snapshot.data())
              .toList();

      expect(currentData, MapListContains(tDataItem));
    });
  });
}
