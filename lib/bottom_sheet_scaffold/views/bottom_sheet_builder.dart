import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/bottom_sheet_controller.dart';
import '../models/sheet_status.dart';

class BottomSheetBuilder extends StatelessWidget {
  final Widget Function(SheetStatus status, BuildContext context) builder;

  const BottomSheetBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BottomSheetController>.value(
      value: BottomSheetController.instance,
      child: Consumer<BottomSheetController>(
        builder: (context, controller, _) {
          return builder(
            SheetStatus(
              positionY: controller.positionY,
              height: controller.currentHeight,
              minHeight: controller.minHeight,
              maxHeight: controller.maxHeight,
            ),
            context,
          );
        },
      ),
    );
  }
}
