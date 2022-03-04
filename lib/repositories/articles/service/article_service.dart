import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mass_app/repositories/articles/models/article_model.dart';

class ArticleService {
  final FirebaseFirestore _firestore;

  ArticleService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<Articles>> getAllArticles() async {
    var _allArtSnap = await _firestore
        .collection('articles')
        .orderBy('dateUploaded', descending: true)
        .get();

    List<Articles> _allArt = [];

    for (var art in _allArtSnap.docs) {
      Articles article = Articles.fromMap(art);

      _allArt.add(article);
    }

    return _allArt;
  }
}
