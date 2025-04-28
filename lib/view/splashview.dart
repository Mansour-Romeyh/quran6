import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'package:get/instance_manager.dart';
import 'package:quran6/controller/splashcontroller.dart';
import 'package:quran6/core/constant/appfonts.dart';
import 'package:quran6/core/constant/appimgs.dart';


class Splashview extends StatelessWidget {
  const Splashview({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(Splashcontroller());
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: height / 7),
          Image.asset(Appimgs.splashimgs, fit: BoxFit.fill),
          Transform.translate(
            offset: Offset(0, -40),
            child: AnimatedTextKit(
              totalRepeatCount: 1,
              animatedTexts: [
                TypewriterAnimatedText(
                  ' الـــوٌردُ الـــيَـوْمـيِ لِـحِـفـظِ الـقُـرآن الـكـريـم مِـنْ سـورة المائدة الي سورة يونس',
                  textStyle: Appfonts.fontlogo.copyWith(fontSize: width / 15,color: Color.fromARGB(255, 22, 137, 157)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
