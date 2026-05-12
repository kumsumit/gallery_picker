import 'package:flutter/material.dart';

class BottomSheetController extends ChangeNotifier {
  BottomSheetController._();

  static final BottomSheetController instance = BottomSheetController._();

  double positionY = -1;
  int pointers = 0;
  double diff = 0;
  double bodyHeight = 0;
  double maxHeight = 500;
  double minHeight = 0;
  double currentHeight = 0;
  Color barrierColor = Colors.black54;
  Duration animationDuration = const Duration(milliseconds: 200);
  bool autoSwipped = true;
  bool fromTwoFinger = false;
  bool oneFingerScrolling = false;
  bool updated = false;
  void Function()? onHide;
  void Function()? onShow;

  bool get oneFinger => pointers == 1;

  double get percentHeight {
    if (maxHeight == 0) {
      return 0;
    }
    return (currentHeight - minHeight).abs() / maxHeight;
  }

  void updateBodyHeight(double height) {
    bodyHeight = height;
  }

  void configureSheet({
    required double maxHeight,
    required double minHeight,
    required Duration animationDuration,
    required bool autoSwipped,
    void Function()? onHide,
    void Function()? onShow,
  }) {
    this.maxHeight = maxHeight;
    this.minHeight = minHeight;
    this.animationDuration = animationDuration;
    this.autoSwipped = autoSwipped;
    this.onHide = onHide;
    this.onShow = onShow;
    if (minHeight > currentHeight) {
      currentHeight = minHeight;
    }
  }

  void startDrag(DragStartDetails details) {
    diff = 0;
    positionY = details.globalPosition.dy;
  }

  void updateDrag(DragUpdateDetails details) {
    if ((pointers == 1 && !fromTwoFinger) || updated || !oneFingerScrolling) {
      diff = positionY - details.globalPosition.dy;
      double newHeight = currentHeight + diff;
      if (newHeight > maxHeight) {
        newHeight = maxHeight;
      } else if (newHeight < minHeight) {
        newHeight = minHeight;
      }
      currentHeight = newHeight;
      positionY = details.globalPosition.dy;
      updated = true;
      notifyListeners();
    }
  }

  void addPointer() {
    pointers++;
    if (pointers == 1) {
      fromTwoFinger = false;
    }
  }

  void removePointer() {
    pointers--;
    if (pointers == 1) {
      fromTwoFinger = true;
    }
  }

  void endDrag(DragEndDetails details) {
    if (updated) {
      if (autoSwipped) {
        if (diff > 0) {
          currentHeight = maxHeight;
          onShow?.call();
        } else {
          currentHeight = minHeight;
          onHide?.call();
        }
      }
      positionY = -1;
      updated = false;
      notifyListeners();
    }
  }

  void updateHeight(double height) {
    currentHeight = height.clamp(minHeight, maxHeight);
    notifyListeners();
  }

  void open() {
    currentHeight = maxHeight;
    onShow?.call();
    notifyListeners();
  }

  void close() {
    currentHeight = minHeight;
    onHide?.call();
    notifyListeners();
  }
}
