import 'package:mass_app/repositories/events/models/event_model.dart';
import 'package:mass_app/repositories/events/service/event_service.dart';

class MassEventRepository {
  final EventService service;

  MassEventRepository({required this.service});

  Future<MassEvent> getEvent() async => await service.getEvent();

  Future<void> attendEvent(EventAttendee attendee) async =>
      await service.registerAttendee(attendee);
}
