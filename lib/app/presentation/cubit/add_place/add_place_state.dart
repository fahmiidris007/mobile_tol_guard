part of 'add_place_cubit.dart';

@immutable
sealed class AddPlaceState {}

final class AddPlaceInitial extends AddPlaceState {}

final class AddPlaceLoadingState extends AddPlaceState {}

final class AddImageGallerySuccessState extends AddPlaceState {
  final XFile imageFile;
  AddImageGallerySuccessState(this.imageFile);
}

final class AddImageGalleryErrorState extends AddPlaceState {
  final String error;
  AddImageGalleryErrorState(this.error);
}

final class AddImageCameraSuccessState extends AddPlaceState {
  final String imagePath;
  AddImageCameraSuccessState(this.imagePath);
}

final class AddImageCameraErrorState extends AddPlaceState {
  final String error;
  AddImageCameraErrorState(this.error);
}

final class AddLocationSuccessState extends AddPlaceState {
  final double lat;
  final double lon;
  AddLocationSuccessState(this.lat, this.lon);
}

final class AddLocationErrorState extends AddPlaceState {
  final String error;
  AddLocationErrorState(this.error);
}
