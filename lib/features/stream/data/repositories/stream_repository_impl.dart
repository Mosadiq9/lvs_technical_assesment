import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/stream_entity.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/stream_repository.dart';
import '../datasources/stream_remote_datasource.dart';

class StreamRepositoryImpl implements StreamRepository {
  final StreamRemoteDataSource remoteDataSource;

  StreamRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<StreamEntity>>> getStreams({
    String? categoryId,
  }) async {
    try {
      final models = await remoteDataSource.getStreams(categoryId: categoryId);
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final models = await remoteDataSource.getCategories();
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, StreamEntity>> followStreamer(String streamId) async {
    try {
      final model = await remoteDataSource.followStreamer(streamId);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
