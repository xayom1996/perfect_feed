import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:perfect_feed/app/constants/app_icons.dart';
import 'package:perfect_feed/app/theme/app_colors.dart';
import 'package:perfect_feed/app/theme/app_text_styles.dart';
import 'package:perfect_feed/features/data/models/highlight.dart';

class HighLightContainer extends StatelessWidget {
  final bool isAdd;
  final Highlight? highlight;

  const HighLightContainer({Key? key, this.isAdd = false, this.highlight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(72)),
            border: Border.all(
              color: isAdd || highlight != null
                  ? AppColors.accent
                  : AppColors.backgroundLevel2,
            )
          ),
          child: Center(
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(64)),
                color: AppColors.backgroundLevel2,
              ),
              child: isAdd
                  ? Center(
                      child: AppSvgAssetIcon(
                        asset: AppIcons.addCircleSecondary,
                      ),
                    )
                  : highlight != null && highlight!.image!.isNotEmpty
                    ? ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(64)),
                      child: Image.memory(
                          Uint8List.fromList(highlight!.image!),
                          gaplessPlayback: true,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                    )
                    : null,
            ),
          ),
        ),
        if (isAdd || highlight != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              width: 72,
              child: Text(
                  isAdd
                    ? 'Add new'
                    : highlight!.note!,
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.caption.copyWith(
                  color: isAdd
                      ? AppColors.accent
                      : AppColors.blackSecondary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
