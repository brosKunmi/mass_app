import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MassEvent {
  final String image;
  final String title;
  final String date;
  final String time;
  final String venue;
  MassEvent({
    required this.image,
    required this.title,
    required this.date,
    required this.time,
    required this.venue,
  });

  MassEvent copyWith({
    String? image,
    String? title,
    String? date,
    String? time,
    String? venue,
  }) {
    return MassEvent(
      image: image ?? this.image,
      title: title ?? this.title,
      date: date ?? this.date,
      time: time ?? this.time,
      venue: venue ?? this.venue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'title': title,
      'date': date,
      'time': time,
      'venue': venue,
    };
  }

  static MassEvent empty =
      MassEvent(image: '', title: '', date: '', time: '', venue: '');

  factory MassEvent.fromMap(DocumentSnapshot map) {
    return MassEvent(
      image: map['image'] ?? '',
      title: map['title'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      venue: map['venue'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MassEvent.fromJson(String source) =>
      MassEvent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Event(image: $image, title: $title, date: $date, time: $time, venue: $venue)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MassEvent &&
        other.image == image &&
        other.title == title &&
        other.date == date &&
        other.time == time &&
        other.venue == venue;
  }

  @override
  int get hashCode {
    return image.hashCode ^
        title.hashCode ^
        date.hashCode ^
        time.hashCode ^
        venue.hashCode;
  }
}
