import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfect_feed/app/constants/app_icons.dart';
import 'package:perfect_feed/app/theme/app_colors.dart';
import 'package:perfect_feed/app/theme/app_text_styles.dart';
import 'package:perfect_feed/features/presentation/blocs/main/main_cubit.dart';
import 'package:perfect_feed/features/presentation/widgets/add_note_bottom_sheet.dart';
import 'package:perfect_feed/features/presentation/widgets/add_note_button.dart';
import 'package:perfect_feed/features/presentation/widgets/add_post_button.dart';

class AppPostPage extends StatefulWidget {
  final List<int> image;
  const AppPostPage({Key? key, required this.image}) : super(key: key);

  @override
  State<AppPostPage> createState() => _AppPostPageState();
}

class _AppPostPageState extends State<AppPostPage> {
  String note = '';

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
              'Photo addition',
              style: AppTextStyles.title.copyWith(
                color: AppColors.black,
              ),
            ),
            const Spacer(),
            AppSvgAssetIcon(
              asset: AppIcons.checkmark,
              color: AppColors.accent,
              onTap: () {
                context.read<MainCubit>().addPost(widget.image, note);
                Navigator.pop(context);
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
                    Image.memory(
                      Uint8List.fromList(widget.image),
                      gaplessPlayback: true,
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(24),
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
