import 'package:flutter/material.dart';

import 'package:mass_app/repositories/tv/videos%20utils/all_video/all_vid_widgets/video_tile.dart';
import 'package:mass_app/repositories/tv/videos_repo/models/video_model.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';
import 'package:mass_app/utilities/widgets/utility_widgets.dart';

class VideosListScreen extends StatelessWidget {
  const VideosListScreen({Key? key, required this.vids, required this.title})
      : super(key: key);

  final List<Video> vids;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: utilityAppBar(title.bigBold),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
          crossAxisCount: 2,
        ),
        itemBuilder: (con, i) {
          return VideoTile(
            video: vids[i],
          );
        },
        itemCount: vids.length,
      ),
    );
  }
}
