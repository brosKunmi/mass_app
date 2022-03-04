import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:intl/intl.dart';

import 'package:mass_app/repositories/ads/widgets/home_ad_box.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';
import 'package:mass_app/repositories/articles/models/article_model.dart';
import 'package:mass_app/utilities/widgets/utility_widgets.dart';

import '../../ads/bloc/cubit/ads_cubit.dart';
import '../../ads/widgets/home_ad_box.dart';

class ArticleReadScreen extends StatelessWidget {
  const ArticleReadScreen({Key? key, required this.article}) : super(key: key);

  final Articles article;

  @override
  Widget build(BuildContext context) {
    var time = DateTime.fromMillisecondsSinceEpoch(
        article.dateUploaded.millisecondsSinceEpoch);
    String _formattedTime = DateFormat.yMEd().format(time).toString();
    final _tHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
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
            appBar: utilityAppBar(const Text(''), color: Colors.black),
            extendBodyBehindAppBar: true,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(24),
                      bottomLeft: Radius.circular(24),
                    ),
                    child: Hero(
                      tag: article.title,
                      child: ExtendedImage.network(
                        article.image,
                        width: double.infinity,
                        height: _tHeight * 0.4,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        article.title.artBold,
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.calendar,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            _formattedTime.profText,
                            const Spacer(),
                            const FaIcon(
                              FontAwesomeIcons.folder,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            article.category.profText,
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.userTag,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            article.author.profText,
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Divider(
                          thickness: 0.8,
                        ),
                        article.content.contentText,
                        const SizedBox(height: 20),
                        const HomeAdBox()
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
