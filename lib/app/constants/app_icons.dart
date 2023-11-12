import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:perfect_feed/app/theme/app_colors.dart';

class AppIcons {
  static const AppSvgAsset addCircle = AppSvgAsset('assets/icons/add-circle.svg');
  static const AppSvgAsset addCircleSecondary = AppSvgAsset('assets/icons/add-circle-secondary.svg');
  static const AppSvgAsset camera = AppSvgAsset('assets/icons/camera.svg');
  static const AppSvgAsset close = AppSvgAsset('assets/icons/close.svg');
  static const AppSvgAsset exit = AppSvgAsset('assets/icons/exit.svg');
  static const AppSvgAsset feed = AppSvgAsset('assets/icons/feed.svg');
  static const AppSvgAsset gallery = AppSvgAsset('assets/icons/gallery.svg');
  static const AppSvgAsset pencil = AppSvgAsset('assets/icons/pencil.svg');
  static const AppSvgAsset privacyPolicy = AppSvgAsset('assets/icons/privacy-policy.svg');
  static const AppSvgAsset reels = AppSvgAsset('assets/icons/reels.svg');
  static const AppSvgAsset shareApp = AppSvgAsset('assets/icons/share-app.svg');
  static const AppSvgAsset support = AppSvgAsset('assets/icons/support.svg');
  static const AppSvgAsset termsOfUse = AppSvgAsset('assets/icons/terms-of-use.svg');
  static const AppSvgAsset trash = AppSvgAsset('assets/icons/trash.svg');
  static const AppSvgAsset settings = AppSvgAsset('assets/icons/settings.svg');
  static const AppSvgAsset arrowBack = AppSvgAsset('assets/icons/arrow-back.svg');
  static const AppSvgAsset checkmark = AppSvgAsset('assets/icons/checkmark.svg');
  static const AppSvgAsset features = AppSvgAsset('assets/icons/features.svg');
}

class AppSvgAsset {
  final String path;

  const AppSvgAsset(this.path);
}

class AppSvgAssetIcon extends StatelessWidget {
  final AppSvgAsset asset;
  final Color? color;
  final double? width;
  final double? height;
  final Function()? onTap;
  final BlendMode blendMode;

  const AppSvgAssetIcon({
    required this.asset,
    Key? key,
    this.color,
    this.width,
    this.height,
    this.onTap,
    this.blendMode = BlendMode.dstIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        asset.path,
        color: color,
        width: width,
        height: height,
      ),
    );
  }
}

class AppSvgAssetImage extends AppSvgAssetIcon {
  const AppSvgAssetImage({
  required super.asset,
  Key? key,
  super.color,
  super.width,
  super.height,
}) : super(key: key);
}
