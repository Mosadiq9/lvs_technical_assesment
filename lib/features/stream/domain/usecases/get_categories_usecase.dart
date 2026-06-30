import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/category_entity.dart';
import '../repositories/stream_repository.dart';

class GetCategoriesUseCase {
  final StreamRepository repository;

  GetCategoriesUseCase(this.repository);

  Future<Either<Failure, List<CategoryEntity>>> call() {
    return repository.getCategories();
  }
}
