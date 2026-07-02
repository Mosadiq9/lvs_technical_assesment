import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_client.dart';
import '../../data/datasources/stream_remote_datasource.dart';
import '../../data/repositories/stream_repository_impl.dart';
import '../../domain/repositories/stream_repository.dart';
import '../../domain/usecases/get_streams_usecase.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/follow_streamer_usecase.dart';
import 'stream_state.dart';
import 'stream_viewmodel.dart';

final streamRemoteDataSourceProvider = Provider<StreamRemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return StreamRemoteDataSourceImpl(apiClient: apiClient);
});

final streamRepositoryProvider = Provider<StreamRepository>((ref) {
  final remoteDataSource = ref.watch(streamRemoteDataSourceProvider);
  return StreamRepositoryImpl(remoteDataSource);
});

final getStreamsUseCaseProvider = Provider<GetStreamsUseCase>((ref) {
  final repository = ref.watch(streamRepositoryProvider);
  return GetStreamsUseCase(repository);
});

final getCategoriesUseCaseProvider = Provider<GetCategoriesUseCase>((ref) {
  final repository = ref.watch(streamRepositoryProvider);
  return GetCategoriesUseCase(repository);
});

final followStreamerUseCaseProvider = Provider<FollowStreamerUseCase>((ref) {
  final repository = ref.watch(streamRepositoryProvider);
  return FollowStreamerUseCase(repository);
});

final streamViewModelProvider =
    StateNotifierProvider<StreamViewModel, StreamState>((ref) {
      return StreamViewModel(
        getStreamsUseCase: ref.watch(getStreamsUseCaseProvider),
        getCategoriesUseCase: ref.watch(getCategoriesUseCaseProvider),
        followStreamerUseCase: ref.watch(followStreamerUseCaseProvider),
      );
    });
