import 'package:flutter/material.dart';
import 'package:mass_app/repositories/articles/widgets/article_category_row.dart';
import 'package:mass_app/repositories/articles/widgets/article_column.dart';
import 'package:mass_app/repositories/ads/widgets/home_ad_box.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: const [
          ArticleColumn(axis: Axis.vertical),
          HomeAdBox(),
          ArticleCatRow(),
        ],
      ),
    );
  }
}
