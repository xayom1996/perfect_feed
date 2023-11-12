import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perfect_feed/app/constants/app_icons.dart';
import 'package:perfect_feed/app/theme/app_colors.dart';
import 'package:perfect_feed/app/theme/app_text_styles.dart';
import 'package:perfect_feed/features/presentation/pages/add_post_page.dart';

class AddNoteBottomSheet extends StatefulWidget {
  final String note;
  final Function(String) onChanged;
  const AddNoteBottomSheet({Key? key, required this.onChanged, required this.note}) : super(key: key);

  @override
  State<AddNoteBottomSheet> createState() => _AddNoteBottomSheetState();
}

class _AddNoteBottomSheetState extends State<AddNoteBottomSheet> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller = TextEditingController(text: widget.note);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          const Spacer(),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 36,
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: const BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    widget.note.isEmpty
                      ? 'Add note'
                      : 'Edit note',
                    style: AppTextStyles.title,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Divider(
                  color: AppColors.black.withOpacity(0.1),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controller,
                    maxLines: 8,
                    onChanged: widget.onChanged,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.black.withOpacity(0.1), width: 1.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.black.withOpacity(0.1), width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.black.withOpacity(0.1), width: 1.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
