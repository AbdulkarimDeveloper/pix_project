import 'package:flutter/material.dart';
import 'package:pixa_project/modules/models/pix_data.dart';
import 'package:pixa_project/utils/router/router_generator.dart';
import 'package:pixa_project/utils/router/routers.dart';

class CardImage extends StatelessWidget {
  const CardImage({super.key, required this.image});

  final Hit image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        RouteGenerator.routerClient.pushNamed(
          Routers.imageDetailsName,
          extra: image,
        );
      },
      child: Card(
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.network(image.previewUrl ?? '', fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Text(
                image.user ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
