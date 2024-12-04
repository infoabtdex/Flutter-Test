import 'package:equatable/equatable.dart';
import '../../domain/entities/photo.dart';

enum GalleryStatus { initial, loading, loaded, error }

class GalleryState extends Equatable {
  final GalleryStatus status;
  final List<Photo> photos;
  final List<Photo> selectedPhotos;
  final String? error;
  final bool isSelectionMode;

  const GalleryState({
    this.status = GalleryStatus.initial,
    this.photos = const [],
    this.selectedPhotos = const [],
    this.error,
    this.isSelectionMode = false,
  });

  GalleryState copyWith({
    GalleryStatus? status,
    List<Photo>? photos,
    List<Photo>? selectedPhotos,
    String? error,
    bool? isSelectionMode,
  }) {
    return GalleryState(
      status: status ?? this.status,
      photos: photos ?? this.photos,
      selectedPhotos: selectedPhotos ?? this.selectedPhotos,
      error: error ?? this.error,
      isSelectionMode: isSelectionMode ?? this.isSelectionMode,
    );
  }

  @override
  List<Object?> get props => [
        status,
        photos,
        selectedPhotos,
        error,
        isSelectionMode,
      ];
}
