import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import 'package:mass_app/repositories/tv/tv_widgets/screens/videos_list.screen.dart';

import 'package:mass_app/repositories/tv/videos_repo/models/video_category.dart';
import 'package:mass_app/repositories/tv/videos_repo/models/video_model.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/colors.dart';
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
        width: 150,
        decoration: BoxDecoration(
          boxShadow: kElevationToShadow[2],
          color: Colors.white,
          borderRadius: buttonBR,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            ClipRRect(
              borderRadius: buttonBR,
              child: ExtendedImage.network(
                cat.catImage,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: buttonBR,
                color: primaryColor.withOpacity(0.7),
              ),
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              child: cat.catTitle.vidText,
            ),
          ],
        ),
      ),
    );
  }
}
