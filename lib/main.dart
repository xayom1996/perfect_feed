import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:perfect_feed/app/di/di.dart';
import 'package:perfect_feed/app/theme/app_colors.dart';
import 'package:perfect_feed/features/presentation/blocs/main/main_cubit.dart';
import 'package:perfect_feed/features/presentation/blocs/paywall/paywall_cubit.dart';
import 'package:perfect_feed/features/presentation/pages/instagram_webview_page.dart';
import 'package:perfect_feed/features/presentation/pages/main_page.dart';
import 'package:perfect_feed/features/presentation/pages/splash_page.dart';

Future<void> main() async {
  await diInit();
  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp

  ({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainCubit>(
          create: (_) => di.get<MainCubit>()..initDb(),
        ),
        BlocProvider<PaywallCubit>(
          create: (_) => di.get<PaywallCubit>()..init(),
        ),
      ],
      child: MaterialApp(
        title: 'Perfect feed',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.white,
          ),
          scaffoldBackgroundColor: AppColors.white,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
