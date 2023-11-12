class InstaMedia {
  final String mediaUrl, mediaType, caption, timestamp;
  final String? thumbnailUrl;
  final bool? isSharedToFeed;

  InstaMedia({
    this.thumbnailUrl,
    required this.mediaUrl,
    required this.caption,
    required this.mediaType,
    required this.timestamp,
    this.isSharedToFeed = false,
  });

  InstaMedia copyWith({
    String? thumbnailUrl,
    String? mediaUrl,
    String? caption,
    String? mediaType,
    bool? isSharedToFeed,
    String? timestamp,
  }) {
    return InstaMedia(
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      caption: caption ?? this.caption,
      mediaType: mediaType ?? this.mediaType,
      isSharedToFeed: isSharedToFeed ?? this.isSharedToFeed,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'thumbnail_url': thumbnailUrl,
      'media_url': mediaUrl,
      'caption': caption,
      'media_type': mediaType,
      'is_shared_to_feed': isSharedToFeed,
      'timestamp': timestamp,
    };
  }

  factory InstaMedia.fromMap(Map<String, dynamic> map) {
    return InstaMedia(
      thumbnailUrl: map['thumbnail_url'],
      mediaUrl: map['media_url'] as String,
      caption: map['caption'] as String,
      mediaType: map['media_type'] as String,
      isSharedToFeed: map['is_shared_to_feed'] ?? false,
      timestamp: map['timestamp'] as String,
    );
  }
}