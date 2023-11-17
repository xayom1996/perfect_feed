import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:perfect_feed/app/theme/app_colors.dart';
import 'package:perfect_feed/app/theme/app_text_styles.dart';
import 'package:perfect_feed/features/presentation/blocs/paywall/paywall_cubit.dart';
import 'package:perfect_feed/features/presentation/pages/instagram_webview_page.dart';
import 'package:perfect_feed/features/presentation/pages/main_page.dart';
import 'package:perfect_feed/features/presentation/widgets/custom_button.dart';

class OnBoardingPage extends StatefulWidget {
  final String? page;
  const OnBoardingPage({Key? key, this.page}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentIndex = 0;
  final PageController pageController = PageController();

  @override
  void didChangeDependencies() async {
    var box = await Hive.openBox('perfect_feed_box');
    box.put('onboarding_showed', true);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PageView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                children: [
                  if (widget.page == null)
                    OnBoardingItemPage(
                      title: 'create the perfect feed',
                      index: 1,
                      buttonTitle: 'Next',
                      onTap: () {
                        pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                    ),
                  if (widget.page == null)
                    OnBoardingItemPage(
                      title: 'write a note for a new publication',
                      index: 2,
                      buttonTitle: 'Next',
                      onTap: () {
                        pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                    ),
                  if (widget.page == null || widget.page == 'paywall')
                    BlocBuilder<PaywallCubit, PaywallState>(
                      builder: (context, state) {
                        return OnBoardingItemPage(
                          title: 'unlock all app features',
                          index: 3,
                          buttonTitle: 'Unlock',
                          onTap: () {
                            if (widget.page == 'paywall') {
                              Navigator.pop(context);
                            } else {
                              pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            }
                          },
                        );
                      }
                    ),
                  if (widget.page == null || widget.page == 'instagram')
                    OnBoardingItemPage(
                      title: 'Login to get started',
                      index: 4,
                      buttonTitle: 'Login with Instagram',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const InstagramAPIWebView()),
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardingItemPage extends StatelessWidget {
  final int index;
  final String title;
  final String buttonTitle;
  final Function() onTap;

  const OnBoardingItemPage(
      {Key? key,
      required this.onTap,
      required this.index,
      required this.title,
      required this.buttonTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/images/onboarding_$index.jpg',
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
        ),
        Column(
          children: [
            const Spacer(),
            if (index == 3) ... [
              Text(
                'Just for \$8.99/month',
                style: AppTextStyles.headline.copyWith(
                  color: AppColors.black,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                title.toUpperCase(),
                textAlign: TextAlign.center,
                style: AppTextStyles.title.copyWith(
                  fontSize: 32,
                  color: AppColors.accent,
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomButton(
                title: buttonTitle.toUpperCase(),
                onTap: onTap,
              ),
            ),
            if (index == 3) ... [
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: Text(
                        'Privacy Policy',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.blackSecondary
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        'Restore',
                        style: AppTextStyles.caption.copyWith(
                            color: AppColors.blackSecondary
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        'Terms of Use',
                        style: AppTextStyles.caption.copyWith(
                            color: AppColors.blackSecondary
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(
              height: index == 3
                  ? 20
                  : 60,
            ),
          ],
        ),
        if (index == 3)
          Positioned(
            top: 46,
            right: 16,
            child: IconButton(
              icon: Icon(
                Icons.close,
                size: 26,
                color: AppColors.blackSecondary,
              ),
              onPressed: onTap,
            ),
          ),
        if (index == 4)
          Positioned(
            top: 60,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
              child: Text(
                'SKIP',
                style: AppTextStyles.body.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white
                ),
              ),
            ),
          ),
      ],
    );
  }
}
