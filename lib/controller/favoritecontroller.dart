import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran6/core/constant/approutes.dart';




class FavoriteVideosController extends GetxController {
  final GetStorage _storage = GetStorage();
  var favoriteVideos = <Map<String, String>>[].obs; 

  @override
  void onInit() {
    super.onInit();
    
    List<dynamic>? storedFavorites = _storage.read<List<dynamic>>('favoriteVideos');
    if (storedFavorites != null) {
      favoriteVideos.value = storedFavorites
          .map((video) => Map<String, String>.from(video as Map))
          .toList();
    }
  }

  void removeFromFavorites(String videoPath, String videoNameAr) {
    favoriteVideos.removeWhere(
        (video) => video['werd'] == videoPath && video['nameAr'] == videoNameAr);
    
    _storage.write('favoriteVideos', favoriteVideos.toList());

   
    favoriteVideos.refresh();
    update();
  }
  
  gotovidoeplayer(nameAr,nameEn,werd,path) {
    Get.toNamed(
      Approutes.videoplayer,
      arguments: {
        'nameAr': nameAr,
        'nameEn': nameEn,
        'werd': werd,
        'path': path
      },
    );}
}
