import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mass_app/repositories/events/models/event_model.dart';

class EventService {
  final FirebaseFirestore _firestore;

  EventService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<MassEvent> getEvent() async {
    var _eventSnap = await _firestore.collection('event').doc('upcoming').get();

    MassEvent _event = MassEvent.fromMap(_eventSnap);

    return _event;
  }

  Future<void> registerAttendee(EventAttendee attendee) async {
    await _firestore.collection('Attend').doc().set(attendee.toMap());
  }
}

class EventAttendee {
  String name;
  String email;
  String phoneNumber;
  String city;
  String school;
  String state;
  String occupation;
  bool mobile = true;
  EventAttendee({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.city,
    required this.state,
    required this.school,
    required this.occupation,
  });

  EventAttendee copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? city,
    String? state,
    String? school,
    String? occupation,
  }) {
    return EventAttendee(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
      state: state ?? this.state,
      school: school ?? this.school,
      occupation: occupation ?? this.occupation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'city': city,
      'state': state,
      'school': school,
      'occupation': occupation,
      'mobile': true
    };
  }
}
