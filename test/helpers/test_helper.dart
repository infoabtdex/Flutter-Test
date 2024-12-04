import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dart/features/gallery/domain/repositories/gallery_repository.dart';
import 'package:dart/features/gallery/domain/entities/photo.dart';

@GenerateMocks([IGalleryRepository])
void main() {}

class MockGalleryRepository extends Mock implements IGalleryRepository {
  final List<Photo> _photos = [];

  @override
  List<Photo> getPhotos() => _photos;

  @override
  Future<void> loadPhotos() async {}

  @override
  void addPhoto(Photo photo) => _photos.add(photo);

  @override
  void deletePhoto(String id) {
    _photos.removeWhere((photo) => photo.id == id);
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
  Future<void> cachePhotos() async {}
}

Widget createTestableWidget(Widget child) {
  return MaterialApp(
    home: Material(
      child: child,
    ),
  );
}
