import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/stream_entity.dart';
import '../repositories/stream_repository.dart';

class FollowStreamerUseCase {
  final StreamRepository repository;

  FollowStreamerUseCase(this.repository);

  Future<Either<Failure, StreamEntity>> call(String streamId) {
    return repository.followStreamer(streamId);
  }
}
