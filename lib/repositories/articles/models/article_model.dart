import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Articles {
  String category;
  String title;
  String content;
  String author;
  String image;
  Timestamp dateUploaded;
  Articles({
    required this.author,
    required this.category,
    required this.title,
    required this.content,
    required this.image,
    required this.dateUploaded,
  });

  Articles copyWith({
    String? author,
    String? category,
    String? title,
    String? content,
    String? image,
    Timestamp? dateUploaded,
  }) {
    return Articles(
      author: author ?? this.author,
      category: category ?? this.category,
      title: title ?? this.title,
      content: content ?? this.content,
      image: image ?? this.image,
      dateUploaded: dateUploaded ?? this.dateUploaded,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'title': title,
      'author': author,
      'content': content,
      'image': image,
      'dateUploaded': dateUploaded,
    };
  }

  factory Articles.fromMap(DocumentSnapshot map) {
    return Articles(
      category: map['category'] ?? '',
      author: map['author'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      image: map['image'] ?? '',
      dateUploaded: map['dateUploaded'] ?? Timestamp.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Articles.fromJson(String source) =>
      Articles.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Articles(author: $author,  category: $category, title: $title, content: $content, image: $image, dateUploaded: $dateUploaded)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Articles &&
        other.category == category &&
        other.author == author &&
        other.title == title &&
        other.content == content &&
        other.image == image &&
        other.dateUploaded == dateUploaded;
  }

  @override
  int get hashCode {
    return category.hashCode ^
        title.hashCode ^
        author.hashCode ^
        content.hashCode ^
        image.hashCode ^
        dateUploaded.hashCode;
  }
}
