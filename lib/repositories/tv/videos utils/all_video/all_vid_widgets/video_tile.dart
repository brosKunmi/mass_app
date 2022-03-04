import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mass_app/repositories/tv/tv_widgets/screens/video_playing_screen.dart';

import 'package:mass_app/repositories/tv/videos_repo/models/video_model.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/colors.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/doubles.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';

class VideoTile extends StatelessWidget {
  const VideoTile({Key? key, required this.video}) : super(key: key);

  final Video video;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        //   boxShadow: kElevationToShadow[6],
        color: primaryColor,
        borderRadius: otherBR,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: commonOR,
                  topRight: commonOR,
                ),
                child: ExtendedImage.network(
                  video.vidImage,
                  height: 140,
                  width: double.infinity,
                  cache: true,
                  //   color: primaryColor,
                  colorBlendMode: BlendMode.color,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => VideoPlayScreen(vid: video),
                      ),
                    );
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.play,
                    size: 20,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0, top: 4.0),
            child: video.title.vidText,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0, top: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const FaIcon(
                  FontAwesomeIcons.folder,
                  size: 10,
                  color: Colors.white,
                ),
                const SizedBox(width: 4),
                video.category.vidSText,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
