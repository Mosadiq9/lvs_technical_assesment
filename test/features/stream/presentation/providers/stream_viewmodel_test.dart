import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:alive_app/core/errors/failures.dart';
import 'package:alive_app/features/stream/domain/entities/stream_entity.dart';
import 'package:alive_app/features/stream/domain/entities/category_entity.dart';
import 'package:alive_app/features/stream/presentation/providers/stream_state.dart';
import 'package:alive_app/features/stream/presentation/providers/stream_viewmodel.dart';

import '../../../../mocks/mock_generators.mocks.dart';

void main() {
  late MockGetStreamsUseCase mockGetStreamsUseCase;
  late MockGetCategoriesUseCase mockGetCategoriesUseCase;
  late MockFollowStreamerUseCase mockFollowStreamerUseCase;

  setUp(() {
    mockGetStreamsUseCase = MockGetStreamsUseCase();
    mockGetCategoriesUseCase = MockGetCategoriesUseCase();
    mockFollowStreamerUseCase = MockFollowStreamerUseCase();
  });

  const tCategory = CategoryEntity(id: 'all', name: 'Global', flagAsset: 'global');
  const tStream = StreamEntity(
    id: 's1',
    streamerName: 'Name',
    streamerAvatarUrl: 'url',
    thumbnailUrl: 'url',
    viewerCount: 1,
    countryCode: 'us',
    categoryId: 'all',
    isFollowed: false,
  );
  const tStreamFollowed = StreamEntity(
    id: 's1',
    streamerName: 'Name',
    streamerAvatarUrl: 'url',
    thumbnailUrl: 'url',
    viewerCount: 1,
    countryCode: 'us',
    categoryId: 'all',
    isFollowed: true,
  );

  StreamViewModel createViewModel() {
    return StreamViewModel(
      getStreamsUseCase: mockGetStreamsUseCase,
      getCategoriesUseCase: mockGetCategoriesUseCase,
      followStreamerUseCase: mockFollowStreamerUseCase,
    );
  }

  group('loadInitialData', () {
    test('emits loaded with categories and streams on success', () async {
      when(mockGetCategoriesUseCase.call()).thenAnswer((_) async => const Right([tCategory]));
      when(mockGetStreamsUseCase.call(categoryId: 'all')).thenAnswer((_) async => const Right([tStream]));

      final viewModel = createViewModel();
      
      // Because loadInitialData is called in the constructor, we must wait for microtasks
      await Future.delayed(Duration.zero);

      expect(viewModel.state, equals(const StreamState.loaded(
        categories: [tCategory],
        streams: [tStream],
        selectedCategoryId: 'all',
      )));
    });

    test('emits error when getCategories fails', () async {
      when(mockGetCategoriesUseCase.call()).thenAnswer((_) async => const Left(ServerFailure('error')));
      when(mockGetStreamsUseCase.call(categoryId: 'all')).thenAnswer((_) async => const Right([tStream]));

      final viewModel = createViewModel();
      await Future.delayed(Duration.zero);

      expect(viewModel.state, equals(const StreamState.error('error')));
    });

    test('emits error when getStreams fails', () async {
      when(mockGetCategoriesUseCase.call()).thenAnswer((_) async => const Right([tCategory]));
      when(mockGetStreamsUseCase.call(categoryId: 'all')).thenAnswer((_) async => const Left(ServerFailure('error')));

      final viewModel = createViewModel();
      await Future.delayed(Duration.zero);

      expect(viewModel.state, equals(const StreamState.error('error')));
    });
  });

  group('selectCategory', () {
    test('emits loading then loaded with filtered streams', () async {
      when(mockGetCategoriesUseCase.call()).thenAnswer((_) async => const Right([tCategory]));
      when(mockGetStreamsUseCase.call(categoryId: 'all')).thenAnswer((_) async => const Right([tStream]));
      
      final viewModel = createViewModel();
      await Future.delayed(Duration.zero);

      when(mockGetStreamsUseCase.call(categoryId: 'gaming')).thenAnswer((_) async => const Right([]));

      final expectedStates = [
        const StreamState.loading(),
        const StreamState.loaded(categories: [tCategory], streams: [], selectedCategoryId: 'gaming'),
      ];

      expectLater(viewModel.stream, emitsInOrder(expectedStates));

      await viewModel.selectCategory('gaming');
    });

    test('does nothing if same category selected', () async {
      when(mockGetCategoriesUseCase.call()).thenAnswer((_) async => const Right([tCategory]));
      when(mockGetStreamsUseCase.call(categoryId: 'all')).thenAnswer((_) async => const Right([tStream]));
      
      final viewModel = createViewModel();
      await Future.delayed(Duration.zero);

      // We expect NO new states to be emitted
      var stateEmitted = false;
      final sub = viewModel.stream.listen((_) => stateEmitted = true);

      await viewModel.selectCategory('all');
      
      expect(stateEmitted, isFalse);
      sub.cancel();
    });

    test('does nothing if not in loaded state', () async {
      when(mockGetCategoriesUseCase.call()).thenAnswer((_) async => const Left(ServerFailure('')));
      when(mockGetStreamsUseCase.call(categoryId: 'all')).thenAnswer((_) async => const Right([]));
      
      final viewModel = createViewModel();
      await Future.delayed(Duration.zero);

      // State is error. selectCategory should return early.
      var stateEmitted = false;
      final sub = viewModel.stream.listen((_) => stateEmitted = true);

      await viewModel.selectCategory('gaming');
      
      expect(stateEmitted, isFalse);
      sub.cancel();
    });
  });

  group('toggleFollow', () {
    test('updates stream in list on success', () async {
      when(mockGetCategoriesUseCase.call()).thenAnswer((_) async => const Right([tCategory]));
      when(mockGetStreamsUseCase.call(categoryId: 'all')).thenAnswer((_) async => const Right([tStream]));
      
      final viewModel = createViewModel();
      await Future.delayed(Duration.zero);

      when(mockFollowStreamerUseCase.call('s1')).thenAnswer((_) async => const Right(tStreamFollowed));

      await viewModel.toggleFollow('s1');

      expect(viewModel.state, equals(const StreamState.loaded(
        categories: [tCategory],
        streams: [tStreamFollowed],
        selectedCategoryId: 'all',
      )));
    });

    test('does nothing on failure', () async {
      when(mockGetCategoriesUseCase.call()).thenAnswer((_) async => const Right([tCategory]));
      when(mockGetStreamsUseCase.call(categoryId: 'all')).thenAnswer((_) async => const Right([tStream]));
      
      final viewModel = createViewModel();
      await Future.delayed(Duration.zero);

      when(mockFollowStreamerUseCase.call('s1')).thenAnswer((_) async => const Left(ServerFailure('error')));

      await viewModel.toggleFollow('s1');

      // Should still be original un-followed stream
      expect(viewModel.state, equals(const StreamState.loaded(
        categories: [tCategory],
        streams: [tStream],
        selectedCategoryId: 'all',
      )));
    });
  });
}
