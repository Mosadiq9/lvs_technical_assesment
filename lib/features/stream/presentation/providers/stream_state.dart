import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/stream_entity.dart';
import '../../domain/entities/category_entity.dart';

part 'stream_state.freezed.dart';

@freezed
sealed class StreamState with _$StreamState {
  const factory StreamState.initial() = StreamStateInitial;
  const factory StreamState.loading() = StreamStateLoading;
  const factory StreamState.loaded({
    required List<CategoryEntity> categories,
    required List<StreamEntity> streams,
    required String selectedCategoryId,
  }) = StreamStateLoaded;
  const factory StreamState.error(String message) = StreamStateError;
}
