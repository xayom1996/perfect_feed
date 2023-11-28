import 'dart:convert';

import 'package:apphud/apphud.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
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


  void initDb() async {
    var box = await Hive.openBox('perfect_feed_box');
    List<Highlight> highlights = [];
    List<Post> posts = [];
    String userName = '';
    int remainingQuantityPost = 5;
    if (box.containsKey('highlights')) {
      highlights = box.get('highlights').map<Highlight>((highlight) => Highlight.fromMap(jsonDecode(jsonEncode(highlight)))).toList();
    }
    if (box.containsKey('posts')) {
      posts = box.get('posts').map<Post>((post) => Post.fromMap(jsonDecode(jsonEncode(post)))).toList();
    }
    if (box.containsKey('userName')) {
      userName = box.get('userName') as String;
    }
    if (box.containsKey('remainingQuantityPost')) {
      remainingQuantityPost = box.get('remainingQuantityPost') as int;
    }
    emit(state.copyWith(
      highlights: highlights,
      posts: posts,
      userName: userName,
      remainingQuantityPost: remainingQuantityPost,
    ));
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
      List<Post> posts = [];
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
        highlights: [],
        countPost: int.parse(userProfile['media_count']!),
        userName: userProfile['username']!,
      ));
      saveToDb();
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
    int newRemainingQuantityPost = state.remainingQuantityPost - 1;
    emit(state.copyWith(posts: posts, remainingQuantityPost: newRemainingQuantityPost));
    saveToDb();
  }

  void removePost(Post post) {
    List<Post> posts = state.posts.map((e) => e).toList();
    int idx = posts.indexWhere((element) => element.image == post.image);
    posts.removeAt(idx);
    emit(state.copyWith(posts: posts));
    saveToDb();
  }

  void editPost(Post post, String note) {
    List<Post> posts = state.posts.map((e) => e).toList();
    int idx = posts.indexWhere((element) => element.image == post.image);
    Post newPost = post.copyWith(
      note: note,
    );
    posts[idx] = newPost;
    emit(state.copyWith(posts: posts));
    saveToDb();
  }

  void addHighlight(List<int> image, String note) {
    Highlight highlight = Highlight(
      image: image,
      note: note
    );
    List<Highlight> highlights = state.highlights.map((e) => e).toList();
    highlights.add(highlight);
    emit(state.copyWith(highlights: highlights));
    saveToDb();
  }

  void logout() {
    emit(const MainState().copyWith(remainingQuantityPost: state.remainingQuantityPost));
    saveToDb();
  }

  void saveToDb() async {
    var box = await Hive.openBox('perfect_feed_box');
    box.put('highlights', state.highlights.map((e) => e.toMap()).toList());
    box.put('posts', state.posts.map((e) => e.toMap()).toList());
    box.put('userName', state.userName);
    box.put('remainingQuantityPost', state.remainingQuantityPost);
  }
}
