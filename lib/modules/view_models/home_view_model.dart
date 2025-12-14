import 'package:pixa_project/modules/models/pix_data.dart';
import 'package:pixa_project/modules/repositories/home_repository.dart';

class HomeViewModel {
  HomeViewModel({required this.repository});
  final HomeRepositoryAbs repository;

  Future<List<Hit>> fetchImages(int page) {
    return repository.fetchData(page);
  }
}
