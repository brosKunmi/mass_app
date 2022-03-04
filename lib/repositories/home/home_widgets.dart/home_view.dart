import 'package:flutter/material.dart';
import 'package:mass_app/repositories/events/widgets/event_tile.dart';
import 'package:mass_app/repositories/ads/widgets/home_ad_box.dart';
import 'package:mass_app/repositories/home/home_widgets.dart/home_videos_row.dart';

import '../../ads/widgets/home_ad_box.dart';
import 'home_utilities_barrel.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            HomeExploreTile(),
            HomeVidRow(),
            SizedBox(height: 12),
            HomeAdBox(),
            EventTile(),
          ],
        ),
      ),
    );
  }
}
