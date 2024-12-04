import '../entities/photo.dart';

abstract class IGalleryRepository {
  List<Photo> getPhotos();
  Future<void> loadPhotos();
  void addPhoto(Photo photo);
  void deletePhoto(String id);
  void togglePhotoSelection(String id);
  List<Photo> getSelectedPhotos();
  Future<Photo?> getPhotoDetails(String id);
  Future<void> cachePhotos();
}
