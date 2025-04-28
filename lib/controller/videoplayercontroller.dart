import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  late VideoPlayerController videoController;

  var isPlaying = false.obs;
  var isLooping = false.obs;
  var isInitialized = false.obs;
  var currentPosition = 0.0.obs;
  var playbackSpeed = 1.0.obs;
  late String path;
  late String nameAr;
  late String nameEn;
  late String werd;
  final GetStorage _storage = GetStorage();
  var favoriteVideos = <Map<String, String>>[].obs;
  final List<double> speedOptions = [0.5, 1.0, 1.5, 2.0];

  @override
  void onInit() {
    path = Get.arguments['path'];
    werd = Get.arguments['werd'];
    nameAr = Get.arguments['nameAr'];
    nameEn = Get.arguments['nameEn'];

    super.onInit();

    videoController = VideoPlayerController.asset('$path$nameEn')
      ..initialize().then((_) {
        isInitialized.value = true;
        update();
      });

    List<dynamic>? storedFavorites = _storage.read<List<dynamic>>(
      'favoriteVideos',
    );
    if (storedFavorites != null) {
      favoriteVideos.value =
          storedFavorites.map((video) => Map<String, String>.from(video as Map)).toList();
    }

    videoController.addListener(() {
      isPlaying.value = videoController.value.isPlaying;
      currentPosition.value =
          videoController.value.position.inSeconds.toDouble();
      update();
    });
  }

  void playPause() {
    if (videoController.value.isPlaying) {
      videoController.pause();
    } else {
      videoController.play();
    }
    isPlaying.value = videoController.value.isPlaying;
    update();
  }

  void toggleLooping() {
    isLooping.value = !isLooping.value;
    videoController.setLooping(isLooping.value);
    update();
  }

  bool isFavorite(String nameAr, String nameEn) {
    return favoriteVideos.any(
      (video) => video['nameAr'] == nameAr && video['nameEn'] == nameEn,
    );
  }

  void toggleFavorite() {
    Map<String, String> videoData = {
      'nameAr': nameAr,
      'nameEn': nameEn,
      'path': path,
      'werd': werd,
    };

    if (isFavorite(nameAr, nameEn)) {
      favoriteVideos.removeWhere(
        (video) => video['nameAr'] == nameAr && video['nameEn'] == nameEn,
      );
    } else {
      favoriteVideos.add(videoData);
    }

    _storage.write('favoriteVideos', favoriteVideos.toList());
    update();
  }

  void seekToPosition(double seconds) {
    videoController.seekTo(Duration(seconds: seconds.toInt()));
    currentPosition.value = seconds;
  }

  void changePlaybackSpeed() {
    int currentIndex = speedOptions.indexOf(playbackSpeed.value);
    int nextIndex = (currentIndex + 1) % speedOptions.length;
    playbackSpeed.value = speedOptions[nextIndex];
    videoController.setPlaybackSpeed(playbackSpeed.value);
    update();
  }

  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }
}
