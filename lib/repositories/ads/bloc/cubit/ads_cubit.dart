import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mass_app/repositories/ads/services/ads_service.dart';

part 'ads_state.dart';

class AdsCubit extends Cubit<AdsState> {
  AdsCubit() : super(const AdsState());

  int _instReq = 0;

  void loadAds() async {
    try {
      var _banAd = AdServices.createBan();
      await _banAd.load();
      emit(
        state.copyWith(adStatus: AdStatus.loaded, bannerAd: _banAd),
      );
    } catch (e) {
      emit(
        state.copyWith(adStatus: AdStatus.error),
      );
    }
  }

  void loadInstAds() async {
    try {
      InterstitialAd.load(
        adUnitId: AdServices.getInstUnit(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdFailedToLoad: (LoadAdError error) {
            _instReq++;
            if (_instReq <= 3) {
              loadInstAds();
            }
          },
          onAdLoaded: (InterstitialAd ad) {
            emit(
              state.copyWith(adStatus: AdStatus.loaded, interstitialAd: ad),
            );
          },
        ),
        request: AdServices.request,
      );
    } catch (e) {
      emit(
        state.copyWith(adStatus: AdStatus.error),
      );
    }
  }

  @override
  Future<void> close() {
    if (state.bannerAd != null) {
      state.bannerAd!.dispose();
    }
    if (state.interstitialAd != null) {
      state.interstitialAd!.dispose();
    }

    return super.close();
  }
}
