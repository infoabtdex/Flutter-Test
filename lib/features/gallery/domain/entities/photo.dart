class Photo {
  final String id;
  final String url;
  final DateTime createdAt;
  final String? location;
  final int size;
  final String? title;
  final bool isSelected;

  const Photo({
    required this.id,
    required this.url,
    required this.createdAt,
    this.location,
    required this.size,
    this.title,
    this.isSelected = false,
  });

  Photo copyWith({
    String? id,
    String? url,
    DateTime? createdAt,
    String? location,
    int? size,
    String? title,
    bool? isSelected,
  }) {
    return Photo(
      id: id ?? this.id,
      url: url ?? this.url,
      createdAt: createdAt ?? this.createdAt,
      location: location ?? this.location,
      size: size ?? this.size,
      title: title ?? this.title,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
