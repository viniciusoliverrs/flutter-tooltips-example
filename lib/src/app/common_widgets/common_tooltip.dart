import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class CommonTooltip extends StatefulWidget {
  final JustTheController controller;
  final Widget child;
  final Widget content;
  final Function() onDismiss;
  const CommonTooltip({
    Key? key,
    required this.controller,
    required this.child,
    required this.content,
    required this.onDismiss,
  }) : super(key: key);

  @override
  State<CommonTooltip> createState() => _CommonTooltipState();
}

class _CommonTooltipState extends State<CommonTooltip> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      barrierDismissible: false,
      onDismiss: widget.onDismiss,
      controller: widget.controller,
      content: widget.content,
      child: widget.child,
    );
  }
}
