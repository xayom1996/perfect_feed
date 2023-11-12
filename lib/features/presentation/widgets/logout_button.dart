import 'package:flutter/material.dart';
import 'package:perfect_feed/app/constants/app_icons.dart';
import 'package:perfect_feed/app/theme/app_colors.dart';
import 'package:perfect_feed/app/theme/app_text_styles.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 11),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        border: Border.all(
          color: AppColors.accent,
        )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppSvgAssetIcon(
            asset: AppIcons.exit,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            'Logout',
            style: AppTextStyles.body.copyWith(
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }
}
