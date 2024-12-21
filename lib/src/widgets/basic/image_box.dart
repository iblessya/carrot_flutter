import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final String? url;
  final double size;
  const ImageBox(this.url, {this.size = 60, super.key});

  @override
  Widget build(BuildContext context) {
    if (url == null) return const SizedBox();
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        url!,
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }
}
