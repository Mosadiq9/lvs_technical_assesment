import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/stream_entity.dart';
import '../repositories/stream_repository.dart';

class GetStreamsUseCase {
  final StreamRepository repository;

  GetStreamsUseCase(this.repository);

  Future<Either<Failure, List<StreamEntity>>> call({String? categoryId}) {
    return repository.getStreams(categoryId: categoryId);
  }
}
