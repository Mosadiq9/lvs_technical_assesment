import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_streams_usecase.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/follow_streamer_usecase.dart';
import 'stream_state.dart';

class StreamViewModel extends StateNotifier<StreamState> {
  final GetStreamsUseCase _getStreamsUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;
  final FollowStreamerUseCase _followStreamerUseCase;

  StreamViewModel({
    required GetStreamsUseCase getStreamsUseCase,
    required GetCategoriesUseCase getCategoriesUseCase,
    required FollowStreamerUseCase followStreamerUseCase,
  })  : _getStreamsUseCase = getStreamsUseCase,
        _getCategoriesUseCase = getCategoriesUseCase,
        _followStreamerUseCase = followStreamerUseCase,
        super(const StreamState.initial()) {
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    state = const StreamState.loading();

    final categoriesResult = await _getCategoriesUseCase();
    final streamsResult = await _getStreamsUseCase(categoryId: 'all');

    categoriesResult.fold(
      (failure) => state = StreamState.error(failure.message),
      (categories) {
        streamsResult.fold(
          (failure) => state = StreamState.error(failure.message),
          (streams) => state = StreamState.loaded(
            categories: categories,
            streams: streams,
            selectedCategoryId: 'all',
          ),
        );
      },
    );
  }

  Future<void> selectCategory(String categoryId) async {
    final currentState = state;
    if (currentState is! StreamStateLoaded) return;

    if (currentState.selectedCategoryId == categoryId) return;

    state = const StreamState.loading();

    final streamsResult = await _getStreamsUseCase(categoryId: categoryId);

    streamsResult.fold(
      (failure) => state = StreamState.error(failure.message),
      (streams) => state = StreamState.loaded(
        categories: currentState.categories,
        streams: streams,
        selectedCategoryId: categoryId,
      ),
    );
  }

  Future<void> toggleFollow(String streamId) async {
    final currentState = state;
    if (currentState is! StreamStateLoaded) return;

    final result = await _followStreamerUseCase(streamId);
    result.fold(
      (failure) {}, // Could log or show error snackbar
      (updatedStream) {
        final updatedList = currentState.streams.map((s) {
          return s.id == streamId ? updatedStream : s;
        }).toList();

        state = currentState.copyWith(streams: updatedList);
      },
    );
  }
}
