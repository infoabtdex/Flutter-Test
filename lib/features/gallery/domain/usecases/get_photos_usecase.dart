import '../entities/photo.dart';
import '../repositories/gallery_repository.dart';

class GetPhotosUseCase {
  final IGalleryRepository repository;

  GetPhotosUseCase(this.repository);

  List<Photo> call() {
    return repository.getPhotos();
  }
}
