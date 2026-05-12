library;

import 'bottom_sheet_scaffold/controller/bottom_sheet_controller.dart';

export 'bottom_sheet_scaffold/models/sheet_status.dart';
export 'bottom_sheet_scaffold/views/barrier_viewer.dart';
export 'bottom_sheet_scaffold/views/bottom_sheet.dart';
export 'bottom_sheet_scaffold/views/bottom_sheet_builder.dart';
export 'bottom_sheet_scaffold/views/bottom_sheet_scaffold.dart';
export 'bottom_sheet_scaffold/views/draggable_area.dart';

class BottomSheetPanel {
  static BottomSheetController get _controller =>
      BottomSheetController.instance;

  static void open() {
    _controller.open();
  }

  static void close() {
    _controller.close();
  }

  static void updateHeight(double height) {
    _controller.updateHeight(height);
  }

  static bool get isOpen {
    return _controller.currentHeight > _controller.minHeight;
  }

  static bool get isExpanded {
    return _controller.currentHeight == _controller.maxHeight;
  }

  static bool get isCollapsed {
    return _controller.currentHeight == _controller.minHeight;
  }
}
