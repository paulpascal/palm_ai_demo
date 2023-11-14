import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:palm_ai_demo/core/utils/utils.dart';
import 'package:palm_ai_demo/src/chat/domain/domain.dart';
import 'package:palm_ai_demo/src/chat/data/data.dart';

import '../../../../fixtures/fixtures.dart';

void main() {
  const tModel = MessageModel.empty();

  test('should return a subclass of [Message] entity ', () {
    // Assert
    expect(tModel, isA<Message>());
  });

  final tJson = fixture('message.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('should return a [MessageModel] with the right data', () {
      // Act
      final result = MessageModel.fromMap(tMap);
      // Assert
      expect(result, equals(tModel));
    });
  });

  group('fromJson', () {
    test('should return a [UserModel] with the right data', () {
      // Act
      final result = MessageModel.fromJson(tJson);
      // Assert
      expect(result, equals(tModel));
    });
  });

  group('toMap', () {
    test('should return a [Map] with the right data', () {
      // Act
      final result = tModel.toMap();
      // Assert
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('should return a [JSON] with the right data', () {
      // Act
      final result = tModel.toJson();
      // Assert
      expect(result, equals(tJson));
    });
  });

  group('copyWith', () {
    test('should return a [MessageModel] with different data', () {
      // Act
      final result = tModel.copyWith(type: MessageType.response);
      // Assert
      expect(result.type, equals(MessageType.response));
    });
  });
}
