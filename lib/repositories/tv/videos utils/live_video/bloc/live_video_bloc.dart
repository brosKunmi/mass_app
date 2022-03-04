import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mass_app/repositories/tv/videos_repo/video_repo.dart';

part 'live_video_event.dart';
part 'live_video_state.dart';

class LiveVideoBloc extends Bloc<LiveVideoEvent, LiveVideoState> {
  LiveVideoBloc({required this.vidRep}) : super(const LiveVideoState()) {
    on<GetLive>((_mapGetLiveToState));
  }

  final VideosRepository vidRep;

  void _mapGetLiveToState(GetLive event, Emitter<LiveVideoState> emit) async {
    try {
      emit(state.copyWith(status: LiveStatus.loading));
      await Future.delayed(const Duration(seconds: 2));
      final _id = await vidRep.getLiveId();
      if (_id != '') {
        emit(
          state.copyWith(status: LiveStatus.liveLoaded, liveId: _id),
        );
      } else {
        emit(state.copyWith(status: LiveStatus.noLive));
      }
    } catch (e) {
      emit(state.copyWith(status: LiveStatus.error));
    }
  }
}
