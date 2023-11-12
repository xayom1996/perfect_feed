// import 'package:apphud/apphud.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'paywall_state.dart';

class PaywallCubit extends Cubit<PaywallState> {
  PaywallCubit() : super(PaywallInitial());

  void init() async {
    // Apphud.start(apiKey: 'app_4sY9cLggXpMDDQMmvc5wXUPGReMp8G');
    // Apphud.startManually(apiKey: 'app_4sY9cLggXpMDDQMmvc5wXUPGReMp8G');
    // print(Apphud.deviceID());
    // print(Apphud.userID());
  }
}
