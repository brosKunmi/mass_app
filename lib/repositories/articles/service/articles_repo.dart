import 'package:mass_app/repositories/articles/models/article_model.dart';
import 'package:mass_app/repositories/articles/service/article_service.dart';

class ArticleRepos {
  final ArticleService artService;

  ArticleRepos({required this.artService});

  Future<List<Articles>> getAticles() async =>
      await artService.getAllArticles();
}
