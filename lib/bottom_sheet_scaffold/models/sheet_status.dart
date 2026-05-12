class SheetStatus {
  final double positionY;
  final double height;
  final double minHeight;
  final double maxHeight;

  const SheetStatus({
    required this.positionY,
    required this.height,
    required this.minHeight,
    required this.maxHeight,
  });

  bool get isOpened => height > minHeight;
  bool get isExpanded => height == maxHeight;
  bool get isCollapsed => height == minHeight;
}
