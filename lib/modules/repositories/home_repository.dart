import 'package:pixa_project/core/remote/api_service.dart';
import 'package:pixa_project/modules/models/pix_data.dart';

abstract class HomeRepositoryAbs {
  Future<List<Hit>> fetchData(int page);
}

class HomeRepositoryImpl extends HomeRepositoryAbs {
  HomeRepositoryImpl({required this.apiService});

  final ApiService apiService;

  @override
  Future<List<Hit>> fetchData(int page) => apiService.fetchImages(page: page);
}
