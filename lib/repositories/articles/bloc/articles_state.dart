part of 'articles_bloc.dart';

enum ArticlesStatus { initial, loading, loaded, error }

class ArticlesState extends Equatable {
  ArticlesState({
    List<Articles>? articles,
    this.status = ArticlesStatus.initial,
  }) : articles = articles ?? [];

  final List<Articles> articles;
  final ArticlesStatus status;

  @override
  List<Object> get props => [articles, status];

  ArticlesState copyWith({List<Articles>? articles, ArticlesStatus? status}) {
    return ArticlesState(
      articles: articles ?? this.articles,
      status: status ?? this.status,
    );
  }
}
