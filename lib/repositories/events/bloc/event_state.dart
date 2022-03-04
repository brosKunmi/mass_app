part of 'event_bloc.dart';

enum EventStatus { initial, loading, loaded, error }

class EventState extends Equatable {
  EventState({this.status = EventStatus.initial, MassEvent? event})
      : event = event ?? MassEvent.empty;

  final EventStatus status;
  final MassEvent event;

  @override
  List<Object> get props => [status, event];

  EventState copyWith({EventStatus? status, MassEvent? event}) {
    return EventState(
      event: event ?? this.event,
      status: status ?? this.status,
    );
  }
}
