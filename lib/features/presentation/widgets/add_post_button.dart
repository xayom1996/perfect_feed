import 'package:flutter/material.dart';
import 'package:perfect_feed/app/constants/app_icons.dart';
import 'package:perfect_feed/app/theme/app_colors.dart';
import 'package:perfect_feed/app/theme/app_text_styles.dart';

class AddPostButton extends StatelessWidget {
  const AddPostButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 11),
      width: 180,
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppSvgAssetIcon(
            asset: AppIcons.addCircle,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            'Add new post',
            style: AppTextStyles.body.copyWith(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
