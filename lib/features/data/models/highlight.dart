class Highlight {
  final List<int>? image;
  final String? note;

  const Highlight({
    this.image,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'note': note,
    };
  }

  factory Highlight.fromMap(Map<String, dynamic> map) {
    final List<dynamic> imageList = map['image'] ?? [];
    final List<int> image = imageList.map((e) => e as int).toList();

    return Highlight(
      image: image,
      note: map['note'],
    );
  }
}