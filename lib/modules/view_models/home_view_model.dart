import 'package:flutter/material.dart';
import 'package:pixa_project/modules/models/pix_data.dart';
import 'package:pixa_project/modules/repositories/home_repository.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required this.repository});
  final HomeRepositoryAbs repository;

  List<Hit> images = [];
  int _page = 1;
  bool loading = false;
  bool hasMore = true;

  Future<List<Hit>> fetchImages(int page) {
    return repository.fetchData(page);
  }

  Future<void> loadImages() async {
    loading = true;
    notifyListeners();

    try {
      final newImages = await fetchImages(_page);
      images.addAll(newImages);
      _page++;
      if (newImages.isEmpty) hasMore = false;
      notifyListeners();
    } catch (_) {}

    loading = false;
    notifyListeners();
  }

  void clear() {
    images = [];
    _page = 1;
    loading = false;
    hasMore = true;
  }
}
