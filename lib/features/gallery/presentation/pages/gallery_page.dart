import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/gallery_repository_impl.dart';
import '../bloc/gallery_bloc.dart';
import '../bloc/gallery_event.dart';
import '../bloc/gallery_state.dart';
import '../widgets/photo_grid.dart';
import '../../../../core/constants/app_constants.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GalleryBloc(
        repository: GalleryRepository(),
      )..add(LoadGallery()),
      child: const GalleryView(),
    );
  }
}

class GalleryView extends StatelessWidget {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryBloc, GalleryState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: CupertinoColors.systemBackground,
          appBar: AppBar(
            backgroundColor: CupertinoColors.systemBackground.withOpacity(0.9),
            elevation: 0,
            title: const Text(
              AppConstants.galleryTitle,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: _buildActions(context, state),
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  List<Widget> _buildActions(BuildContext context, GalleryState state) {
    if (state.isSelectionMode) {
      return [
        TextButton(
          onPressed: () {
            context.read<GalleryBloc>().add(
                  const ToggleSelectionMode(false),
                );
          },
          child: const Text('Cancel'),
        ),
      ];
    }
    return [
      IconButton(
        icon: const Icon(CupertinoIcons.plus_circle),
        onPressed: () {
          // TODO: Implement photo picker
        },
      ),
    ];
  }

  Widget _buildBody(BuildContext context, GalleryState state) {
    switch (state.status) {
      case GalleryStatus.initial:
      case GalleryStatus.loading:
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      case GalleryStatus.loaded:
        return PhotoGrid(
          photos: state.photos,
          isSelectionMode: state.isSelectionMode,
          onPhotoSelected: (photoId) {
            context.read<GalleryBloc>().add(
                  TogglePhotoSelection(photoId),
                );
          },
          onPhotoView: (photo) {
            context.read<GalleryBloc>().add(
                  ViewPhotoDetails(photo),
                );
          },
        );
      case GalleryStatus.error:
        return Center(
          child: Text(
            state.error ?? 'An error occurred',
            style: const TextStyle(color: CupertinoColors.destructiveRed),
          ),
        );
    }
  }
}
