part of 'paywall_cubit.dart';

enum PaywallStatus {
  init,
  loading,
  error,
  notSubscribe,
  subscribe,
}

class PaywallState extends Equatable {
  final PaywallStatus paywallStatus;
  final String errorMessage;

  const PaywallState({
    this.paywallStatus = PaywallStatus.init,
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [paywallStatus, errorMessage];

  PaywallState copyWith({
    PaywallStatus? paywallStatus,
    String? errorMessage,
  }) {
    return PaywallState(
      paywallStatus: paywallStatus ?? this.paywallStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
