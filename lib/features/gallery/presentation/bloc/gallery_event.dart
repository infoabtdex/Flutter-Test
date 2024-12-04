import 'package:equatable/equatable.dart';
import '../../domain/entities/photo.dart';

abstract class GalleryEvent extends Equatable {
  const GalleryEvent();

  @override
  List<Object?> get props => [];
}

class LoadGallery extends GalleryEvent {}

class TogglePhotoSelection extends GalleryEvent {
  final String photoId;

  const TogglePhotoSelection(this.photoId);

  @override
  List<Object?> get props => [photoId];
}

class ToggleSelectionMode extends GalleryEvent {
  final bool enabled;

  const ToggleSelectionMode(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

class ViewPhotoDetails extends GalleryEvent {
  final Photo photo;

  const ViewPhotoDetails(this.photo);

  @override
  List<Object?> get props => [photo];
}
