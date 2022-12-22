import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

Widget positionedArrowBack(BuildContext context, Color colour) {
  return Positioned(
    top: 0.0,
    left: 9.0,
    right: 0.0,
    child: AppBar(
      leading: Row(
        children: [
          Card(
            color: colour,
            shape: ShapeBorder.lerp(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                1),
            child: IconButton(
              icon: Icon(EvaIcons.arrowBackOutline, color: Colors.grey),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}
