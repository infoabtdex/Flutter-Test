import 'package:flutter/material.dart';
import '../../domain/entities/photo.dart';
import 'photo_grid_item.dart';
import 'photo_details_sheet.dart';

class PhotoGrid extends StatelessWidget {
  final List<Photo> photos;
  final bool isSelectionMode;
  final Function(String)? onPhotoSelected;
  final Function(Photo)? onPhotoView;

  const PhotoGrid({
    super.key,
    required this.photos,
    this.isSelectionMode = false,
    this.onPhotoSelected,
    this.onPhotoView,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final crossAxisCount = size.width > 600 ? 4 : 3; // iPad vs iPhone layout
    const spacing = 2.0;
    const padding = 16.0;

    return GridView.builder(
      padding: const EdgeInsets.all(padding),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: spacing,
        crossAxisSpacing: spacing,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        if (index < photos.length) {
          final photo = photos[index];
          return PhotoGridItem(
            photo: photo,
            isSelectionMode: isSelectionMode,
            onTap: () {
              if (isSelectionMode) {
                onPhotoSelected?.call(photo.id);
              } else {
                _showPhotoDetails(context, photo);
              }
            },
            onLongPress: () {
              if (!isSelectionMode) {
                onPhotoSelected?.call(photo.id);
              }
            },
          );
        } else {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }
      },
      itemCount: photos.length + 1,
    );
  }

  void _showPhotoDetails(BuildContext context, Photo photo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PhotoDetailsSheet(photo: photo),
    );
  }
}
