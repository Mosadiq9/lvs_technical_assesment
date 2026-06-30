import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/stream_entity.dart';

part 'stream_model.freezed.dart';
part 'stream_model.g.dart';

@freezed
abstract class StreamModel with _$StreamModel {
  const StreamModel._();

  const factory StreamModel({
    required String id,
    required String streamerName,
    required String streamerAvatarUrl,
    required String thumbnailUrl,
    required int viewerCount,
    required String countryCode,
    required String categoryId,
    @Default(false) bool isFollowed,
  }) = _StreamModel;

  factory StreamModel.fromJson(Map<String, dynamic> json) => _$StreamModelFromJson(json);

  StreamEntity toEntity() {
    return StreamEntity(
      id: id,
      streamerName: streamerName,
      streamerAvatarUrl: streamerAvatarUrl,
      thumbnailUrl: thumbnailUrl,
      viewerCount: viewerCount,
      countryCode: countryCode,
      categoryId: categoryId,
      isFollowed: isFollowed,
    );
  }
}
