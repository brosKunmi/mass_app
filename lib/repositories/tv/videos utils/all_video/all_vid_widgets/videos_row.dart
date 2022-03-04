import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_app/repositories/tv/tv_widgets/screens/videos_list.screen.dart';
import 'package:mass_app/repositories/tv/videos%20utils/all_video/all_vid_widgets/video_tile.dart';
import 'package:mass_app/repositories/tv/videos%20utils/all_video/bloc/all_videos_bloc.dart';

import 'package:mass_app/repositories/tv/videos_repo/models/video_model.dart';
import 'package:mass_app/utilities/buttons/text_button.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';
import 'package:mass_app/utilities/widgets/utility_widgets.dart';

class VideosTileRow extends StatelessWidget {
  const VideosTileRow({
    Key? key,
    required this.recon,
  }) : super(key: key);

  final bool recon;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllVideosBloc, AllVideosState>(
      builder: (context, state) {
        if (state.status == AllVideosStatus.success) {
          List<Video> _recV =
              state.videos.where((v) => v.recommended == recon).toList();

          String _title = recon ? 'Must Watch' : 'Trending';
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _title.bigBold,
                    const Spacer(),
                    MassTextButton(
                        text: 'See more',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (c) =>
                                  VideosListScreen(vids: _recV, title: _title),
                            ),
                          );
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                child: MediaQuery.removePadding(
                  context: context,
                  removeBottom: true,
                  removeTop: true,
                  child: ListView.separated(
                    shrinkWrap: true,
                    clipBehavior: Clip.none,
                    padding: const EdgeInsets.all(0),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return VideoTile(
                        key: ValueKey(_recV[index].videoLink),
                        video: _recV[index],
                      );
                    },
                    itemCount: _recV.length >= 5 ? 5 : _recV.length,
                    separatorBuilder: (_, index) => const SizedBox(width: 2),
                  ),
                ),
              ),
            ],
          );
        } else if (state.status == AllVideosStatus.loading) {
          return shimshim('Loading Videos');
        }
        return Container();
      },
    );
  }
}
