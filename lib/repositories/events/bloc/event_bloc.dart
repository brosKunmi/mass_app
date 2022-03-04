import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:mass_app/repositories/events/models/event_model.dart';
import 'package:mass_app/repositories/events/service/event_repo.dart';
import 'package:mass_app/repositories/events/service/event_service.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc({required this.eventRepo}) : super(EventState()) {
    on<GetUpcomingEvent>(_mapEventToState);
    on<RegisterForEvent>(_mapResterEvent);
  }

  final MassEventRepository eventRepo;

  FutureOr<void> _mapEventToState(
    GetUpcomingEvent event,
    Emitter<EventState> emit,
  ) async {
    emit(state.copyWith(status: EventStatus.loading));

    try {
      await Future.delayed(const Duration(seconds: 2));
      var _event = await eventRepo.getEvent();

      emit(
        state.copyWith(status: EventStatus.loaded, event: _event),
      );
    } catch (e) {
      emit(state.copyWith(status: EventStatus.error));
    }
  }

  FutureOr<void> _mapResterEvent(
      RegisterForEvent event, Emitter<EventState> emit) async {
    emit(state.copyWith(status: EventStatus.loading));

    try {
      await Future.delayed(const Duration(seconds: 2));
      await eventRepo.attendEvent(event.attendee);
      emit(state.copyWith(status: EventStatus.loaded));
    } catch (e) {
      emit(state.copyWith(status: EventStatus.error));
    }
  }
}
