import 'package:flutter/material.dart';

class OverlappingImages extends StatelessWidget {
  final List<String> imagePaths;

  const OverlappingImages({super.key, required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    const double diameter = 96.0;
    return SizedBox(
      height: diameter, // Set the height to match the image size
      child: LayoutBuilder(
        builder: (context, constraints) {
          final totalWidth = imagePaths.length * diameter * 0.6 + diameter * 0.3;
          final startLeft = (constraints.maxWidth - totalWidth) / 2;

          return Stack(
            children: [
              for (int i = 0; i < imagePaths.length; i++)
                Positioned(
                  left: startLeft + i * diameter * 0.6, // Calculate the overlap (30%) and center
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          blurRadius: 6, // Spread of the shadow
                          offset: const Offset(2, 2), // Position of the shadow
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: diameter / 2,
                      backgroundImage: AssetImage(imagePaths[i]),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
