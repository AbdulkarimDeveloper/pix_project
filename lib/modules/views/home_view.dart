import 'package:flutter/material.dart';
import 'package:pixa_project/injection.dart';
import 'package:pixa_project/modules/models/pix_data.dart';
import 'package:pixa_project/modules/view_models/home_view_model.dart';
import 'package:pixa_project/modules/views/card_image.dart';
import 'package:pixa_project/utils/constants.dart';
import 'package:pixa_project/utils/resources_path.dart';
import 'package:pixa_project/utils/router/router_generator.dart';
import 'package:pixa_project/utils/router/routers.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _controller = ScrollController();

  List<Hit> images = [];

  int _page = 1;
  bool _loading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadImages();

    _controller.addListener(() {
      if (_controller.position.pixels >=
              _controller.position.maxScrollExtent - 200 &&
          !_loading &&
          _hasMore) {
        _loadImages();
      }
    });
  }

  Future<void> _loadImages() async {
    setState(() => _loading = true);

    try {
      final newImages = await getIt<HomeViewModel>().fetchImages(_page);
      setState(() {
        images.addAll(newImages);
        _page++;
        if (newImages.isEmpty) _hasMore = false;
      });
    } catch (_) {}

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(ResourcesPath.logo, width: 30, height: 30),
            SizedBox(width: 10),
            Text('Pixa Images'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              RouteGenerator.routerClient.pushNamed(Routers.profileDetailsName);
            },
            icon: Icon(Icons.person, color: Constants.appColor),
          ),
        ],
      ),
      body: GridView.builder(
        controller: _controller,
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.75,
        ),
        itemCount: images.length + (_loading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= images.length) {
            return const Center(child: CircularProgressIndicator());
          }

          final image = images[index];

          return CardImage(image: image);
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
