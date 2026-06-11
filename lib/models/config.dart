import 'package:flutter/material.dart';

import 'mode.dart';

class Config {
  late Widget selectIcon;
  Widget? permissionDeniedPage;
  late Color backgroundColor,
      appbarColor,
      appbarIconColor,
      underlineColor,
      bottomSheetColor;
  late TextStyle textStyle,
      appbarTextStyle,
      selectedMenuStyle,
      unselectedMenuStyle;
  String recents,
      recent,
      gallery,
      lastMonth,
      lastWeek,
      tapPhotoSelect,
      selected;
  Mode mode;

  /// Corner radius used by modern (Material 3) surfaces such as thumbnails and
  /// the selection indicator. Defaults to a rounded value.
  final double borderRadius;

  /// Builds a [Config] whose default colors and text styles are derived from
  /// the ambient Material 3 [ColorScheme], so the picker matches the host
  /// app's theme (including dynamic color) out of the box.
  ///
  /// Any value passed explicitly overrides the theme-derived default, so this
  /// stays fully backward compatible with the default [Config] constructor.
  factory Config.fromTheme(
    BuildContext context, {
    Color? backgroundColor,
    Color? appbarColor,
    Color? bottomSheetColor,
    Color? appbarIconColor,
    Color? underlineColor,
    TextStyle? selectedMenuStyle,
    TextStyle? unselectedMenuStyle,
    TextStyle? textStyle,
    TextStyle? appbarTextStyle,
    Widget? permissionDeniedPage,
    String recents = "RECENTS",
    String recent = "Recent",
    String gallery = "GALLERY",
    String lastMonth = "Last Month",
    String lastWeek = "Last Week",
    String tapPhotoSelect = "Tap photo to select",
    String selected = "Selected",
    Widget? selectIcon,
    double borderRadius = 12,
  }) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme scheme = theme.colorScheme;
    final TextTheme text = theme.textTheme;
    return Config(
      mode: scheme.brightness == Brightness.dark ? Mode.dark : Mode.light,
      backgroundColor: backgroundColor ?? scheme.surface,
      appbarColor: appbarColor ?? scheme.surface,
      bottomSheetColor: bottomSheetColor ?? scheme.surfaceContainerHigh,
      appbarIconColor: appbarIconColor ?? scheme.onSurfaceVariant,
      underlineColor: underlineColor ?? scheme.primary,
      selectedMenuStyle:
          selectedMenuStyle ??
          text.titleSmall?.copyWith(color: scheme.onSurface),
      unselectedMenuStyle:
          unselectedMenuStyle ??
          text.titleSmall?.copyWith(color: scheme.onSurfaceVariant),
      textStyle:
          textStyle ??
          text.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
      appbarTextStyle:
          appbarTextStyle ??
          text.titleMedium?.copyWith(color: scheme.onSurface),
      permissionDeniedPage: permissionDeniedPage,
      recents: recents,
      recent: recent,
      gallery: gallery,
      lastMonth: lastMonth,
      lastWeek: lastWeek,
      tapPhotoSelect: tapPhotoSelect,
      selected: selected,
      borderRadius: borderRadius,
      selectIcon:
          selectIcon ??
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: scheme.primary,
            ),
            child: Icon(Icons.check, color: scheme.onPrimary),
          ),
    );
  }

  Config({
    Color? backgroundColor,
    Color? appbarColor,
    Color? bottomSheetColor,
    Color? appbarIconColor,
    Color? underlineColor,
    TextStyle? selectedMenuStyle,
    TextStyle? unselectedMenuStyle,
    TextStyle? textStyle,
    TextStyle? appbarTextStyle,
    this.permissionDeniedPage,
    this.recents = "RECENTS",
    this.recent = "Recent",
    this.gallery = "GALLERY",
    this.lastMonth = "Last Month",
    this.lastWeek = "Last Week",
    this.tapPhotoSelect = "Tap photo to select",
    this.selected = "Selected",
    this.mode = Mode.light,
    this.borderRadius = 12,
    Widget? selectIcon,
  }) {
    if (backgroundColor == null) {
      this.backgroundColor = mode == Mode.dark
          ? const Color.fromARGB(255, 18, 27, 34)
          : Colors.white;
    }
    if (appbarColor == null) {
      this.appbarColor = mode == Mode.dark
          ? const Color.fromARGB(255, 31, 44, 52)
          : Colors.white;
    }
    if (bottomSheetColor == null) {
      this.bottomSheetColor = mode == Mode.dark
          ? const Color.fromARGB(255, 31, 44, 52)
          : const Color.fromARGB(255, 247, 248, 250);
    }
    if (appbarIconColor == null) {
      this.appbarIconColor = mode == Mode.dark
          ? Colors.white
          : const Color.fromARGB(255, 130, 141, 148);
    }
    if (underlineColor == null) {
      this.underlineColor = mode == Mode.dark
          ? const Color.fromARGB(255, 6, 164, 130)
          : const Color.fromARGB(255, 20, 161, 131);
    }
    if (selectedMenuStyle == null) {
      this.selectedMenuStyle = TextStyle(
        color: mode == Mode.dark ? Colors.white : Colors.black,
      );
    }
    if (unselectedMenuStyle == null) {
      this.unselectedMenuStyle = TextStyle(
        color: mode == Mode.dark
            ? Colors.grey
            : const Color.fromARGB(255, 102, 112, 117),
      );
    }
    if (textStyle == null) {
      this.textStyle = TextStyle(
        color: mode == Mode.dark
            ? Colors.grey[300]!
            : const Color.fromARGB(255, 108, 115, 121),
        fontWeight: FontWeight.bold,
      );
    }
    if (appbarTextStyle == null) {
      this.appbarTextStyle = TextStyle(
        color: mode == Mode.dark ? Colors.white : Colors.black,
      );
    }
    this.selectIcon =
        selectIcon ??
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 0, 168, 132),
          ),
          child: const Icon(Icons.check, color: Colors.white),
        );
  }
}
