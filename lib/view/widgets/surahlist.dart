import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:quran6/controller/homecontroller.dart';
import 'package:quran6/core/constant/appfonts.dart';


class Surahlist extends GetView<Homecontroller> {
  final int index;
  final String name_ar;
  final VoidCallback onTap;

  Surahlist({
    super.key,
    required this.index,
    required this.name_ar,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    controller.scrollController.addListener(() {
      controller.updateScrollOffset(
        controller.scrollController.position.pixels,
      );
    });

    return Obx(
      () => InkWell(
        onTap: onTap,
        child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 0,
                    color: const Color.fromARGB(255, 224, 223, 223),
                    offset: Offset(0, 6),
                  ),
                ],
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                name_ar,
                style: Appfonts.fontname.copyWith(fontSize: 30),
                textAlign: TextAlign.start,
              ),
            )
            .animate(
              delay: (index * (controller.isScrollingUp.value ? 0 : 20)).ms,
            )
            .slideX(
              begin: -1.0,
              end: 0,
              duration: (controller.isScrollingUp.value ? 0 : 20).ms,
              curve: Curves.easeOut,
            )
            .fade(duration: (controller.isScrollingUp.value ? 0 : 20).ms),
      ),
    );
  }
}
