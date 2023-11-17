import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perfect_feed/app/constants/app_icons.dart';
import 'package:perfect_feed/app/theme/app_colors.dart';
import 'package:perfect_feed/app/theme/app_text_styles.dart';
import 'package:perfect_feed/app/utils/utils.dart';
import 'package:perfect_feed/features/presentation/blocs/main/main_cubit.dart';
import 'package:perfect_feed/features/presentation/pages/add_post_page.dart';
import 'package:perfect_feed/features/presentation/widgets/add_note_bottom_sheet.dart';

class AddPostBottomSheet extends StatefulWidget {
  const AddPostBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddPostBottomSheet> createState() => _AddPostBottomSheetState();
}

class _AddPostBottomSheetState extends State<AddPostBottomSheet> {
  String imageName = '';
  String note = '';
  List<int>? _image;

  Future getImage() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _image = await image.readAsBytes();
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AppPostPage(image: _image!, file: image,)),
      );
    }
  }

  Future getCameraImage() async {
    ImagePicker picker = ImagePicker();
    try {
      var image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        _image = await image.readAsBytes();
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AppPostPage(image: _image!, file: image,)),
        );
      }
    } catch(_) {
      showAlertDialog(
        context,
        'No access to the camera',
        'To give access to the camera, you need to open the settings',
        'Settings',
            (){
          Navigator.pop(context);
          AppSettings.openAppSettings(type: AppSettingsType.location);
        },
      );
    }
  }

  void showAddNoteBottomSheet() {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.4),
      context: context,
      builder: (BuildContext context) {
        return AddNoteBottomSheet(
          note: '',
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
    ).whenComplete(() {
      if (note.isNotEmpty) {
        context.read<MainCubit>().addPost([], note);
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
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
                  'Add New post',
                  style: AppTextStyles.title,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Divider(
                color: AppColors.black.withOpacity(0.1),
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: getCameraImage,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      AppSvgAssetIcon(
                        asset: AppIcons.camera,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Camera',
                        style: AppTextStyles.body,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: getImage,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      AppSvgAssetIcon(
                        asset: AppIcons.gallery,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Gallery',
                        style: AppTextStyles.body,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () {
                  showAddNoteBottomSheet();
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      AppSvgAssetIcon(
                        asset: AppIcons.pencil,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Note',
                        style: AppTextStyles.body,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
