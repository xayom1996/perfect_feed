import 'package:apphud/apphud.dart';
import 'package:apphud/models/apphud_models/apphud_product.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'paywall_state.dart';

class PaywallCubit extends Cubit<PaywallState> {
  PaywallCubit() : super(const PaywallState());

  void init() async {
    PaywallStatus paywallStatus = await Apphud.hasActiveSubscription()
        ? PaywallStatus.subscribe
        : PaywallStatus.notSubscribe;
    emit(PaywallState(paywallStatus: paywallStatus));
  }

  void subscribe() async {
    emit(state.copyWith(
      paywallStatus: PaywallStatus.loading,
    ));

    try {
      final result = await Apphud.purchase(productId: 'Insta_Month_Trial');
      if (result.error == null) {
        emit(state.copyWith(paywallStatus: PaywallStatus.subscribe));
      } else {
        emit(state.copyWith(
          paywallStatus: PaywallStatus.error,
          errorMessage: result.error!.message,
        ));
      }
    } catch (_) {
      emit(state.copyWith(
        paywallStatus: PaywallStatus.error,
        errorMessage: _.toString().replaceAll('Exception:', ''),
      ));
    }
  }
}
