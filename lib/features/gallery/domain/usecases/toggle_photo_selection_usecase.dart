import '../repositories/gallery_repository.dart';

class TogglePhotoSelectionUseCase {
  final IGalleryRepository repository;

  TogglePhotoSelectionUseCase(this.repository);

  void call(String photoId) {
    repository.togglePhotoSelection(photoId);
  }
}
