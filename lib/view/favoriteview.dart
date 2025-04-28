import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran6/controller/favoritecontroller.dart';
import 'package:quran6/core/constant/appfonts.dart';



class FavoriteVideosView extends StatelessWidget {
  final FavoriteVideosController favoriteController = Get.put(
    FavoriteVideosController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "الفيديوهات المفضلة",
          style: Appfonts.fonttagwal.copyWith(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        if (favoriteController.favoriteVideos.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.video_library_outlined,
                  size: 80,
                  color: Colors.grey,
                ),
                SizedBox(height: 10),
                Text(
                  "لا توجد فيديوهات مفضلة",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          itemCount: favoriteController.favoriteVideos.length,
          separatorBuilder: (context, index) => Divider(color: Colors.grey[300], thickness: 1),
          itemBuilder: (context, index) {
            var video = favoriteController.favoriteVideos[index];
            String videoName = video['nameAr'] ?? "بدون اسم";
            String videoWerd = video['werd'] ?? "";
            String videoNameEn = video['nameEn'] ?? "";
            String videopath = video['path'] ?? "";

            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white, size: 30),
              ),
              onDismissed: (direction) {
                favoriteController.favoriteVideos.removeAt(index);
                favoriteController.removeFromFavorites(videoWerd, videoNameEn);
                favoriteController.favoriteVideos.refresh();
                Get.snackbar(
                  "تم الحذف",
                  "تمت إزالة الفيديو من المفضلة",
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  onTap: () {
                    favoriteController.gotovidoeplayer(
                      videoName,
                      videoNameEn,
                      videoWerd,
                      videopath,
                    );
                  },
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.blueGrey.shade100,
                      child: const Icon(
                        Icons.video_library,
                        size: 40,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  title: Text(
                   'سورة $videoName',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    videoWerd,
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: SizedBox(),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
