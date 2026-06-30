import 'package:freezed_annotation/freezed_annotation.dart';

part 'stream_entity.freezed.dart';

@freezed
abstract class StreamEntity with _$StreamEntity {
  const factory StreamEntity({
    required String id,
    required String streamerName,
    required String streamerAvatarUrl,
    required String thumbnailUrl,
    required int viewerCount,
    required String countryCode,
    required String categoryId,
    @Default(false) bool isFollowed,
  }) = _StreamEntity;
}
