import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:perfect_feed/app/constants/app_icons.dart';
import 'package:perfect_feed/app/theme/app_colors.dart';
import 'package:perfect_feed/app/theme/app_text_styles.dart';
import 'package:perfect_feed/features/data/models/post.dart';
import 'package:perfect_feed/features/presentation/pages/post_page.dart';

class PostContainer extends StatelessWidget {
  final Post post;

  const PostContainer({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PostPage(post: post)),
        );
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundLevel2,
            //   image: post.imageUrl != null || (post.image != null && post.image!.isNotEmpty)
            //       ? DecorationImage(
            //           fit: BoxFit.cover,
            //           image: post.image != null && post.image!.isNotEmpty
            //               ? MemoryImage(
            //                   Uint8List.fromList(post.image!),
            //                 )
            //               : NetworkImage(
            //                   post.imageUrl!,
            //                 ) as ImageProvider
            //           // image:
            //         )
            //       : null,
            ),
            child: post.imageUrl == null && (post.image == null || post.image!.isEmpty)
                ? Center(
                    child: Text(
                      post.note ?? '',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.accent,
                      ),
                    ),
                  )
                : post.image != null && post.image!.isNotEmpty
                  ? Image.memory(
                      Uint8List.fromList(post.image!),
                      fit: BoxFit.cover,
                      gaplessPlayback: true,
                      width: double.infinity,
                      height: double.infinity,
                    )
                  : Image.network(
                      post.imageUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
          ),
          if (post.mediaType == 'video')
            Positioned(
              top: 8,
              right: 8,
              child: AppSvgAssetIcon(
                asset: AppIcons.reels,
                color: AppColors.white,
              ),
            ),
        ],
      ),
    );
  }
}
