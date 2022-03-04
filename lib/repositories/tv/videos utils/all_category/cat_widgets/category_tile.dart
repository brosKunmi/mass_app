import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:mass_app/repositories/tv/tv_widgets/screens/videos_list.screen.dart';

import 'package:mass_app/repositories/tv/videos_repo/models/video_category.dart';
import 'package:mass_app/repositories/tv/videos_repo/models/video_model.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/doubles.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({Key? key, required this.cat, required this.videos})
      : super(key: key);

  final VideoCategory cat;
  final List<Video> videos;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (c) => VideosListScreen(
              vids: videos,
              title: cat.catTitle,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6.0),
        //  height: 130,
        width: 120,
        decoration: BoxDecoration(
          boxShadow: kElevationToShadow[6],
          color: Colors.white,
          borderRadius: buttonBR,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: buttonBR,
              child: ExtendedImage.network(
                cat.catImage,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: cat.catTitle.vidText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
