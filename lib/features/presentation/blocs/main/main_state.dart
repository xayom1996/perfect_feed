part of 'main_cubit.dart';

enum MainStatus {
  init,
  auth,
  notAuth,
}



class MainState extends Equatable {
  final MainStatus mainStatus;
  final String tabStatus;
  final List<Post> posts;
  final List<Highlight> highlights;
  final String userName;
  final int countPost;
  final int remainingQuantityPost;

  const MainState({
    this.mainStatus = MainStatus.init,
    this.tabStatus = 'feed',
    this.posts = const [],
    this.highlights = const [],
    this.userName = '',
    this.countPost = 0,
    this.remainingQuantityPost = 5,
  });

  @override
  List<Object?> get props => [mainStatus, userName, countPost, tabStatus, posts, highlights, remainingQuantityPost];

  List<Post> getPosts() {
    return posts.where((element) {
      if (tabStatus == 'feed' && (element.mediaType == 'image' || element.isSharedToFeed)) {
        return true;
      }
      if (tabStatus == 'reels' && element.mediaType == 'video') {
        return true;
      }
      return false;
    }).toList()..sort(
        (a, b) => b.getDateTime().compareTo(a.getDateTime())
    );
  }

  MainState copyWith({
    MainStatus? mainStatus,
    String? tabStatus,
    List<Post>? posts,
    List<Highlight>? highlights,
    String? userName,
    int? countPost,
    int? remainingQuantityPost,
  }) {
    return MainState(
      mainStatus: mainStatus ?? this.mainStatus,
      tabStatus: tabStatus ?? this.tabStatus,
      posts: posts ?? this.posts,
      highlights: highlights ?? this.highlights,
      userName: userName ?? this.userName,
      countPost: countPost ?? this.countPost,
      remainingQuantityPost:
          remainingQuantityPost ?? this.remainingQuantityPost,
    );
  }
}
