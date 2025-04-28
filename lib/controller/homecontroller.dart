import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:quran6/core/constant/approutes.dart';
import 'package:quran6/model/data/datasurah.dart';
import 'package:quran6/model/model/surahmodel.dart';


class Homecontroller extends GetxController {
  final ScrollController scrollController = ScrollController();
  var isScrollingUp = false.obs;
  double previousOffset = 0.0;
  List<Surahmodel> data = surahList;
  void updateScrollOffset(double currentOffset) {
    isScrollingUp.value = currentOffset < previousOffset;
    previousOffset = currentOffset;
  }

  gotosurahditils(int index) {
    Get.toNamed(Approutes.surahditils, arguments: [data[index]]);
  }
  gotofavorite() {
    Get.toNamed(Approutes.favorite);
  }
}
