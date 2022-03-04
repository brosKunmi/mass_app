import 'package:mass_app/repositories/tv/videos_repo/models/video_category.dart';
import 'package:mass_app/repositories/tv/videos_repo/models/video_model.dart';
import 'package:mass_app/repositories/tv/videos_repo/video_service.dart';

class VideosRepository {
  final VideoService videoService;

  VideosRepository({required this.videoService});

  Future<List<Video>> getVideos() async => await videoService.getVideos();

  Future<List<VideoCategory>> getCategories() async =>
      await videoService.getCategories();

  Future<String?> getLiveId() => videoService.getLiveLink();

  // Future<List<Video>> getCatVideos(String catTitle) async =>
  //     await videoService.getVideosFromCat(catTitle);
}
