// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StreamModel _$StreamModelFromJson(Map<String, dynamic> json) => _StreamModel(
  id: json['id'] as String,
  streamerName: json['streamerName'] as String,
  streamerAvatarUrl: json['streamerAvatarUrl'] as String,
  thumbnailUrl: json['thumbnailUrl'] as String,
  viewerCount: (json['viewerCount'] as num).toInt(),
  countryCode: json['countryCode'] as String,
  categoryId: json['categoryId'] as String,
  isFollowed: json['isFollowed'] as bool? ?? false,
);

Map<String, dynamic> _$StreamModelToJson(_StreamModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'streamerName': instance.streamerName,
      'streamerAvatarUrl': instance.streamerAvatarUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'viewerCount': instance.viewerCount,
      'countryCode': instance.countryCode,
      'categoryId': instance.categoryId,
      'isFollowed': instance.isFollowed,
    };
