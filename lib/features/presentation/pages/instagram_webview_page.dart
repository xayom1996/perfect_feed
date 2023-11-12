import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:perfect_feed/app/constants/app_icons.dart';
import 'package:perfect_feed/app/constants/constants.dart';
import 'package:http/http.dart' as http;

//
// class InstagramAPIWebView extends StatelessWidget {
//   final Function onPressedConfirmation;
//
//   const InstagramAPIWebView({Key key, this.onPressedConfirmation})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     // INIT THE INSTAGRAM CLASS
//     final Instagram instagram = Instagram();
//     // INIT THE WEBVIEW
//     final flutterWebviewPlugin = new FlutterWebviewPlugin();
//     // OPEN WEBVIEW ACCORDING TO URL GIVEN
//     flutterWebviewPlugin.launch(Instagram.url);
//     // LISTEN CHANGES
//     flutterWebviewPlugin.onUrlChanged.listen((String url) async {
//       // IF SUCCESS LOGIN
//       if (url.contains(Instagram.redirectUri)) {
//         instagram.getAuthorizationCode(url);
//         instagram.getTokenAndUserID().then((isDone) {
//           if (isDone) {
//             instagram.getUserProfile().then((isDone) {
//               instagram.getAllMedias().then((mds) {
//                 medias = mds;
//                 // NOW WE CAN CLOSE THE WEBVIEW
//                 flutterWebviewPlugin.close();
//                 // WE PUSH A NEW ROUTE FOR SELECTING OUR MEDIAS
//                 Navigator.of(context)
//                     .push(MaterialPageRoute(builder: (BuildContext ctx) {
//                   // ADDING OUR SELECTION PAGE
//                   return InstagramSelectionPage(
//                     medias: medias,
//                     onPressedConfirmation: () {
//                       // RETURNING AFTER SELECTION OUR MEDIAS LIST
//                       Navigator.of(ctx).pop();
//                       Navigator.of(context).pop(medias);
//                     },
//                   );
//                 }));
//               });
//             });
//           }
//         });
//       }
//     });
//
//     return WebviewScaffold(
//       resizeToAvoidBottomInset: true,
//       url: Instagram.url,
//       appBar: AppBar(
//         leading: IconButton(
//             icon: iBack,
//             onPressed: () {
//               Navigator.of(context).pop(medias);
//             }),
//         title: MyText(
//           data: lConnectingToInstagram,
//           fontWeight: FontWeight.bold,
//           color: white,
//         ),
//         backgroundColor: pointer,
//         elevation: 5,
//         iconTheme: IconThemeData(color: white),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:perfect_feed/app/theme/app_colors.dart';
import 'package:perfect_feed/app/theme/app_text_styles.dart';
import 'package:perfect_feed/features/data/models/insta_media.dart';
import 'package:perfect_feed/features/presentation/blocs/main/main_cubit.dart';
import 'package:perfect_feed/features/presentation/pages/main_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InstagramAPIWebView extends StatefulWidget {
  const InstagramAPIWebView({Key? key}) : super(key: key);

  @override
  _InstagramAPIWebViewState createState() => _InstagramAPIWebViewState();
}

class _InstagramAPIWebViewState extends State<InstagramAPIWebView> {
  late WebViewController controller;
  final Instagram instagram = Instagram();
  String code = '';
  bool isSuccess = false;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            print(request.url);
            print(request.url.contains('?code='));
            if (request.url.contains('?code=')) {
              setState(() {
                isSuccess = true;
              });
              context.read<MainCubit>().getInstagramPosts(getAuthorizationCode(request.url));
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(instagram.getUrl()));
    super.initState();
  }

  String getAuthorizationCode(String url) {
    return url.replaceAll('${instagram.getRedirectUrl()}?code=', '').replaceAll(
        '#_', '');
  }

  Future<bool> _onWillPop() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainCubit, MainState>(
      listener: (context, state) {
        if (state.mainStatus == MainStatus.auth) {
          while(Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MainPage()),
          );
        }
      },
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
                    Navigator.pop(context);
                  },
                ),
                const Spacer(),
                Text(
                  'Login with Instagram',
                  style: AppTextStyles.title.copyWith(
                    color: AppColors.black,
                  ),
                ),
                const Spacer(),
              ],
            ),
            // titleSpacing: 0,
          ),
          body: SafeArea(
            child: isSuccess == false
                ? WebViewWidget(controller: controller)
                : Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
