import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfect_feed/app/constants/app_icons.dart';
import 'package:perfect_feed/app/theme/app_colors.dart';
import 'package:perfect_feed/app/theme/app_text_styles.dart';
import 'package:perfect_feed/app/utils/utils.dart';
import 'package:perfect_feed/features/data/models/post.dart';
import 'package:perfect_feed/features/presentation/blocs/main/main_cubit.dart';
import 'package:perfect_feed/features/presentation/widgets/add_note_bottom_sheet.dart';
import 'package:perfect_feed/features/presentation/widgets/add_note_button.dart';
import 'package:perfect_feed/features/presentation/widgets/add_post_button.dart';

class PostPage extends StatefulWidget {
  final Post post;
  const PostPage({Key? key, required this.post}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String note = '';

  @override
  void initState() {
    note = widget.post.note ?? '';
    super.initState();
  }

  void showAddNoteBottomSheet() {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.4),
      context: context,
      builder: (BuildContext context) {
        return AddNoteBottomSheet(
          note: note,
          onChanged: (value) {
            setState(() {
              if (value.trim().isEmpty) {
                note = '';
              } else {
                note = value;
              }
              context.read<MainCubit>().editPost(widget.post, note);
            });
          },
        );
      },
    );
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
                /// post unsaved notification
                Navigator.pop(context);
              },
            ),
            const Spacer(),
            Text(
              'Post',
              style: AppTextStyles.title.copyWith(
                color: AppColors.black,
              ),
            ),
            const Spacer(),
            AppSvgAssetIcon(
              asset: AppIcons.trash,
              color: AppColors.accent,
              onTap: () {
                showAlertDialog(
                  context,
                  'Post deletion',
                  'The post will be deleted, do you really want to continue?',
                  'Delete', (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                    context.read<MainCubit>().removePost(widget.post);
                  },
                );
              },
            ),
          ],
        ),
        // titleSpacing: 0,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Column(
                  children: [
                    if ((widget.post.image != null && widget.post.image!.isNotEmpty)
                        || (widget.post.imageUrl != null) ) ... [
                      widget.post.imageUrl == null
                          ? Image.memory(
                              Uint8List.fromList(widget.post.image!),
                              gaplessPlayback: true,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width,
                            )
                          : Image.network(
                              widget.post.imageUrl!,
                              gaplessPlayback: true,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width,
                            )
                    ] else ... [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: AppColors.backgroundLevel2,
                        ),
                        child: Center(
                          child: Text(
                            'Note',
                            style: AppTextStyles.title.copyWith(
                              color: AppColors.accent,
                            ),
                          ),
                        ),
                      )
                    ]
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      note,
                      textAlign: TextAlign.left,
                      style: AppTextStyles.footnote,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            child: GestureDetector(
              onTap: showAddNoteBottomSheet,
              child: AddNoteButton(
                isEdit: note.isNotEmpty,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
