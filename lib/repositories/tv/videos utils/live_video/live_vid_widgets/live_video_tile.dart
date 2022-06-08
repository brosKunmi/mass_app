import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mass_app/repositories/tv/videos%20utils/live_video/live_vid_widgets/live_youtube_tile.dart';
import 'package:mass_app/repositories/tv/videos%20utils/live_video/live_vid_widgets/no_live_tile.dart';
import 'package:mass_app/repositories/tv/videos%20utils/live_video/live_video_barrel.dart';

class LiveVideoTile extends StatelessWidget {
  const LiveVideoTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveVideoBloc, LiveVideoState>(
      builder: (context, state) {
        if (state.status == LiveStatus.liveLoaded) {
          return Center(child: LiveYoutubeTile(liveId: state.liveId));
        } else if (state.status == LiveStatus.noLive) {
          return const Center(child: NoLiveTile());
        } else if (state.status == LiveStatus.error) {
          return const Center(child: NoLiveTile());
        } else if (state.status == LiveStatus.loading) {
          return const LiveLoadingSpin();
        }
        return Container();
      },
    );
  }
}
