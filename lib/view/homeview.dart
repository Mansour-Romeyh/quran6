import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran6/controller/homecontroller.dart';
import 'package:quran6/core/constant/appfonts.dart';
import 'package:quran6/view/widgets/surahlist.dart';




class Homeview extends StatelessWidget {
  const Homeview({super.key});

  @override
  Widget build(BuildContext context) {
  Homecontroller controller =  Get.put(Homecontroller());
    
    return Scaffold( appBar: AppBar(
      actions: [
        IconButton(onPressed: (){
          controller.gotofavorite();
        }, icon: Icon(Icons.favorite_border_rounded,size: 40,))
      ],
      centerTitle: false,
      title: Text('السور',style: Appfonts.fonttagwal.copyWith(fontSize: 50),),
    ) ,body: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.6/0.4),
      itemCount: controller.data.length,
      itemBuilder: (context, index) => 
    Surahlist(index: index, name_ar: "   ${controller.data[index].nameAr}", onTap: (){
      controller.gotosurahditils(index);
    })
    ,));
  }
}