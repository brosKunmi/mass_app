class ArticleCategory {
  final String catTitle;
  final String catImage;
  final String catDesc;

  ArticleCategory({
    required this.catTitle,
    required this.catImage,
    required this.catDesc,
  });

  factory ArticleCategory.fromMap(Map<String, String> map) {
    return ArticleCategory(
      catTitle: map['catTitle'] ?? '',
      catImage: map['catImage'] ?? '',
      catDesc: map['catDesc'] ?? '',
    );
  }
}
