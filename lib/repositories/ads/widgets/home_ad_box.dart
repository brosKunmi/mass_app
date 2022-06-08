import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mass_app/repositories/ads/bloc/cubit/ads_cubit.dart';

class HomeAdBox extends StatelessWidget {
  const HomeAdBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdsCubit()..loadAds(),
      child: BlocBuilder<AdsCubit, AdsState>(
        buildWhen: ((previous, current) => current.adStatus == AdStatus.loaded),
        builder: (context, state) {
          return state.bannerAd != null
              ? Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 8.0),
                  height: 64,
                  child: AdWidget(ad: state.bannerAd!),
                )
              : const SizedBox(height: 0);
        },
      ),
    );
  }
}
