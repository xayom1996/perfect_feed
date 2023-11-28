import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfect_feed/app/constants/app_icons.dart';
import 'package:perfect_feed/app/theme/app_colors.dart';
import 'package:perfect_feed/app/theme/app_text_styles.dart';
import 'package:perfect_feed/features/presentation/blocs/main/main_cubit.dart';
import 'package:perfect_feed/features/presentation/blocs/paywall/paywall_cubit.dart';
import 'package:perfect_feed/features/presentation/pages/onboarding_page.dart';
import 'package:perfect_feed/features/presentation/widgets/logout_button.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.white,
        title: Row(
          children: [
            AppSvgAssetIcon(
              asset: AppIcons.arrowBack,
              color: AppColors.accent,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Spacer(),
            Text(
              'Settings',
              style: AppTextStyles.title.copyWith(
                color: AppColors.black,
              ),
            ),
            const Spacer(),
          ],
        ),
        // titleSpacing: 0,
      ),
      body: BlocBuilder<PaywallCubit, PaywallState>(
        builder: (context, paywallState) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  if (paywallState.paywallStatus != PaywallStatus.subscribe) ... [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const OnBoardingPage(
                            page: 'paywall',
                          )),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          image: DecorationImage(
                            alignment: Alignment.center,
                            image: AssetImage(
                              'assets/images/features_background.png',
                            )
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff1488CC),
                              Color(0xff2B32B2),
                            ],
                          )
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppSvgAssetIcon(
                              asset: AppIcons.features,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Unlock all features',
                              style: AppTextStyles.title.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        )
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                  const SizedBox(
                    height: 8,
                  ),
                  GridView.count(
                    primary: false,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    shrinkWrap: true,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await _launchUrl('https://doc-hosting.flycricket.io/threads-layout-for-instagram-terms-of-use/ff01730b-3a65-4544-a681-5175e452ad50/terms');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: AppColors.backgroundLevel2,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppSvgAssetIcon(
                                asset: AppIcons.termsOfUse,
                                color: AppColors.accent,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Terms of use',
                                style: AppTextStyles.body,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () async {
                          await _launchUrl('https://doc-hosting.flycricket.io/threads-layout-for-instagram-privacy-policy/6f756549-8dd1-42d0-9fa8-061fac0fba01/privacy');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: AppColors.backgroundLevel2,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppSvgAssetIcon(
                                asset: AppIcons.privacyPolicy,
                                color: AppColors.accent,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Privacy policy',
                                style: AppTextStyles.body,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: AppColors.backgroundLevel2,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppSvgAssetIcon(
                                asset: AppIcons.shareApp,
                                color: AppColors.accent,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Share app',
                                style: AppTextStyles.body,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () async {
                          await _launchUrl('https://8mcv1l31sbn.typeform.com/to/VzimJQ3l');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: AppColors.backgroundLevel2,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppSvgAssetIcon(
                                asset: AppIcons.support,
                                color: AppColors.accent,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Support',
                                style: AppTextStyles.body,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<MainCubit>().logout();
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const OnBoardingPage(
                          page: 'instagram',
                        )),
                      );
                    },
                    child: LogoutButton(),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
