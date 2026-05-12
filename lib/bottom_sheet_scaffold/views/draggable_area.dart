import 'package:flutter/cupertino.dart';

import '../controller/bottom_sheet_controller.dart';

class DraggableArea extends StatelessWidget {
  final Widget child;

  const DraggableArea({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final controller = BottomSheetController.instance;
    return GestureDetector(
      onVerticalDragStart: controller.startDrag,
      onVerticalDragUpdate: controller.updateDrag,
      onVerticalDragEnd: controller.endDrag,
      child: child,
    );
  }
}
