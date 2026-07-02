import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:alive_app/core/errors/exceptions.dart';
import 'package:alive_app/core/errors/failures.dart';
import 'package:alive_app/features/stream/data/models/stream_model.dart';
import 'package:alive_app/features/stream/domain/entities/stream_entity.dart';
import 'package:alive_app/features/stream/data/models/category_model.dart';
import 'package:alive_app/features/stream/domain/entities/category_entity.dart';
import 'package:alive_app/features/stream/data/repositories/stream_repository_impl.dart';

import '../../../../mocks/mock_generators.mocks.dart';

void main() {
  late StreamRepositoryImpl repository;
  late MockStreamRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockStreamRemoteDataSource();
    repository = StreamRepositoryImpl(mockRemoteDataSource);
  });

  const tStreamModel = StreamModel(
    id: 's1',
    streamerName: 'Name',
    streamerAvatarUrl: 'url',
    thumbnailUrl: 'url',
    viewerCount: 1,
    countryCode: 'us',
    categoryId: 'c1',
  );

  const tCategoryModel = CategoryModel(id: 'c1', name: 'Cat', flagAsset: 'us');

  final tStreamEntity = tStreamModel.toEntity();
  final tCategoryEntity = tCategoryModel.toEntity();

  group('getStreams', () {
    test('should return Right(List<StreamEntity>) on success', () async {
      when(
        mockRemoteDataSource.getStreams(categoryId: anyNamed('categoryId')),
      ).thenAnswer((_) async => [tStreamModel]);

      final result = await repository.getStreams(categoryId: 'c1');

      result.fold((l) => fail('Expected Right'), (r) {
        expect(r, isA<List<StreamEntity>>());
        expect(r, equals([tStreamEntity]));
      });
      verify(mockRemoteDataSource.getStreams(categoryId: 'c1')).called(1);
    });

    test('should return Left(ServerFailure) on ServerException', () async {
      when(
        mockRemoteDataSource.getStreams(categoryId: anyNamed('categoryId')),
      ).thenThrow(ServerException('error message'));

      final result = await repository.getStreams();

      result.fold((l) {
        expect(l, isA<ServerFailure>());
        expect(l.message, 'error message');
      }, (r) => fail('Expected Left'));
    });
  });

  group('getCategories', () {
    test('should return Right(List<CategoryEntity>) on success', () async {
      when(
        mockRemoteDataSource.getCategories(),
      ).thenAnswer((_) async => [tCategoryModel]);

      final result = await repository.getCategories();

      result.fold((l) => fail('Expected Right'), (r) {
        expect(r, isA<List<CategoryEntity>>());
        expect(r, equals([tCategoryEntity]));
      });
    });

    test('should return Left(ServerFailure) on Exception', () async {
      when(mockRemoteDataSource.getCategories()).thenThrow(Exception('error'));

      final result = await repository.getCategories();

      result.fold((l) {
        expect(l, isA<ServerFailure>());
        expect(l.message, 'Exception: error');
      }, (r) => fail('Expected Left'));
    });
  });

  group('followStreamer', () {
    test('should return Right(StreamEntity) on success', () async {
      when(
        mockRemoteDataSource.followStreamer(any),
      ).thenAnswer((_) async => tStreamModel);

      final result = await repository.followStreamer('s1');

      result.fold(
        (l) => fail('Expected Right'),
        (r) => expect(r, equals(tStreamEntity)),
      );
    });

    test('should return Left(ServerFailure) on ServerException', () async {
      when(
        mockRemoteDataSource.followStreamer(any),
      ).thenThrow(ServerException('not found'));

      final result = await repository.followStreamer('s1');

      result.fold((l) {
        expect(l, isA<ServerFailure>());
        expect(l.message, 'not found');
      }, (r) => fail('Expected Left'));
    });
  });
}
