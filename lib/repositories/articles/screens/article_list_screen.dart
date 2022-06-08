import 'package:flutter/material.dart';

import 'package:mass_app/repositories/articles/models/article_model.dart';
import 'package:mass_app/repositories/articles/widgets/article_tile.dart';
import 'package:mass_app/repositories/ads/widgets/home_ad_box.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';

import 'package:mass_app/utilities/widgets/utility_widgets.dart';

import '../../ads/widgets/home_ad_box.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen(
      {Key? key, required this.articles, required this.title, this.desc})
      : super(key: key);

  final List<Articles> articles;
  final String title;
  final String? desc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: utilityAppBar(title.bigBold),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            desc?.contentText ?? const SizedBox(height: 0),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (con, i) {
                return ArticleTile(article: articles[i]);
              },
              separatorBuilder: (_, i) => const SizedBox(height: 4),
              itemCount: articles.length,
            ),
            const HomeAdBox()
          ],
        ),
      ),
    );
  }
}
