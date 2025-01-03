import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class UpdateImagePreViewer extends StatefulWidget {
  final String? imagePath;
  const UpdateImagePreViewer({super.key, required this.imagePath});

  @override
  State<UpdateImagePreViewer> createState() => _UpdateImagePreViewerState();
}

class _UpdateImagePreViewerState extends State<UpdateImagePreViewer> {
  bool _isNetworkImage(String? path) {
    return path != null &&
        (path.startsWith('http://') || path.startsWith('https://'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // Fixed height
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 2,
        ),
        color: Colors.grey[200],
      ),
      child: widget.imagePath == null || widget.imagePath!.isEmpty
          ? const Icon(
              Icons.image,
              size: 50,
              color: Colors.grey,
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                image: _isNetworkImage(widget.imagePath)
                    ? CachedNetworkImageProvider(widget.imagePath!)
                    : FileImage(File(widget.imagePath!)) as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
