import 'package:flutter/material.dart';
import 'package:pixa_project/modules/models/pix_data.dart';

class ImageDetailView extends StatelessWidget {
  final Hit image;

  const ImageDetailView({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Detail')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //------------------ Section 1 ------------------//
            const Text(
              'Image Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Image.network(image.imageUrl ?? image.previewUrl ?? ''),

            const SizedBox(height: 10),
            _infoRow('Size', '${image.imageWidth} x ${image.imageHeight}'),
            _infoRow('Type', image.type ?? ''),
            _infoRow('Tags', image.tags ?? ''),

            const Divider(height: 30),

            //------------------ Section 2 ------------------//
            const Text(
              'Uploader Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            _infoRow('User', image.user ?? ''),
            _infoRow('Views', image.views.toString()),
            _infoRow('Likes', image.likes.toString()),
            _infoRow('Comments', image.comments.toString()),
            //No favorites ???
            // _infoRow('Views', image.favorites.toString()),
            _infoRow('Downloads', image.downloads.toString()),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
