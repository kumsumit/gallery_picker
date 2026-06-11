import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionDeniedView extends StatelessWidget {
  final Config config;
  const PermissionDeniedView({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final Color titleColor = config.textStyle.color ?? scheme.onSurface;

    return Container(
      color: config.backgroundColor,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.photo_library_outlined,
            size: 64,
            color: config.underlineColor,
          ),
          const SizedBox(height: 20),
          Text(
            "Please allow access to your photos",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: titleColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "This lets you access photos and videos from your library.",
            textAlign: TextAlign.center,
            style: config.textStyle,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () async {
              await openAppSettings();
            },
            icon: const Icon(Icons.settings_outlined),
            label: const Text("Enable library access"),
          ),
        ],
      ),
    );
  }
}
