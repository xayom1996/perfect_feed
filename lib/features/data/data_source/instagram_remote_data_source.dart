import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:perfect_feed/app/constants/constants.dart';
import 'package:perfect_feed/features/data/models/insta_media.dart';
//
class InstagramRemoteDataSource {
  final Instagram instagram = Instagram();

  InstagramRemoteDataSource();

  Future<Map<String, String>> getTokenAndUserID(String authorizationCode) async {
    /// Request token.
    /// Set token.
    /// Returning status request as bool.
    final http.Response response =
    await http.post(Uri.parse("https://api.instagram.com/oauth/access_token"), body: {
      "client_id": instagram.getClientID(),
      "redirect_uri": instagram.getRedirectUrl(),
      "client_secret": instagram.getAppSecret(),
      "code": authorizationCode,
      "grant_type": "authorization_code"
    });
    String accessToken = json.decode(response.body)['access_token'];
    String userID = json.decode(response.body)['user_id'].toString();

    return {
      'accessToken': accessToken,
      'userID': userID,
    };
  }

  Future<Map<String, String>> getUserProfile(String userID, String accessToken) async {
    /// Parse according fieldsList.
    /// Request instagram user profile.
    /// Set profile.
    /// Returning status request as bool.
    final String fields = instagram.userFields.join(',');
    final http.Response responseNode = await http.get(
        Uri.parse('https://graph.instagram.com/v18.0/${userID}?fields=${fields}&access_token=${accessToken}'));

    return {
      'id': json.decode(responseNode.body)['id'].toString(),
      'username': json.decode(responseNode.body)['username'],
      'media_count': json.decode(responseNode.body)['media_count'].toString(),
      };
  }

  Future<List<InstaMedia>> getAllMedias(String userID, String accessToken) async {
    /// Parse according fieldsList.
    /// Request instagram user medias list.
    /// Request for each media id the details.
    /// Set all medias as list Object.
    /// Returning the List<InstaMedia>.
    final String fields = instagram.mediasListFields.join(',');
    final http.Response responseMedia = await http.get(
        Uri.parse('https://graph.instagram.com/v18.0/${userID}/media?fields=${fields}&access_token=${accessToken}'));
    Map<String, dynamic> mediasList = json.decode(responseMedia.body);
    print(responseMedia.body);
    print(mediasList['data'].length);
    List<InstaMedia> medias = [];
    for (var media in mediasList['data']) {
      Map<String, dynamic> m = await getMediaDetails(media['id'], accessToken);
      m['caption'] = media['caption'];
      InstaMedia instaMedia = InstaMedia.fromMap(m);
      print(instaMedia.toMap());
      medias.add(instaMedia);
    }
    print(medias.length);
    return medias;
  }

  Future<Map<String, dynamic>> getMediaDetails(String mediaID, String accessToken) async {
    /// Parse according fieldsList.
    /// Request complete media informations.
    /// Returning the response as Map<String, dynamic>
    final String fields = instagram.mediaFields.join(',');
    final http.Response responseMediaSingle = await http.get(
        Uri.parse('https://graph.instagram.com/v18.0/${mediaID}?fields=${fields}&access_token=${accessToken}'));
    return json.decode(responseMediaSingle.body);
  }
}
//
//   Future<bool> getTokenAndUserID() async {
//     /// Request token.
//     /// Set token.
//     /// Returning status request as bool.
//     final http.Response response =
//     await http.post("https://api.instagram.com/oauth/access_token", body: {
//       "client_id": clientID,
//       "redirect_uri": redirectUri,
//       "client_secret": appSecret,
//       "code": authorizationCode,
//       "grant_type": "authorization_code"
//     });
//     accessToken = json.decode(response.body)['access_token'];
//     userID = json.decode(response.body)['user_id'].toString();
//     return (accessToken != null && userID != null) ? true : false;
//   }
//
//   Future<bool> getUserProfile() async {
//     /// Parse according fieldsList.
//     /// Request instagram user profile.
//     /// Set profile.
//     /// Returning status request as bool.
//     final String fields = userFields.join(',');
//     final http.Response responseNode = await http.get(
//         'https://graph.instagram.com/${userID}?fields=${fields}&access_token=${accessToken}');
//     instaProfile = {
//       'id': json.decode(responseNode.body)['id'].toString(),
//       'username': json.decode(responseNode.body)['username'],
//     };
//     return (instaProfile != null) ? true : false;
//   }
//
//   Future<List<InstaMedia>> getAllMedias() async {
//     /// Parse according fieldsList.
//     /// Request instagram user medias list.
//     /// Request for each media id the details.
//     /// Set all medias as list Object.
//     /// Returning the List<InstaMedia>.
//     final String fields = mediasListFields.join(',');
//     final http.Response responseMedia = await http.get(
//         'https://graph.instagram.com/${userID}/media?fields=${fields}&access_token=${accessToken}');
//     Map<String, dynamic> mediasList = json.decode(responseMedia.body);
//     medias = [];
//     await mediasList['data'].forEach((media) async {
//       // check inside db if exists (optional)
//       Map<String, dynamic> m = await getMediaDetails(media['id']);
//       InstaMedia instaMedia = InstaMedia(m);
//       medias.add(instaMedia);
//     });
//     // need delay before returning the List<InstaMedia>
//     await Future.delayed(Duration(seconds: 1), () {});
//     return medias;
//   }
//
//   Future<Map<String, dynamic>> getMediaDetails(String mediaID) async {
//     /// Parse according fieldsList.
//     /// Request complete media informations.
//     /// Returning the response as Map<String, dynamic>
//     final String fields = mediaFields.join(',');
//     final http.Response responseMediaSingle = await http.get(
//         'https://graph.instagram.com/${mediaID}?fields=${fields}&access_token=${accessToken}');
//     return json.decode(responseMediaSingle.body);
//   }
// }
