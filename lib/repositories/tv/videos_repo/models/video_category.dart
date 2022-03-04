import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class VideoCategory {
  String catId;
  String catTitle;
  String catImage;
  VideoCategory({
    required this.catId,
    required this.catTitle,
    required this.catImage,
  });

  VideoCategory copyWith({
    String? catId,
    String? catTitle,
    String? catImage,
  }) {
    return VideoCategory(
      catId: catId ?? this.catId,
      catTitle: catTitle ?? this.catTitle,
      catImage: catImage ?? this.catImage,
    );
  }

  factory VideoCategory.fromMap(DocumentSnapshot map) {
    return VideoCategory(
      catId: map['catId'] ?? '',
      catTitle: map['catTitle'] ?? '',
      catImage: map['catImage'] ?? '',
    );
  }

  factory VideoCategory.fromJson(String source) =>
      VideoCategory.fromMap(json.decode(source));

  @override
  String toString() =>
      'VideoCtegory(catId: $catId, catTitle: $catTitle, catImage: $catImage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VideoCategory &&
        other.catId == catId &&
        other.catTitle == catTitle &&
        other.catImage == catImage;
  }

  @override
  int get hashCode => catId.hashCode ^ catTitle.hashCode ^ catImage.hashCode;
}
