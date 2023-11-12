import 'package:flutter/material.dart';
import 'package:perfect_feed/app/constants/app_icons.dart';
import 'package:perfect_feed/app/theme/app_colors.dart';
import 'package:perfect_feed/app/theme/app_text_styles.dart';

class AddNoteButton extends StatelessWidget {
  final bool isEdit;
  const AddNoteButton({Key? key, this.isEdit = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 11),
      width: 180,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        border: Border.all(
          color: AppColors.accent,
          width: 2,
        )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppSvgAssetIcon(
            asset: AppIcons.pencil,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            isEdit == false
                ? 'Add note'
                : 'Edit note',
            style: AppTextStyles.body.copyWith(
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }
}
