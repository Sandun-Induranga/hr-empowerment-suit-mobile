import 'package:flutter/material.dart';

class PageBackground extends StatelessWidget {
  /// The [PageBackground] widget is used to add a
  /// visually appealing background to the page content.
  /// It creates a stack of positioned containers
  /// with different colors, providing a layered effect.
  /// The [body] parameter is used to specify the main
  /// content of the page.
  const PageBackground({
    super.key,
    required this.body,
  });

  final Widget body;

  @override
  Widget build(BuildContext context) {
    // Get the current brightness of the theme
    Brightness currentBrightness = Theme.of(context).brightness;

    // Determine the background color based on the theme brightness
    Color backgroundColor = currentBrightness == Brightness.dark
        ? Colors.black // Dark mode background color
        : Colors.white; // Light mode background color

    return Stack(
      children: [
        // Background container with dynamic color
        Container(
          color: backgroundColor, // Background color based on theme
          child: body, // Original body widget
        ),
      ],
    );
  }
}
