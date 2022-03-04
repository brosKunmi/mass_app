part of 'live_video_bloc.dart';

abstract class LiveVideoEvent extends Equatable {
  const LiveVideoEvent();

  @override
  List<Object> get props => [];
}

class GetLive extends LiveVideoEvent {}
