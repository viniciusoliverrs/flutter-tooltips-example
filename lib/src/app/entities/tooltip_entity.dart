import 'package:just_the_tooltip/just_the_tooltip.dart';

class ToolTipEntity {
  final double percentX;
  final double percentY;
  final String description;
  final JustTheController controller;

  ToolTipEntity({
    required this.description,
    required this.percentX,
    required this.percentY,
    required this.controller,
  });
}
