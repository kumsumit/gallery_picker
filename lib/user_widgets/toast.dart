import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// showToast(String message) {
//   Fluttertoast.showToast(
//     msg: message,
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 1,
//     backgroundColor: Colors.black,
//     textColor: Colors.white,
//     fontSize: 16.0,
//   );
// }

void showErrorSnackBar(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: SlideInSnackbar(
          message: message,
          color: Colors.white,
          backgroundColor: Colors.red,
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  // Remove the snackbar after a delay
  Future.delayed(Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}

void showSnackBar(BuildContext context, String message) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: SlideInSnackbar(
          message: message,
          color: Theme.of(context).colorScheme.onPrimary,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  // Remove the snackbar after a delay
  Future.delayed(Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}

class SlideInSnackbar extends StatefulWidget {
  final String message;
  final Color color;
  final Color backgroundColor;
  const SlideInSnackbar({
    super.key,
    required this.message,
    required this.color,
    required this.backgroundColor,
  });

  @override
  SlideInSnackbarState createState() => SlideInSnackbarState();
}

class SlideInSnackbarState extends State<SlideInSnackbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..forward();
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0, -1.0),
      end: Offset(0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          widget.message,
          style: TextStyle(color: widget.color, fontSize: 16),
        ),
      ),
    );
  }
}
