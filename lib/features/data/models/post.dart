class Post {
  final List<int>? image;
  final String? imageUrl;
  final String mediaType;
  final String? note;
  final String timestamp;
  final bool isSharedToFeed;

  const Post({
    this.image,
    this.imageUrl,
    this.note,
    this.mediaType = 'image',
    this.isSharedToFeed = false,
    required this.timestamp,
  });

  DateTime getDateTime() {
    return DateTime.parse(timestamp);
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'imageUrl': imageUrl,
      'mediaType': mediaType,
      'note': note,
      'timestamp': timestamp,
      'isSharedToFeed': isSharedToFeed,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      image: map['image'],
      imageUrl: map['imageUrl'],
      mediaType: map['mediaType'],
      note: map['note'],
      isSharedToFeed: map['isSharedToFeed'],
      timestamp: map['timestamp'],
    );
  }

  Post copyWith({
    List<int>? image,
    String? imageUrl,
    String? mediaType,
    String? note,
    bool? isSharedToFeed,
    String? timestamp,
  }) {
    return Post(
      image: image ?? this.image,
      imageUrl: imageUrl ?? this.imageUrl,
      mediaType: mediaType ?? this.mediaType,
      note: note ?? this.note,
      isSharedToFeed: isSharedToFeed ?? this.isSharedToFeed,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}