import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:intl/intl.dart';
import 'package:mass_app/repositories/ads/bloc/cubit/ads_cubit.dart';

import 'package:mass_app/repositories/ads/widgets/home_ad_box.dart';
import 'package:mass_app/repositories/tv/videos_repo/models/video_model.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/colors.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';
import 'package:mass_app/utilities/widgets/utility_widgets.dart';

import '../../../ads/widgets/home_ad_box.dart';

class VideoPlayScreen extends StatefulWidget {
  const VideoPlayScreen({Key? key, required this.vid}) : super(key: key);

  final Video vid;

  @override
  _VideoPlayScreenState createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  late BetterPlayerController _playerController;

  @override
  void initState() {
    super.initState();

    var playerConfig = BetterPlayerConfiguration(
      fit: BoxFit.contain,
      placeholder: Image.network(widget.vid.vidImage),
      showPlaceholderUntilPlay: true,
      fullScreenByDefault: false,
      autoDetectFullscreenDeviceOrientation: true,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
    );

    BetterPlayerDataSource betterPlayerDataSource =
        BetterPlayerDataSource.network(widget.vid.videoLink);

    _playerController = BetterPlayerController(
      playerConfig,
      betterPlayerDataSource: betterPlayerDataSource,
    );
  }

  @override
  void dispose() {
    super.dispose();

    _playerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var time = DateTime.fromMillisecondsSinceEpoch(
        widget.vid.dateUploaded.millisecondsSinceEpoch);
    String _formattedTime = DateFormat.yMMMd().format(time).toString();

    return BlocProvider<AdsCubit>(
      create: (context) => AdsCubit()..loadInstAds(),
      child: BlocConsumer<AdsCubit, AdsState>(
        listener: (context, state) {
          if (state.adStatus == AdStatus.loaded) {
            if (state.interstitialAd == null) {
              return;
            }
            state.interstitialAd!.fullScreenContentCallback =
                FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
              },
              onAdFailedToShowFullScreenContent: (ad, e) {
                ad.dispose();
              },
            );

            state.interstitialAd!.show();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: utilityAppBar(widget.vid.title.bigBold),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: BetterPlayer(
                      controller: _playerController,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.infoCircle,
                        size: 24,
                        color: primaryColor,
                      ),
                      widget.vid.vidDesc.contentText,
                    ],
                  ),
                  const SizedBox(height: 8),
                  Divider(
                    thickness: 0.8,
                    color: primaryColor,
                  ),
                  buidRow(_formattedTime, FontAwesomeIcons.calendar),
                  const SizedBox(height: 8),
                  Divider(
                    thickness: 0.8,
                    color: primaryColor,
                  ),
                  buidRow(widget.vid.category, FontAwesomeIcons.folder),
                  const SizedBox(height: 20),
                  const HomeAdBox(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buidRow(String content, IconData icon) {
  return Row(
    children: [
      FaIcon(
        icon,
        size: 24,
        color: primaryColor,
      ),
      const SizedBox(width: 8),
      content.contentText,
    ],
  );
}
