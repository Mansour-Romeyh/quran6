import 'package:get/get.dart';
import 'package:quran6/core/constant/approutes.dart';
import 'package:quran6/model/model/surahmodel.dart';



class SurahDitilsController extends GetxController {
  late List<Surahmodel> data;

  gotovidoeplayer(int index) {
    Get.toNamed(
      Approutes.videoplayer,
      arguments: {
        'nameAr': data[0].nameAr,
        'nameEn': data[0].nameEn[index],
        'werd': data[0].nameArDays[index],
        'path': data[0].path,
      },
    );
  }

  @override
  void onInit() {
    data = Get.arguments;

    super.onInit();
  }
}
