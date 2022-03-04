import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mass_app/utilities/buttons/circular_button.dart';

import 'package:mass_app/utilities/colors%20and%20doubles/colors.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LiveYoutubeTile extends StatelessWidget {
  final String liveId;

  const LiveYoutubeTile({Key? key, required this.liveId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 200,
          alignment: Alignment.center,
          child: Image.asset('mass_tv'.png),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        Positioned(
          right: 8,
          top: 3,
          child: Text(
            'LIVE',
            style: GoogleFonts.montserrat(
                fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
        const Positioned(
          left: 8,
          top: 3,
          child: FaIcon(
            FontAwesomeIcons.volumeUp,
            size: 20,
            color: Colors.white,
          ),
        ),
        Positioned(
          bottom: 3,
          child: Column(
            children: [
              'MASS TV is live'.vidSText,
              CircularButton(
                filled: true,
                text: 'Watch',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (c) => YoutubeFullScreenPage(liveId: liveId),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class YoutubeFullScreenPage extends StatefulWidget {
  final String liveId;

  const YoutubeFullScreenPage({
    Key? key,
    required this.liveId,
  }) : super(key: key);

  @override
  State<YoutubeFullScreenPage> createState() => _YoutubeFullScreenPageState();
}

class _YoutubeFullScreenPageState extends State<YoutubeFullScreenPage> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.liveId)!,
      flags: const YoutubePlayerFlags(
        isLive: true,
        forceHD: true,
        controlsVisibleAtStart: true,
      ),
    )..toggleFullScreenMode();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    _controller.pause();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        // onExitFullScreen: () {
        //   SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        // },
        player: YoutubePlayer(
          controller: _controller,
          width: MediaQuery.of(context).size.width * 0.8,
          liveUIColor: primaryColor,
          //  aspectRatio: 10 / 9,
          // bottomActions: [
          //   const SizedBox(width: 14.0),
          //   CurrentPosition(),
          //   const SizedBox(width: 8.0),
          //   ProgressBar(
          //     isExpanded: true,
          //     controller: _controller,
          //   ),
          //   RemainingDuration(),
          //   const PlaybackSpeedButton(),
          //   FullScreenButton(),
          // ],
        ),
        builder: (BuildContext context, Widget widget) {
          return Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 16),
                  child: BackButton(
                    color: primaryColor,
                  ),
                ),
                Center(child: widget),
              ],
            ),
          );
        });
  }
}
//? needs controls
//! make full-screenable