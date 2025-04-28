import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran6/controller/videoplayercontroller.dart';
import 'package:quran6/core/constant/appfonts.dart';

import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final VideoController controller = Get.put(VideoController());
    double widthe = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              if (!controller.isInitialized.value) {
                return const SizedBox.shrink();
              }
              double videoDuration =
                  controller.videoController.value.duration.inSeconds.toDouble();
              return Column(
                children: [
                  Slider(
                    min: 0,
                    max: videoDuration > 0 ? videoDuration : 1,
                    value: controller.currentPosition.value.clamp(
                      0,
                      videoDuration,
                    ),
                    onChanged: (value) {
                      controller.seekToPosition(value);
                    },
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatTime(controller.currentPosition.value),
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          formatTime(videoDuration),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
            
            const SizedBox(height: 10),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => IconButton(
                    icon: Icon(
                      controller.isPlaying.value
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                      size: 60,
                    ),
                    onPressed: controller.playPause,
                  ),
                ),
                Obx(
                  () => IconButton(
                    icon: Icon(
                      controller.isLooping.value
                          ? Icons.loop
                          : Icons.loop_outlined,
                      size: 50,
                      color:
                          controller.isLooping.value
                              ? Colors.deepPurple
                              : Colors.grey,
                    ),
                    onPressed: controller.toggleLooping,
                  ),
                ),
                Obx(() {
                  bool isFavorite = controller.favoriteVideos.any(
                    (video) =>
                        video['nameAr'] == controller.nameAr &&
                        video['nameEn'] == controller.nameEn,
                  );
                  return IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 50,
                      color: isFavorite ? Colors.deepPurple : Colors.grey,
                    ),
                    onPressed: () {
                      controller.toggleFavorite();
                    },
                  );
                }),
              ],
            ),

            const SizedBox(height: 10),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("سرعة التشغيل:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                Obx(() => DropdownButton<double>(
                      value: controller.playbackSpeed.value,
                      items: controller.speedOptions.map((speed) {
                        return DropdownMenuItem(
                          value: speed,
                          child: Text("${speed}x", style: TextStyle(fontSize: 16)),
                        );
                      }).toList(),
                      onChanged: (newSpeed) {
                        if (newSpeed != null) {
                          controller.playbackSpeed.value = newSpeed;
                          controller.videoController.setPlaybackSpeed(newSpeed);
                        }
                      },
                    )),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          '${controller.werd}  من سورة ${controller.nameAr}',
          style: Appfonts.fonttagwal.copyWith(fontSize: widthe / 17,fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (!controller.isInitialized.value) {
                return Center(child: const CircularProgressIndicator());
              }
              return AspectRatio(
                aspectRatio: controller.videoController.value.aspectRatio,
                child: VideoPlayer(controller.videoController),
              );
            }),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  String formatTime(double seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds.toInt() % 60;
    return '$minutes:${secs.toString().padLeft(2, '0')}';
  }
}
