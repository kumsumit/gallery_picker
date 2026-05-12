import 'package:flutter/cupertino.dart';
import '../controller/picker_listener.dart';
import '../models/media_file.dart';

class GalleryPickerBuilder extends StatelessWidget {
  final Widget Function(List<MediaFile>? selectedFiles, BuildContext context)
  builder;
  const GalleryPickerBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: PickerListener.instance.stream,
      builder: ((context, snapshot) {
        return builder(snapshot.data, context);
      }),
    );
  }
}
