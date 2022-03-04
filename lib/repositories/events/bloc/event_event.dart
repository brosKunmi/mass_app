part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class GetUpcomingEvent extends EventEvent {}

class RegisterForEvent extends EventEvent {
  final EventAttendee attendee;

  const RegisterForEvent(this.attendee);
}
