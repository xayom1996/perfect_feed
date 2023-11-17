import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:perfect_feed/app/constants/app_icons.dart';
import 'package:perfect_feed/app/theme/app_colors.dart';
import 'package:perfect_feed/app/theme/app_text_styles.dart';
import 'package:perfect_feed/app/utils/utils.dart';
import 'package:perfect_feed/features/data/models/highlight.dart';
import 'package:perfect_feed/features/data/models/post.dart';
import 'package:perfect_feed/features/presentation/blocs/main/main_cubit.dart';
import 'package:perfect_feed/features/presentation/pages/add_highlight_page.dart';
import 'package:perfect_feed/features/presentation/pages/onboarding_page.dart';
import 'package:perfect_feed/features/presentation/pages/settings_page.dart';
import 'package:perfect_feed/features/presentation/widgets/add_note_bottom_sheet.dart';
import 'package:perfect_feed/features/presentation/widgets/add_post_bottom_sheet.dart';
import 'package:perfect_feed/features/presentation/widgets/add_post_button.dart';
import 'package:perfect_feed/features/presentation/widgets/highlight_container.dart';
import 'package:perfect_feed/features/presentation/widgets/post_container.dart';

enum Availability { loading, available, unavailable }

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String note = '';
  final InAppReview _inAppReview = InAppReview.instance;
  final String _appStoreId = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    (<T>(T? o) => o!)(WidgetsBinding.instance).addPostFrameCallback((_) async {
      try {
        final isAvailable = await _inAppReview.isAvailable();
        var box = await Hive.openBox('perfect_feed_box');
        if (isAvailable && box.get('review_showed') != true) {
          box.put('review_showed', true);
          _requestReview();
        }
      } catch (_) {
      }
    });
    super.didChangeDependencies();
  }

  Future<void> _requestReview() => _inAppReview.requestReview();

  Future<void> _openStoreListing() => _inAppReview.openStoreListing(
    appStoreId: _appStoreId,
  );

  void showAddPostBottomSheet(MainState mainState) {
    if (mainState.paywallStatus == PaywallStatus.subscribe || mainState.remainingQuantityPost > 0) {
      showModalBottomSheet<void>(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black.withOpacity(0.4),
        context: context,
        builder: (BuildContext context) {
          return const AddPostBottomSheet();
        },
      );
    } else {
      showAlertDialog(
        context,
        'You\'ve reached your limit',
        'Subscribe to create an unlimited number of posts',
        'Subscribe',
        (){
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OnBoardingPage(
              page: 'paywall',
            )),
          );
        },
      );
    }
  }

  Future getImage() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var imageBytes = await image.readAsBytes();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddHighlightPage(image: imageBytes)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            BlocBuilder<MainCubit, MainState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _userInfo(state),
                      _highlights(state.highlights),
                      const SizedBox(
                        height: 16,
                      ),
                      _feed(state.getPosts(), state.tabStatus),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                      ),
                    ]
                  ),
                );
              }
            ),
            BlocBuilder<MainCubit, MainState>(
              builder: (context, state) {
                return Positioned(
                  bottom: 40,
                  child: GestureDetector(
                    onTap: () {
                      showAddPostBottomSheet(state);
                    },
                    child: AddPostButton(),
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  Widget _userInfo(MainState state) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.backgroundLevel2,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 121,
                    height: 121,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(121)),
                      color: Color(0xffE6E6E6),
                      image: DecorationImage(
                        alignment: Alignment.bottomCenter,
                        image: AssetImage(
                          'assets/images/person.png',
                        )
                      )
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    state.userName.isEmpty
                        ? 'profile name'
                        : state.userName,
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Posts',
                                style: AppTextStyles.caption,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                state.posts.length.toString(),
                                style: AppTextStyles.body,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Followers',
                                style: AppTextStyles.caption,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                '-',
                                style: AppTextStyles.body,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Following',
                                style: AppTextStyles.caption,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                '-',
                                style: AppTextStyles.body,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: AppSvgAssetIcon(
                asset: AppIcons.settings,
                color: AppColors.black,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _highlights(List<Highlight> highlights) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 16,
          ),
          GestureDetector(
            onTap: getImage,
            child: Column(
              children: [
                const HighLightContainer(isAdd: true,),
              ],
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          for (var i = highlights.length - 1; i >= 0; i--)
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: HighLightContainer(
                highlight: highlights[i],
              ),
            ),
        ],
      ),
    );
  }

  Widget _feed(List<Post> posts, String tabStatus) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.read<MainCubit>().changeTabStatus('feed');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppSvgAssetIcon(
                      asset: AppIcons.feed,
                      color: tabStatus == 'feed'
                          ? AppColors.accent
                          : AppColors.blackSecondary,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.read<MainCubit>().changeTabStatus('reels');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppSvgAssetIcon(
                      asset: AppIcons.reels,
                      color: tabStatus == 'reels'
                          ? AppColors.accent
                          : AppColors.blackSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        GridView.count(
          key: ValueKey(tabStatus),
          primary: false,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          crossAxisCount: 3,
          childAspectRatio: tabStatus == 'feed'
              ? 1
              : 124/186,
          shrinkWrap: true,
          children: [
            for (var post in posts)
              PostContainer(
                post: post
              ),
          ],
        ),
      ],
    );
  }
}
