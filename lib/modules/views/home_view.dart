import 'package:flutter/material.dart';
import 'package:pixa_project/injection.dart';
import 'package:pixa_project/modules/view_models/home_view_model.dart';
import 'package:pixa_project/modules/views/card_image.dart';
import 'package:pixa_project/utils/constants.dart';
import 'package:pixa_project/utils/resources_path.dart';
import 'package:pixa_project/utils/router/router_generator.dart';
import 'package:pixa_project/utils/router/routers.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    getIt<HomeViewModel>().loadImages();

    _controller.addListener(() {
      bool loading = getIt<HomeViewModel>().loading;
      bool hasMore = getIt<HomeViewModel>().hasMore;

      if (_controller.position.pixels >=
              _controller.position.maxScrollExtent - 200 &&
          !loading &&
          hasMore) {
        getIt<HomeViewModel>().loadImages();
      }
    });
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
      body: ChangeNotifierProvider(
        create: (context) => getIt<HomeViewModel>(),
        child: Consumer<HomeViewModel>(
          builder: (context, notify, _) {
            return GridView.builder(
              controller: _controller,
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.75,
              ),
              itemCount:
                  getIt<HomeViewModel>().images.length +
                  (getIt<HomeViewModel>().loading ? 1 : 0),
              itemBuilder: (context, index) {
                final images = getIt<HomeViewModel>().images;
                if (index >= images.length) {
                  return const Center(child: CircularProgressIndicator());
                }

                final image = images[index];

                return CardImage(image: image);
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
