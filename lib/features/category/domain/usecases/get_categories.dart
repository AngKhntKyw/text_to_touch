import 'package:fpdart/fpdart.dart';
import 'package:test_app/core/error/failure.dart';
import 'package:test_app/core/usecase/usecase.dart';
import 'package:test_app/features/category/data/models/category_model.dart';
import 'package:test_app/features/category/domain/repositories/category_repository.dart';

class GetCategories implements Usecase<List<CategoryModel>, NoParams> {
  final CategoryRepository categoryRepository;
  const GetCategories(this.categoryRepository);

  @override
  Future<Either<Failure, List<CategoryModel>>> call(NoParams params) async {
    return await categoryRepository.getCategories();
  }
}
