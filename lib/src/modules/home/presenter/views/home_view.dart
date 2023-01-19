import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:tooltips_example/src/app/common_widgets/common_tooltip.dart';
import 'package:tooltips_example/src/utils/extensions/build_context_extension.dart';

import '../../../../app/entities/tooltip_entity.dart';
import 'components/home_bottom_navigation_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final List<ToolTipEntity> toolTips;
  final isTooltipFinished = ValueNotifier<bool>(false);
  @override
  initState() {
    super.initState();
    toolTips = [
      ToolTipEntity(
        description: 'Poste seu primeiro projeto!',
        percentX: 0.45,
        percentY: 0.95,
        controller: JustTheController(),
      ),
      ToolTipEntity(
        description: 'Ajustar seu perfil!',
        percentX: 0.162,
        percentY: 0.08,
        controller: JustTheController(),
      ),
    ];
    Future.delayed(const Duration(milliseconds: 1000), () {
      toolTips.first.controller.showTooltip();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'Flutter Tooltips Example',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            actions: const [
              Icon(
                Icons.person_pin,
                color: Colors.black,
              ),
              SizedBox(width: 8),
              Icon(
                Icons.chat_bubble_outline_outlined,
                color: Colors.black,
              ),
              SizedBox(width: 8),
              Icon(
                Icons.settings_outlined,
                color: Colors.black,
              ),
              SizedBox(width: 8),
            ],
          ),
          body: Container(),
          bottomNavigationBar: const HomeBottomNavigationBar(),
        ),
        ValueListenableBuilder(
            valueListenable: isTooltipFinished,
            builder: (_, value, __) {
              return value
                  ? const SizedBox.shrink()
                  : Container(
                      color: Colors.black.withOpacity(0.3),
                    );
            }),
        ...toolTips.map(
          (e) => Positioned(
            top: context.height * e.percentY,
            right: context.width * e.percentX,
            child: CommonTooltip(
              onDismiss: () async {
                await Future.delayed(const Duration(milliseconds: 500), () {
                  e.controller.hideTooltip();
                  final index = toolTips.indexOf(e);
                  if (index < toolTips.length - 1) {
                    toolTips[index + 1].controller.showTooltip();
                  } else {
                    isTooltipFinished.value = true;
                    
                  }
                });
              },
              controller: e.controller,
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.photo_camera_outlined,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 8),
                    Text(e.description),
                  ],
                ),
              ),
              child: const SizedBox(
                width: 40,
                height: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
