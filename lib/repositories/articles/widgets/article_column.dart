import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_app/repositories/articles/bloc/articles_bloc.dart';
import 'package:mass_app/repositories/articles/screens/article_list_screen.dart';
import 'package:mass_app/repositories/articles/widgets/article_tile.dart';
import 'package:mass_app/utilities/buttons/text_button.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';
import 'package:mass_app/utilities/widgets/utility_widgets.dart';

class ArticleColumn extends StatelessWidget {
  const ArticleColumn({Key? key, required this.axis}) : super(key: key);

  final Axis axis;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticlesBloc, ArticlesState>(
      builder: (context, state) {
        if (state.status == ArticlesStatus.loaded) {
          var _art = state.articles;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: 'Top Articles'.bigBold,
              ),
              MediaQuery.removePadding(
                context: context,
                removeBottom: true,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: axis,
                  physics: const NeverScrollableScrollPhysics(),
                  clipBehavior: Clip.none,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    return ArticleTile(
                      article: _art[index],
                    );
                  },
                  itemCount: _art.length >= 3 ? 3 : _art.length,
                  separatorBuilder: (_, index) => const SizedBox(height: 2),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: MassTextButton(
                    text: 'See more',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ArticleListScreen(
                            articles: _art,
                            title: 'The MASS Library',
                          ),
                        ),
                      );
                    }),
              )
            ],
          );
        } else if (state.status == ArticlesStatus.loading) {
          return shimshim('Loading Articles');
        }
        return Container();
      },
    );
  }
}
