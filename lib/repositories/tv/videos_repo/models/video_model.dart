import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String videoLink;
  Timestamp dateUploaded;
  bool recommended;
  String title;
  String category;
  String vidImage;
  String vidDesc;
  Video({
    required this.videoLink,
    required this.dateUploaded,
    required this.recommended,
    required this.title,
    required this.category,
    required this.vidImage,
    required this.vidDesc,
  });

  Video copyWith({
    String? videoLink,
    Timestamp? dateUploaded,
    bool? recommended,
    String? title,
    String? category,
    String? vidImage,
    String? vidDesc,
  }) {
    return Video(
      videoLink: videoLink ?? this.videoLink,
      dateUploaded: dateUploaded ?? this.dateUploaded,
      recommended: recommended ?? this.recommended,
      title: title ?? this.title,
      category: category ?? this.category,
      vidImage: vidImage ?? this.vidImage,
      vidDesc: vidDesc ?? this.vidDesc,
    );
  }

  factory Video.fromMap(DocumentSnapshot map) {
    return Video(
      videoLink: map['videoLink'] ?? '',
      dateUploaded: map['dateUploaded'] ?? Timestamp.now(),
      recommended: map['recommended'] ?? false,
      title: map['title'] ?? '',
      category: map['category'] ?? '',
      vidImage: map['vidImage'] ?? '',
      vidDesc: map['vidDesc'] ?? '',
    );
  }

  factory Video.fromJson(String source) => Video.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VideoLink: $videoLink, dateUploaded: $dateUploaded, recommended: $recommended, title: $title, category: $category, vidImage: $vidImage, vidDesc: $vidDesc)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Video &&
        other.videoLink == videoLink &&
        other.dateUploaded == dateUploaded &&
        other.recommended == recommended &&
        other.title == title &&
        other.vidImage == vidImage &&
        other.vidDesc == vidDesc &&
        other.category == category;
  }

  @override
  int get hashCode {
    return videoLink.hashCode ^
        dateUploaded.hashCode ^
        recommended.hashCode ^
        title.hashCode ^
        vidImage.hashCode ^
        vidDesc.hashCode ^
        category.hashCode;
  }
}
