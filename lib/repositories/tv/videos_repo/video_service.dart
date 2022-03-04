import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mass_app/repositories/tv/videos_repo/models/video_category.dart';
import 'package:mass_app/repositories/tv/videos_repo/models/video_model.dart';

class VideoService {
  final FirebaseFirestore _firestore;

  VideoService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<Video>> getVideos() async {
    var _vidsSnap = await _firestore
        .collection('videos')
        .orderBy('dateUploaded', descending: true)
        .get();

    List<Video> _allVids = [];

    for (var element in _vidsSnap.docs) {
      Video _vid = Video.fromMap(element);

      _allVids.add(_vid);
    }

    return _allVids;
  }

  Future<List<VideoCategory>> getCategories() async {
    var _catSnap = await _firestore.collection('video_categories').get();

    List<VideoCategory> _allCats = [];

    for (var cat in _catSnap.docs) {
      VideoCategory _cat = VideoCategory.fromMap(cat);

      _allCats.add(_cat);
    }

    return _allCats;
  }

  // Future<List<Video>> getVideosFromCat(String catTitle) async {
  //   var _vidsSnap = await _firestore
  //       .collection('videos')
  //       .where('category', isEqualTo: catTitle)
  //       .get();

  //   List<Video> _allVids = [];

  //   for (var element in _vidsSnap.docs) {
  //     Video _vid = Video.fromMap(element);

  //     _allVids.add(_vid);
  //   }

  //   return _allVids;
  // }

  Future<String?> getLiveLink() async {
    var _lives = await _firestore.collection('live').get();

    var _live = _lives.docs.first;
    String? _liveId = _live['id'];
    if (_liveId != null) {
      return _liveId;
    } else {
      return '';
    }
  }
}
