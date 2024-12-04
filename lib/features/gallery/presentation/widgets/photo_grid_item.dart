import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/entities/photo.dart';

class PhotoGridItem extends StatelessWidget {
  final Photo photo;
  final VoidCallback onTap;
  final bool isSelectionMode;
  final VoidCallback? onLongPress;

  const PhotoGridItem({
    super.key,
    required this.photo,
    required this.onTap,
    this.isSelectionMode = false,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: photo.id,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  image: FileImage(File(photo.url)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          if (isSelectionMode || photo.isSelected)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: photo.isSelected
                      ? CupertinoColors.activeBlue
                      : CupertinoColors.systemGrey5.withOpacity(0.8),
                  border: Border.all(
                    color: CupertinoColors.white,
                    width: 2,
                  ),
                ),
                child: photo.isSelected
                    ? const Icon(
                        CupertinoIcons.checkmark_alt,
                        color: CupertinoColors.white,
                        size: 16,
                      )
                    : null,
              ),
            ),
        ],
      ),
    );
  }
}
