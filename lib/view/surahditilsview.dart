import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran6/controller/surahditilscontroller.dart';
import 'package:quran6/core/constant/appfonts.dart';
import 'package:quran6/view/widgets/surahlist.dart';

class SurahDitilsView extends StatelessWidget {
  const SurahDitilsView({super.key});

  @override
  Widget build(BuildContext context) {
   SurahDitilsController controller = Get.put(SurahDitilsController());
    return Scaffold(

      appBar: AppBar(title: Text(' سورة ${controller.data[0].nameAr}',style: Appfonts.fonttagwal.copyWith(fontSize: 30,fontWeight: FontWeight.bold))),
      body: GridView.builder(

        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: controller.data[0].nameArDays.length,
        itemBuilder: (context, index) => 
      Container(
        padding: EdgeInsets.only(top: 25),
        child: Surahlist(index: index, name_ar: controller.data[0].nameArDays[index], onTap: (){
          controller.gotovidoeplayer(index);
        }),
      )
      ,),
    )
    
    ;
  }
}