part of 'all_videos_bloc.dart';

abstract class AllVidoesEvent extends Equatable {
  const AllVidoesEvent();

  @override
  List<Object> get props => [];
}

class GetVideos extends AllVidoesEvent {}
