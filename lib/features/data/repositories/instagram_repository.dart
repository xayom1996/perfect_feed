import 'package:perfect_feed/features/data/data_source/instagram_remote_data_source.dart';
import 'package:perfect_feed/features/data/models/insta_media.dart';

class InstagramRepository {
  final InstagramRemoteDataSource dataSource;

  InstagramRepository({required this.dataSource});

  Future<Map<String, String>> getTokenAndUserID(String authorizationCode) async {
    return dataSource.getTokenAndUserID(authorizationCode);
  }

  Future<Map<String, String>> getUserProfile(String userID, String accessToken) async {
    return dataSource.getUserProfile(userID, accessToken);
  }

  Future<List<InstaMedia>> getAllMedias(String userID, String accessToken) async {
    return dataSource.getAllMedias(userID, accessToken);
  }
}