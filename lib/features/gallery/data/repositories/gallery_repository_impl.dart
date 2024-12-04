import 'dart:io';
import 'package:photo_manager/photo_manager.dart';
import 'package:path_provider/path_provider.dart';
import '../../domain/entities/photo.dart';
import '../../domain/repositories/gallery_repository.dart';

class GalleryRepository implements IGalleryRepository {
  final List<Photo> _photos = [];
  final Map<String, File> _cachedPhotos = {};

  @override
  List<Photo> getPhotos() => List.unmodifiable(_photos);

  @override
  Future<void> loadPhotos() async {
    final permitted = await PhotoManager.requestPermissionExtend();
    if (!permitted.isAuth) return;

    final albums = await PhotoManager.getAssetPathList(type: RequestType.image);
    if (albums.isEmpty) return;

    final recentAlbum = albums.first;
    final assets = await recentAlbum.getAssetListRange(start: 0, end: 100);

    for (final asset in assets) {
      final file = await asset.file;
      if (file != null) {
        final photo = Photo(
          id: asset.id,
          url: file.path,
          createdAt: asset.createDateTime,
          size: await file.length(),
          location: await _getLocation(asset),
        );
        _photos.add(photo);
        _cachedPhotos[asset.id] = file;
      }
    }
  }

  @override
  void addPhoto(Photo photo) {
    _photos.add(photo);
  }

  @override
  void deletePhoto(String id) {
    _photos.removeWhere((photo) => photo.id == id);
    _cachedPhotos.remove(id);
  }

  @override
  void togglePhotoSelection(String id) {
    final index = _photos.indexWhere((photo) => photo.id == id);
    if (index != -1) {
      final photo = _photos[index];
      _photos[index] = photo.copyWith(isSelected: !photo.isSelected);
    }
  }

  @override
  List<Photo> getSelectedPhotos() {
    return _photos.where((photo) => photo.isSelected).toList();
  }

  @override
  Future<Photo?> getPhotoDetails(String id) async {
    return _photos.firstWhere((photo) => photo.id == id);
  }

  @override
  Future<void> cachePhotos() async {
    final cacheDir = await getTemporaryDirectory();
    for (final photo in _photos) {
      if (!_cachedPhotos.containsKey(photo.id)) {
        final file = File(photo.url);
        if (await file.exists()) {
          final cachedFile = await file.copy(
            '${cacheDir.path}/${photo.id}.jpg',
          );
          _cachedPhotos[photo.id] = cachedFile;
        }
      }
    }
  }

  Future<String?> _getLocation(AssetEntity asset) async {
    if (asset.latitude != null && asset.longitude != null) {
      // TODO: Implement reverse geocoding
      return '${asset.latitude}, ${asset.longitude}';
    }
    return null;
  }
}
