import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_app/repositories/articles/bloc/articles_bloc.dart';
import 'package:mass_app/repositories/articles/models/article_category.dart';

import 'package:mass_app/repositories/articles/widgets/article_cat_tile.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';

class ArticleCatRow extends StatelessWidget {
  const ArticleCatRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> _artCats = [
      {
        'catTitle': 'Finding Home',
        'catImage': 'art_home',
        'catDesc': 'Stories of MASSians',
      },
      {
        'catTitle': 'What\'s Up',
        'catImage': 'mass_iconn',
        'catDesc': 'MASS updates and events',
      },
      {
        'catTitle': 'Good Tidings',
        'catImage': 'story',
        'catDesc': 'Testimonies from the MASS movement',
      },
      {
        'catTitle': 'Fortizo',
        'catImage': 'art_charge',
        'catDesc': 'Words to strengthen your faith',
      },
      {
        'catTitle': 'Eagle\'s Haven',
        'catImage': 'art_haven',
        'catDesc': 'Compendium of knowledge',
      }
    ];
    return BlocBuilder<ArticlesBloc, ArticlesState>(
      builder: (context, state) {
        var _allArt = state.articles;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 4),
              child: 'MASS Library'.bigBold,
            ),
            SizedBox(
              height: 200,
              child: MediaQuery.removePadding(
                removeBottom: true,
                removeRight: true,
                removeLeft: true,
                context: context,
                child: ListView.separated(
                  shrinkWrap: true,
                  clipBehavior: Clip.none,
                  padding: const EdgeInsets.all(0),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    ArticleCategory _cart =
                        ArticleCategory.fromMap(_artCats[index]);
                    return ArticleCat(
                      cart: _cart,
                      catArt: _allArt
                          .where(
                            (element) =>
                                element.category.trim() == _cart.catTitle,
                          )
                          .toList(),
                    );
                  },
                  itemCount: _artCats.length,
                  separatorBuilder: (_, i) {
                    return const SizedBox(width: 6);
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
