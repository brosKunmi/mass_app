part of 'all_videos_bloc.dart';

enum AllVideosStatus { initial, success, error, loading }

class AllVideosState extends Equatable {
  AllVideosState(
      {this.status = AllVideosStatus.initial,
      List<Video>? videos,
      List<VideoCategory>? categories,
      String? liveId})
      : videos = videos ?? [],
        categories = categories ?? [];

  final AllVideosStatus status;
  final List<Video> videos;
  final List<VideoCategory> categories;

  @override
  List<Object> get props => [status, videos, categories];

  AllVideosState copyWith({
    List<Video>? videos,
    AllVideosStatus? status,
    List<VideoCategory>? categories,
  }) {
    return AllVideosState(
        status: status ?? this.status,
        videos: videos ?? this.videos,
        categories: categories ?? this.categories);
  }
}
