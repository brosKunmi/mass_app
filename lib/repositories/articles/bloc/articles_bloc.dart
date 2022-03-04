import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mass_app/repositories/articles/models/article_model.dart';
import 'package:mass_app/repositories/articles/service/articles_repo.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  ArticlesBloc({required this.articleRepos}) : super(ArticlesState()) {
    on<GetArticles>(_mapGetArticlesToState);
  }

  final ArticleRepos articleRepos;

  FutureOr<void> _mapGetArticlesToState(
      GetArticles event, Emitter<ArticlesState> emit) async {
    try {
      emit(state.copyWith(status: ArticlesStatus.loading));
      await Future.delayed(const Duration(seconds: 2), () async {
        var articles = await articleRepos.getAticles();

        emit(
          state.copyWith(
            status: ArticlesStatus.loaded,
            articles: articles,
          ),
        );
      });
    } catch (e) {
      emit(state.copyWith(status: ArticlesStatus.error));
    }
  }
}
