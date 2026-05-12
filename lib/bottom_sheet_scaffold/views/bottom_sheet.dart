import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../bottom_sheet_scaffold.dart';
import '../controller/bottom_sheet_controller.dart';

class DraggableBottomSheet extends StatelessWidget {
  final double maxHeight;
  final double minHeight;
  final bool draggableBody;
  final bool headerVisibilityOnTap;
  final bool autoSwipped;
  final bool gradientOpacity;
  final Widget? header;
  final Widget body;
  final Duration animationDuration;
  final void Function()? onShow;
  final void Function()? onHide;
  final double radius;
  final Color? backgroundColor;

  DraggableBottomSheet({
    super.key,
    this.maxHeight = 500,
    this.minHeight = 0,
    this.animationDuration = const Duration(milliseconds: 200),
    this.header,
    this.autoSwipped = true,
    this.draggableBody = true,
    this.gradientOpacity = true,
    this.headerVisibilityOnTap = true,
    this.backgroundColor = Colors.white,
    this.onHide,
    this.radius = 15,
    this.onShow,
    required this.body,
  }) {
    BottomSheetController.instance.configureSheet(
      maxHeight: maxHeight,
      minHeight: minHeight,
      animationDuration: animationDuration,
      autoSwipped: autoSwipped,
      onHide: onHide,
      onShow: onShow,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BottomSheetController>.value(
      value: BottomSheetController.instance,
      child: Consumer<BottomSheetController>(
        builder: (context, bottomSheetController, _) {
          return Positioned(
            bottom: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  if (headerVisibilityOnTap || !BottomSheetPanel.isExpanded)
                    DraggableArea(child: header ?? const SizedBox()),
                  AnimatedOpacity(
                    duration:
                        (bottomSheetController.currentHeight ==
                                bottomSheetController.maxHeight ||
                            bottomSheetController.currentHeight ==
                                bottomSheetController.minHeight)
                        ? animationDuration
                        : const Duration(milliseconds: 100),
                    opacity: !gradientOpacity
                        ? 1
                        : bottomSheetController.percentHeight,
                    child: AnimatedContainer(
                      duration:
                          (bottomSheetController.currentHeight ==
                                  bottomSheetController.maxHeight ||
                              bottomSheetController.currentHeight ==
                                  bottomSheetController.minHeight)
                          ? animationDuration
                          : Duration.zero,
                      width: MediaQuery.of(context).size.width,
                      height: bottomSheetController.currentHeight,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: header == null
                            ? BorderRadius.vertical(
                                top: Radius.circular(radius),
                              )
                            : null,
                      ),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.zero,
                        child: draggableBody
                            ? DraggableArea(child: body)
                            : body,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
