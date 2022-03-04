part of 'ads_cubit.dart';

enum AdStatus { initial, loaded, error }

class AdsState extends Equatable {
  const AdsState(
      {this.adStatus = AdStatus.initial, this.bannerAd, this.interstitialAd});

  final BannerAd? bannerAd;
  final AdStatus adStatus;
  final InterstitialAd? interstitialAd;

  @override
  List<Object> get props => [adStatus];

  AdsState copyWith(
      {AdStatus? adStatus,
      BannerAd? bannerAd,
      InterstitialAd? interstitialAd}) {
    return AdsState(
      adStatus: adStatus ?? this.adStatus,
      interstitialAd: interstitialAd ?? this.interstitialAd,
      bannerAd: bannerAd ?? this.bannerAd,
    );
  }
}
