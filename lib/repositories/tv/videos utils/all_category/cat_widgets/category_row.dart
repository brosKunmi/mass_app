import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mass_app/repositories/tv/videos%20utils/all_category/cat_widgets/category_tile.dart';
import 'package:mass_app/repositories/tv/videos%20utils/all_video/bloc/all_videos_bloc.dart';

import 'package:mass_app/utilities/extensions/string_extentions.dart';
import 'package:mass_app/utilities/widgets/utility_widgets.dart';

class VidCategoryRow extends StatelessWidget {
  const VidCategoryRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllVideosBloc, AllVideosState>(
      builder: (contexts, state) {
        if (state.status == AllVideosStatus.loading) {
          return shimshim('Loading Collections');
        } else if (state.status == AllVideosStatus.success) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                child: 'Collections'.bigBold,
              ),
              SizedBox(
                height: 200,
                child: MediaQuery.removePadding(
                  removeBottom: true,
                  removeRight: true,
                  removeLeft: true,
                  context: context,
                  child: ListView.separated(
                    shrinkWrap: true,
                    clipBehavior: Clip.none,
                    padding: const EdgeInsets.all(0),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var _cat = state.categories[index];
                      return CategoryTile(
                        cat: _cat,
                        videos: state.videos
                            .where((vid) => vid.category == _cat.catTitle)
                            .toList(),
                      );
                    },
                    itemCount: state.categories.length,
                    separatorBuilder: (_, i) {
                      return const SizedBox(width: 8);
                    },
                  ),
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
