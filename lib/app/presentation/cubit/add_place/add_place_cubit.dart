import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'add_place_state.dart';

@lazySingleton
class AddPlaceCubit extends Cubit<AddPlaceState> {
  AddPlaceCubit() : super(AddPlaceInitial());

  bool isUploading = false;
  String? imagePath;
  XFile? imageFile;

  void setImageFile(XFile? value) {
    try {
      imageFile = value;
      emit(AddImageGallerySuccessState(value ?? XFile('')));
    } catch (e) {
      emit(AddImageGalleryErrorState(e.toString()));
    }
  }

  void setImagePath(String? value) {
    try {
      imagePath = value;
      emit(AddImageCameraSuccessState(value ?? ''));
    } catch (e) {
      emit(AddImageCameraErrorState(e.toString()));
    }
  }

  void setLocation(double lat, double lon) {
    try {
      log('cubit ==> lat: $lat lon: $lon');
      emit(AddLocationSuccessState(lat, lon));
    } catch (e) {
      log('cubit ==> error: $e');
      emit(AddLocationErrorState(e.toString()));
    }
  }
}
