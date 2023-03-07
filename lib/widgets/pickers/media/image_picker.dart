import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../popup_and_loaders/permission_compulsory_request_alert.dart';

Future<File?> pickImageFromGallery(
    {bool isCircleShape = false,
    bool isSquareCrop = false,
    bool isLockAspectRatio = true}) async {
  File? imageFile;

  await Permission.storage.request();
  await Permission.camera.request();
  if (await Permission.storage.request().isGranted &&
      await Permission.camera.request().isGranted) {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print("imageee${pickedFile.path}");
      imageFile = File(pickedFile.path);
      //
      ///app crashing- commented for temp///
      // return await cropImage(
      //     imageFile: imageFile,
      //     isCircleShape: isCircleShape,
      //     isSquareCrop: isSquareCrop,
      //     isLockAspectRatio: isLockAspectRatio);

    }
  } else {
    permissionCompulsoryRequestAlert(
        requestMessage:
            'App needs access to your media and camera');
  }
  print("cropImage${imageFile!.path}");
  return imageFile;
}

Future<File?> cropImage(
    {required File imageFile,
    bool isCircleShape = false,
    bool isSquareCrop = false,
    bool isLockAspectRatio = true}) async {
  CroppedFile? croppedFile;
  try {
    croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      cropStyle: isCircleShape ? CropStyle.circle : CropStyle.rectangle,
      aspectRatioPresets: isSquareCrop
          ? [
              CropAspectRatioPreset.square,
            ]
          : [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: isLockAspectRatio),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    return File(croppedFile!.path);
  } catch (e) {
    return null;
  }
}
