import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gallery_picker/controller/gallery_controller.dart';
import '/gallery_picker.dart';

class PickerScaffold extends StatefulWidget {
  const PickerScaffold({
    super.key,
    required this.onSelect,
    this.body,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.bottomSheetMinHeight = 0,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
    this.config,
    this.heroBuilder,
    this.initSelectedMedia,
    this.extraRecentMedia,
    this.singleMedia = false,
    this.multipleMediaBuilder,
    this.onWillPop,
  });
  final double bottomSheetMinHeight;
  final Widget? body;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final AlignmentDirectional persistentFooterAlignment;
  final Widget? drawer;
  final DrawerCallback? onDrawerChanged;
  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;
  final Color? drawerScrimColor;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final String? restorationId;
  final Config? config;
  final List<MediaFile>? initSelectedMedia;
  final List<MediaFile>? extraRecentMedia;
  final bool singleMedia;
  final Future<bool> Function()? onWillPop;
  final Function(List<MediaFile> selectedMedia) onSelect;
  final Widget Function(String tag, MediaFile media, BuildContext context)?
  heroBuilder;
  final Widget Function(List<MediaFile> media, BuildContext context)?
  multipleMediaBuilder;

  @override
  State<PickerScaffold> createState() => _PickerScaffoldState();
}

class _PickerScaffoldState extends State<PickerScaffold> {
  late final PhoneGalleryController _galleryController;

  @override
  void initState() {
    super.initState();
    _galleryController = PhoneGalleryController();
  }

  @override
  void didUpdateWidget(covariant PickerScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initSelectedMedia != oldWidget.initSelectedMedia &&
        widget.initSelectedMedia != null) {
      _galleryController.updateSelectedFiles(widget.initSelectedMedia!);
    }
    if (widget.extraRecentMedia != oldWidget.extraRecentMedia &&
        widget.extraRecentMedia != null) {
      _galleryController.updateExtraRecentMedia(widget.extraRecentMedia!);
    }
  }

  @override
  void dispose() {
    _galleryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetScaffold(
      extendBody: widget.extendBody,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      appBar: widget.appBar,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      persistentFooterAlignment: widget.persistentFooterAlignment,
      persistentFooterButtons: widget.persistentFooterButtons,
      drawer: widget.drawer,
      onDrawerChanged: widget.onDrawerChanged,
      endDrawer: widget.endDrawer,
      onEndDrawerChanged: widget.onEndDrawerChanged,
      drawerDragStartBehavior: widget.drawerDragStartBehavior,
      drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
      drawerScrimColor: widget.drawerScrimColor,
      endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      restorationId: widget.restorationId,
      primary: widget.primary,
      backgroundColor: widget.backgroundColor,
      bottomNavigationBar: widget.bottomNavigationBar,
      oneFingerScrolling: true,
      body: widget.body,
      onWillPop: () async {
        if (BottomSheetPanel.isOpen) {
          if (_galleryController.selectedAlbum != null) {
            _galleryController.backToPicker();
          } else {
            BottomSheetPanel.close();
          }
          return false;
        } else {
          if (widget.onWillPop != null) {
            return await widget.onWillPop!();
          } else {
            return true;
          }
        }
      },
      bottomSheet: DraggableBottomSheet(
        draggableBody: true,
        minHeight: widget.bottomSheetMinHeight,
        maxHeight: MediaQuery.of(context).size.height,
        onHide: () {
          _galleryController.resetBottomSheetView();
        },
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: GalleryPickerView(
            onSelect: widget.onSelect,
            config: widget.config,
            heroBuilder: widget.heroBuilder,
            multipleMediaBuilder: widget.multipleMediaBuilder,
            singleMedia: widget.singleMedia,
            isBottomSheet: true,
            initSelectedMedia: widget.initSelectedMedia,
            extraRecentMedia: widget.extraRecentMedia,
            startWithRecent: true,
            controller: _galleryController,
          ),
        ),
      ),
    );
  }
}
