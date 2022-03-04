import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_app/repositories/articles/bloc/articles_bloc.dart';

import 'package:mass_app/repositories/articles/widgets/article_tile.dart';

import 'package:mass_app/utilities/extensions/string_extentions.dart';
import 'package:mass_app/utilities/widgets/utility_widgets.dart';

class HomeExploreTile extends StatelessWidget {
  const HomeExploreTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticlesBloc, ArticlesState>(
      builder: (context, state) {
        if (state.status == ArticlesStatus.loaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: 'Latest in the Library'.bigBold,
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
                      var _art = state.articles[index];
                      return ArticleTile(article: _art);
                    },
                    itemCount:
                        state.articles.length >= 3 ? 3 : state.articles.length,
                    separatorBuilder: (_, index) => const SizedBox(width: 2),
                  ),
                ),
              ),
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
