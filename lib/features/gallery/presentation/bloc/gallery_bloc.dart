import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/gallery_repository.dart';
import '../../domain/usecases/get_photos_usecase.dart';
import '../../domain/usecases/toggle_photo_selection_usecase.dart';
import 'gallery_event.dart';
import 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final IGalleryRepository _repository;
  final GetPhotosUseCase _getPhotos;
  final TogglePhotoSelectionUseCase _toggleSelection;

  GalleryBloc({
    required IGalleryRepository repository,
  })  : _repository = repository,
        _getPhotos = GetPhotosUseCase(repository),
        _toggleSelection = TogglePhotoSelectionUseCase(repository),
        super(const GalleryState()) {
    on<LoadGallery>(_onLoadGallery);
    on<TogglePhotoSelection>(_onTogglePhotoSelection);
    on<ToggleSelectionMode>(_onToggleSelectionMode);
    on<ViewPhotoDetails>(_onViewPhotoDetails);
  }

  Future<void> _onLoadGallery(
    LoadGallery event,
    Emitter<GalleryState> emit,
  ) async {
    emit(state.copyWith(status: GalleryStatus.loading));
    try {
      await _repository.loadPhotos();
      final photos = _getPhotos();
      emit(state.copyWith(
        status: GalleryStatus.loaded,
        photos: photos,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: GalleryStatus.error,
        error: e.toString(),
      ));
    }
  }

  void _onTogglePhotoSelection(
    TogglePhotoSelection event,
    Emitter<GalleryState> emit,
  ) {
    _toggleSelection(event.photoId);
    final photos = _getPhotos();
    final selectedPhotos = _repository.getSelectedPhotos();
    emit(state.copyWith(
      photos: photos,
      selectedPhotos: selectedPhotos,
    ));
  }

  void _onToggleSelectionMode(
    ToggleSelectionMode event,
    Emitter<GalleryState> emit,
  ) {
    emit(state.copyWith(
      isSelectionMode: event.enabled,
      selectedPhotos: event.enabled ? state.selectedPhotos : [],
    ));
  }

  Future<void> _onViewPhotoDetails(
    ViewPhotoDetails event,
    Emitter<GalleryState> emit,
  ) async {
    final photo = await _repository.getPhotoDetails(event.photo.id);
    if (photo != null) {
      // Handle photo details view
    }
  }
}
