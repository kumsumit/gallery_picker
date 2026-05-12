import 'dart:async';

import '../models/media_file.dart';

class PickerListener {
  PickerListener._();

  static PickerListener? _instance;

  static PickerListener get instance {
    return _instance ??= PickerListener._();
  }

  static bool get isRegistered => _instance != null;

  static void disposeInstance() {
    _instance?.dispose();
    _instance = null;
  }

  final StreamController<List<MediaFile>> _controller =
      StreamController<List<MediaFile>>.broadcast();

  Stream<List<MediaFile>> get stream => _controller.stream;

  void updateController(List<MediaFile> medias) {
    if (!_controller.isClosed) {
      _controller.add(List<MediaFile>.from(medias));
    }
  }

  void dispose() {
    _controller.close();
  }
}
