import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_picker/user_widgets/toast.dart';
import 'package:intl/intl.dart';
import '../models/media_file.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class VideoProvider extends StatefulWidget {
  final MediaFile media;
  final double? width, height;

  const VideoProvider({
    super.key,
    required this.media,
    this.width,
    this.height,
  });
  @override
  State<VideoProvider> createState() => _VideoProviderState();
}

class _VideoProviderState extends State<VideoProvider> {
  late final Player player = Player();
  late final VideoController controller = VideoController(
    player,
    configuration: const VideoControllerConfiguration(
      enableHardwareAcceleration: true,
    ),
  );

  File? _file;
  late MediaFile media;

  @override
  void initState() {
    media = widget.media;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initMedia();
    });
    super.initState();
  }

  Future<void> initMedia() async {
    try {
      if (media.file == null) {
        _file = await media.getFile();
      } else {
        _file = media.file;
      }
      if (_file != null) {
        player.open(Media('file://${_file!.path}'));
      }
    } catch (e) {
      if (kDebugMode) {
        print("Failed : $e");
      }
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  bool anyProcess = false;
  @override
  Widget build(BuildContext context) {
    if (media != widget.media) {
      media = widget.media;
      initMedia();
    }
    final theme = MaterialVideoControlsThemeData(
      displaySeekBar: true,
      brightnessGesture: true,
      volumeGesture: true,
      seekGesture: true,
      speedUpOnLongPress: true,
      automaticallyImplySkipNextButton: false,
      automaticallyImplySkipPreviousButton: false,
      topButtonBar: [
        const Spacer(),
        MaterialDesktopCustomButton(
          onPressed: () {
            showSnackBar(context, basename(_file!.path));
          },
          icon: const Icon(Icons.info),
        ),
        MaterialDesktopCustomButton(
          onPressed: () async {
            final Uint8List? screenshot = await player.screenshot();
            if (screenshot != null) {
              final directory = await getApplicationDocumentsDirectory();
              final newDirectory = Directory(
                '${directory.path}/filex/screenshots',
              );
              await newDirectory.create(recursive: true);
              final filename = 'Screenshot_${getFormattedDateTime()}.jpg';
              final pathOfImage = await File(
                '${newDirectory.path}/$filename',
              ).create();
              await pathOfImage.writeAsBytes(screenshot);
              if (mounted && context.mounted) {
                showSnackBar(context, "Screenshot captured $filename");
              }
            }
          },
          icon: const Icon(Icons.camera),
        ),
        MaterialDesktopCustomButton(
          onPressed: () async {
            final file = await File(_file!.path).delete();
            if (!await file.exists()) {
              if (mounted && context.mounted) {
                Navigator.pop(context);
                showSnackBar(context, "${_file!.path} deleted succesfully");
              }
            }
          },
          icon: const Icon(Icons.delete),
        ),
      ],
    );
    return MaterialVideoControlsTheme(
      normal: theme,
      fullscreen: theme,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Video(
            controller: controller,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ),
    );
  }
}

String getFormattedDateTime() {
  final now = DateTime.now();
  final formatter = DateFormat('yyyyMMdd_HHmmss');
  return formatter.format(now);
}
