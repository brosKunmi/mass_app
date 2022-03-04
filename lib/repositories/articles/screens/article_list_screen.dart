import 'package:flutter/material.dart';

import 'package:mass_app/repositories/articles/models/article_category.dart';
import 'package:mass_app/repositories/articles/models/article_model.dart';
import 'package:mass_app/repositories/articles/widgets/article_tile.dart';
import 'package:mass_app/repositories/ads/widgets/home_ad_box.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';

import 'package:mass_app/utilities/widgets/utility_widgets.dart';

import '../../ads/widgets/home_ad_box.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({Key? key, required this.articles, required this.cat})
      : super(key: key);

  final List<Articles> articles;
  final ArticleCategory cat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: utilityAppBar(cat.catTitle.bigBold),
      body: Column(
        children: [
          cat.catDesc.contentText,
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (con, i) {
              return ArticleTile(article: articles[i]);
            },
            separatorBuilder: (_, i) => const SizedBox(height: 4),
            itemCount: articles.length,
          ),
          const HomeAdBox()
        ],
      ),
    );
  }
}
