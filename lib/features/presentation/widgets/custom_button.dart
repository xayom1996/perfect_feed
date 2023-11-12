import 'package:flutter/material.dart';
import 'package:perfect_feed/app/theme/app_colors.dart';
import 'package:perfect_feed/app/theme/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function() onTap;

  const CustomButton({Key? key, required this.title, required this.onTap, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: AppColors.accent,
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextStyles.title.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
