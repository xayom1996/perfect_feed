import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:perfect_feed/features/data/models/highlight.dart';
import 'package:perfect_feed/features/data/models/insta_media.dart';
import 'package:perfect_feed/features/data/models/post.dart';
import 'package:perfect_feed/features/data/repositories/instagram_repository.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final InstagramRepository instagramRepository;
  MainCubit({required this.instagramRepository}) : super(const MainState());

  void changeTabStatus(String tabStatus) {
    emit(state.copyWith(tabStatus: tabStatus));
  }

  void getInstagramPosts(String code) async {
    try {
      Map<String, String> tokenAndUserID = await instagramRepository
          .getTokenAndUserID(code);
      Map<String, String> userProfile = await instagramRepository
          .getUserProfile(
          tokenAndUserID['userID']!, tokenAndUserID['accessToken']!);
      List<InstaMedia> medias = await instagramRepository.getAllMedias(
          tokenAndUserID['userID']!, tokenAndUserID['accessToken']!);
      List<Post> posts = state.posts.map((e) => e).toList();
      for (var media in medias) {
        posts.add(Post(
          imageUrl: media.thumbnailUrl != null
              ? media.thumbnailUrl!.replaceAll(r'\', '')
              : media.mediaUrl.replaceAll(r'\', ''),
          mediaType: media.mediaType == 'VIDEO'
              ? 'video'
              : 'image',
          note: media.caption,
          isSharedToFeed: media.isSharedToFeed ?? false,
          timestamp: media.timestamp,
        ));
      }

      emit(state.copyWith(
        mainStatus: MainStatus.auth,
        posts: posts,
        countPost: int.parse(userProfile['media_count']!),
        userName: userProfile['username']!,
      ));
    } catch (_) {
      emit(state.copyWith(
        mainStatus: MainStatus.auth,
      ));
    }
  }

  void addPost(List<int> image, String note) {
    Post post = Post(
      image: image,
      mediaType: 'image',
      note: note,
      timestamp: DateTime.now().toIso8601String(),
    );
    List<Post> posts = state.posts.map((e) => e).toList();
    posts.add(post);
    emit(state.copyWith(posts: posts));
  }

  void addHighlight(List<int> image, String note) {
    Highlight highlight = Highlight(
      image: image,
      note: note
    );
    List<Highlight> highlights = state.highlights.map((e) => e).toList();
    highlights.add(highlight);
    emit(state.copyWith(highlights: highlights));
  }
}
