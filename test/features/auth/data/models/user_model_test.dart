import 'package:flutter_test/flutter_test.dart';
import 'package:alive_app/features/auth/data/models/user_model.dart';
import 'package:alive_app/features/auth/domain/entities/user_entity.dart';

void main() {
  const tUserModel = UserModel(
    id: 'user_123',
    email: 'test@example.com',
    displayName: 'Test User',
    photoUrl: 'http://example.com/photo.png',
  );

  group('UserModel', () {
    test('fromJson creates UserModel with all fields', () {
      final jsonMap = {
        'id': 'user_123',
        'email': 'test@example.com',
        'displayName': 'Test User',
        'photoUrl': 'http://example.com/photo.png',
      };

      final result = UserModel.fromJson(jsonMap);

      expect(result, equals(tUserModel));
    });

    test('fromJson creates UserModel with null optional fields', () {
      final jsonMap = {'id': 'user_123', 'email': 'test@example.com'};

      final result = UserModel.fromJson(jsonMap);

      expect(result.id, 'user_123');
      expect(result.email, 'test@example.com');
      expect(result.displayName, isNull);
      expect(result.photoUrl, isNull);
    });

    test('toJson produces correct map', () {
      final result = tUserModel.toJson();

      final expectedMap = {
        'id': 'user_123',
        'email': 'test@example.com',
        'displayName': 'Test User',
        'photoUrl': 'http://example.com/photo.png',
      };

      expect(result, equals(expectedMap));
    });

    test('toEntity maps all fields correctly', () {
      final result = tUserModel.toEntity();

      expect(result, isA<UserEntity>());
      expect(result.id, equals(tUserModel.id));
      expect(result.email, equals(tUserModel.email));
      expect(result.displayName, equals(tUserModel.displayName));
      expect(result.photoUrl, equals(tUserModel.photoUrl));
    });

    test('equality works via Freezed', () {
      const anotherModel = UserModel(
        id: 'user_123',
        email: 'test@example.com',
        displayName: 'Test User',
        photoUrl: 'http://example.com/photo.png',
      );

      expect(tUserModel, equals(anotherModel));
    });
  });
}
