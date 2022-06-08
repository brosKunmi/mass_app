import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mass_app/repositories/tv/tv_widgets/screens/videos_list.screen.dart';
import 'package:mass_app/repositories/tv/videos%20utils/all_video/all_vid_widgets/video_tile.dart';
import 'package:mass_app/repositories/tv/videos%20utils/all_video/all_vids_barrel.dart';
import 'package:mass_app/repositories/tv/videos_repo/models/video_model.dart';
import 'package:mass_app/utilities/buttons/text_button.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';
import 'package:mass_app/utilities/widgets/utility_widgets.dart';

class HomeVidRow extends StatelessWidget {
  const HomeVidRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllVideosBloc, AllVideosState>(
      builder: (context, state) {
        if (state.status == AllVideosStatus.success) {
          List<Video> _recV = state.videos.sublist(0, 4);

          String _title = 'Latest on MASS TV';
          if (_recV.isEmpty) {
            return Container();
          } else {
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
                                builder: (c) => VideosListScreen(
                                    vids: _recV, title: _title),
                              ),
                            );
                          })
                    ],
                  ),
                ),
                SizedBox(
                  height: 208,
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
                      itemCount: _recV.length,
                      separatorBuilder: (_, index) => const SizedBox(width: 2),
                    ),
                  ),
                ),
              ],
            );
          }
        } else if (state.status == AllVideosStatus.loading) {
          return shimshim('Loading Videos');
        }
        return Container();
      },
    );
  }
}
