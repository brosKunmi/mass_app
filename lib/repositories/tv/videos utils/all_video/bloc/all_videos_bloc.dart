import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mass_app/repositories/tv/videos_repo/models/video_category.dart';

import 'package:mass_app/repositories/tv/videos_repo/models/video_model.dart';
import 'package:mass_app/repositories/tv/videos_repo/video_repo.dart';

part 'all_videos_event.dart';
part 'all_videos_state.dart';

class AllVideosBloc extends Bloc<AllVidoesEvent, AllVideosState> {
  AllVideosBloc({required this.vidRepo}) : super(AllVideosState()) {
    on<GetVideos>(_mapGetVideosToEvent);
  }

  final VideosRepository vidRepo;

  FutureOr<void> _mapGetVideosToEvent(
      GetVideos event, Emitter<AllVideosState> emit) async {
    try {
      emit(state.copyWith(status: AllVideosStatus.loading));
      await Future.delayed(const Duration(seconds: 2));
      final videos = await vidRepo.getVideos();

      final cats = await vidRepo.getCategories();

      emit(
        state.copyWith(
          status: AllVideosStatus.success,
          videos: videos,
          categories: cats,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AllVideosStatus.error),
      );
    }
  }
}
