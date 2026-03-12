import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ImageTest extends StatefulWidget {
  const ImageTest({super.key});

  @override
  State<ImageTest> createState() => _ImageTestState();
}

class _ImageTestState extends State<ImageTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 220,
          height: 220,
          color: Colors.grey.shade300,
          child: Image.network(
            'https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_t.png',
            fit: BoxFit.contain,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded || frame != null) {
                debugPrint('Image loaded successfully');
                return child;
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }

              final totalBytes = loadingProgress.expectedTotalBytes;
              final loadedBytes = loadingProgress.cumulativeBytesLoaded;

              debugPrint(
                'Loading image: $loadedBytes / ${totalBytes ?? 'unknown'}',
              );

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              debugPrint('Image load error: $error');
              return const Center(
                child: Icon(
                  Icons.broken_image,
                  size: 48,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}