import 'package:flutter_test/flutter_test.dart';
import 'package:alive_app/features/stream/data/models/stream_model.dart';
import 'package:alive_app/features/stream/data/models/category_model.dart';
import 'package:alive_app/features/stream/domain/entities/stream_entity.dart';
import 'package:alive_app/features/stream/domain/entities/category_entity.dart';

void main() {
  const tStreamModel = StreamModel(
    id: 's_1',
    streamerName: 'Test Streamer',
    streamerAvatarUrl: 'avatar.png',
    thumbnailUrl: 'thumb.png',
    viewerCount: 100,
    countryCode: 'us',
    categoryId: 'gaming',
    isFollowed: true,
  );

  const tCategoryModel = CategoryModel(
    id: 'c_1',
    name: 'Gaming',
    flagAsset: 'us',
  );

  group('StreamModel', () {
    test('StreamModel fromJson creates model', () {
      final jsonMap = {
        'id': 's_1',
        'streamerName': 'Test Streamer',
        'streamerAvatarUrl': 'avatar.png',
        'thumbnailUrl': 'thumb.png',
        'viewerCount': 100,
        'countryCode': 'us',
        'categoryId': 'gaming',
        'isFollowed': true,
      };

      final result = StreamModel.fromJson(jsonMap);

      expect(result, equals(tStreamModel));
    });

    test('StreamModel toJson produces correct map', () {
      final result = tStreamModel.toJson();

      final expectedMap = {
        'id': 's_1',
        'streamerName': 'Test Streamer',
        'streamerAvatarUrl': 'avatar.png',
        'thumbnailUrl': 'thumb.png',
        'viewerCount': 100,
        'countryCode': 'us',
        'categoryId': 'gaming',
        'isFollowed': true,
      };

      expect(result, equals(expectedMap));
    });

    test('StreamModel toEntity maps all fields', () {
      final result = tStreamModel.toEntity();

      expect(result, isA<StreamEntity>());
      expect(result.id, equals(tStreamModel.id));
      expect(result.streamerName, equals(tStreamModel.streamerName));
      expect(result.isFollowed, equals(tStreamModel.isFollowed));
    });

    test('StreamModel isFollowed defaults to false', () {
      const model = StreamModel(
        id: 's_2',
        streamerName: 'Name',
        streamerAvatarUrl: 'url',
        thumbnailUrl: 'url',
        viewerCount: 0,
        countryCode: 'xx',
        categoryId: 'yy',
      );

      expect(model.isFollowed, isFalse);
    });

    test('StreamModel copyWith toggles isFollowed', () {
      final model = tStreamModel.copyWith(isFollowed: false);
      
      expect(model.isFollowed, isFalse);
      expect(model.id, equals(tStreamModel.id));
    });
  });

  group('CategoryModel', () {
    test('CategoryModel fromJson creates model', () {
      final jsonMap = {
        'id': 'c_1',
        'name': 'Gaming',
        'flagAsset': 'us',
      };

      final result = CategoryModel.fromJson(jsonMap);

      expect(result, equals(tCategoryModel));
    });

    test('CategoryModel toEntity maps all fields', () {
      final result = tCategoryModel.toEntity();

      expect(result, isA<CategoryEntity>());
      expect(result.id, equals(tCategoryModel.id));
      expect(result.name, equals(tCategoryModel.name));
      expect(result.flagAsset, equals(tCategoryModel.flagAsset));
    });
  });
}
