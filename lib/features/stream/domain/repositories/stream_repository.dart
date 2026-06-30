import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/stream_entity.dart';
import '../entities/category_entity.dart';

abstract class StreamRepository {
  Future<Either<Failure, List<StreamEntity>>> getStreams({String? categoryId});
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
  Future<Either<Failure, StreamEntity>> followStreamer(String streamId);
}
