import 'package:flutter/material.dart';
import 'package:mass_app/repositories/ads/widgets/home_ad_box.dart';

import 'package:mass_app/repositories/tv/videos%20utils/all_category/cat_barrel.dart';
import 'package:mass_app/repositories/tv/videos%20utils/all_video/all_vids_barrel.dart';
import 'package:mass_app/repositories/tv/videos%20utils/live_video/live_video_barrel.dart';

class MassTVScreen extends StatelessWidget {
  const MassTVScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          LiveVideoTile(),
          VideosTileRow(
            recon: true,
          ),
          SizedBox(height: 6),
          HomeAdBox(),
          VideosTileRow(
            recon: false,
          ),
          SizedBox(height: 6),
          HomeAdBox(),
          VidCategoryRow(),
          SizedBox(height: 12),
          HomeAdBox(),
        ],
      ),
    );
  }
}
