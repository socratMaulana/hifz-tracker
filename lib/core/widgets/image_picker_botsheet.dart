import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerBotsheet extends StatelessWidget {
  final Function onPickFile;

  const ImagePickerBotsheet({super.key, required this.onPickFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.photo_outlined,
                    size: 40,
                  ),
                  onPressed: () => onPickFile(ImageSource.gallery),
                ),
                const Text(
                  'Ambil dari galeri',
                  textAlign: TextAlign.center,
                )
              ],
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    size: 40,
                  ),
                  onPressed: () => onPickFile(ImageSource.camera),
                ),
                const Text('Ambil dari kamera')
              ],
            )
          ],
        ),
      ),
    );
  }
}
