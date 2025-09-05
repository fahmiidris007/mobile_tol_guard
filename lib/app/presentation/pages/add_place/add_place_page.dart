import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_tol_guard/app/domain/entities/map_item_data.dart';
import 'package:mobile_tol_guard/app/presentation/cubit/add_place/add_place_cubit.dart';
import 'package:mobile_tol_guard/app/presentation/pages/add_place/add_location_maps_page.dart';
import 'package:mobile_tol_guard/app/presentation/pages/maps/maps_page.dart';
import 'package:mobile_tol_guard/app/presentation/widgets/base_page.dart';
import 'package:mobile_tol_guard/core/services/injection.dart';
import 'package:mobile_tol_guard/core/static_data/static_data.dart';
import 'package:mobile_tol_guard/core/util/app_theme.dart';
import 'package:mobile_tol_guard/core/util/navigation.dart';

class AddPlacePage extends StatefulWidget {
  const AddPlacePage({super.key});

  @override
  State<AddPlacePage> createState() => _AddPlacePageState();
}

class _AddPlacePageState extends State<AddPlacePage> {
  final TextEditingController _descController = TextEditingController();
  String? imagePath;
  XFile? imageFile;
  bool isUploading = false;
  double? lat;
  double? lon;

  @override
  void initState() {
    super.initState();

    setImageAndLocation();
  }

  setImageAndLocation() {
    imagePath = imagePath ?? getIt<AddPlaceCubit>().imagePath;
    imageFile = imageFile ?? getIt<AddPlaceCubit>().imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Add Place',
      body: body(),
      padding: EdgeInsets.all(24),
      appbarTrailing: isUploading
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: const CircularProgressIndicator(),
            )
          : InkWell(
              onTap: () {
                setState(() {
                  isUploading = true;
                });
                // temporary, change if backend service is ready
                Future.delayed(const Duration(seconds: 2), () {
                  setState(() {
                    isUploading = false;
                  });
                  getIt<AddPlaceCubit>().reset();
                  navigatePop(true);
                  navigateTo(MapsPage(
                    firstPlace: MapItemData(
                      id: StaticData.streetEvent.length + 1, // temporary
                      latLng: LatLng(lat ?? 0.0, lon ?? 0.0),
                      imageUrl: imagePath ?? '',
                      name: _descController.text, // temporary
                      description: _descController.text,
                    ),
                  ));
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.done,
                  color: AppTheme.black,
                ),
              ),
            ),
    );
  }

  Widget body() {
    return BlocListener(
      bloc: getIt<AddPlaceCubit>(),
      listener: (context, state) {
        if (state is AddImageGallerySuccessState) {
          setState(() {
            imageFile = state.imageFile;
          });
        } else if (state is AddImageCameraSuccessState) {
          log('image path: ${state.imagePath}');
          setState(() {
            imagePath = state.imagePath;
          });
        } else if (state is AddLocationSuccessState) {
          log('lat: ${state.lat} lon: ${state.lon}');
          setState(() {
            lat = state.lat;
            lon = state.lon;
          });
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 200,
                child: imagePath == null
                    ? const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.image,
                          size: 100,
                        ),
                      )
                    : _showImage(),
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => _onGalleryView(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                        ),
                        child: Text(
                          'Gallery',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _onCameraView(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                        child: Text(
                          'Camera',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () => _onLocationView(),
                    style: lat == null
                        ? ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                          )
                        : ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrangeAccent,
                          ),
                    child: Text(
                      lat == null ? 'Select Location' : 'Location Selected',
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  controller: _descController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Input your description location',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Error Descriptiom';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onGalleryView() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      getIt<AddPlaceCubit>().setImageFile(pickedFile);
      getIt<AddPlaceCubit>().setImagePath(pickedFile.path);
    }
  }

  _onCameraView() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      getIt<AddPlaceCubit>().setImageFile(pickedFile);
      getIt<AddPlaceCubit>().setImagePath(pickedFile.path);
    }
  }

  Widget _showImage() {
    return Image.file(
      File(imagePath.toString()),
      fit: BoxFit.contain,
    );
  }

  _onLocationView() {
    navigateTo(AddLocationMapsPage()).then((value) {
      if (value == true) {
        setState(() {});
      }
    });
  }
}
