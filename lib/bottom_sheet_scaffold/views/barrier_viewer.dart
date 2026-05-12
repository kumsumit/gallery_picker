import 'package:flutter/material.dart';

import '../controller/bottom_sheet_controller.dart';
import 'bottom_sheet_builder.dart';

class BarrierViewer extends StatelessWidget {
  final Widget? child;

  const BarrierViewer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return BottomSheetBuilder(
      builder: (status, context) {
        final controller = BottomSheetController.instance;
        return AnimatedContainer(
          duration: controller.animationDuration,
          width: double.infinity,
          height: double.infinity,
          color: status.isOpened
              ? controller.barrierColor.withAlpha(127)
              : Colors.transparent,
          child: child,
        );
      },
    );
  }
}
