part of 'live_video_bloc.dart';

enum LiveStatus { initial, noLive, liveLoaded, error, loading }

class LiveVideoState extends Equatable {
  const LiveVideoState({this.status = LiveStatus.initial, String? liveId})
      : liveId = liveId ?? '';

  final String liveId;
  final LiveStatus status;

  @override
  List<Object> get props => [status, liveId];

  LiveVideoState copyWith({LiveStatus? status, String? liveId}) {
    return LiveVideoState(
      status: status ?? this.status,
      liveId: liveId ?? this.liveId,
    );
  }
}
