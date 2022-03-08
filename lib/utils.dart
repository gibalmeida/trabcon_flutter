import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

const smallScreenWidth = 640.0;
const mediumScreenWidth = 1007.0;

class Utils {
  static Future<void> pickPhoto({
    required fromGallery,
    void Function(XFile file)? cropImage,
    // Future<void> Function(XFile file)? uploadImage,
  }) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera);

    if (pickedFile == null) {
      return;
    }

    if (cropImage != null) {
      cropImage(pickedFile);
      //   cropImage(pickedFile).then((croppedFile) =>
      //       croppedFile != null && uploadImage != null
      //           ? uploadImage(croppedFile)
      //           : null);
      // } else if (uploadImage != null) {
      //   uploadImage(pickedFile);
    }
  }

  static Future<XFile?> cropImage(XFile imageFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      aspectRatioPresets: [CropAspectRatioPreset.square],
      compressQuality: 70,
      compressFormat: ImageCompressFormat.jpg,
      androidUiSettings: androidUiSettingsLocked(),
      iosUiSettings: iosUiSettingsLocked(),
      cropStyle: CropStyle.circle,
    );

    if (croppedFile != null) {
      return XFile(croppedFile.path);
    }

    return null;
  }

  static IOSUiSettings iosUiSettingsLocked() => const IOSUiSettings(
        rotateClockwiseButtonHidden: false,
        rotateButtonsHidden: false,
      );

  static AndroidUiSettings androidUiSettingsLocked() => const AndroidUiSettings(
        toolbarTitle: 'Ajustar a Foto',
        toolbarColor:
            Colors.red, //TODO: Ajustar cores para o tema que for definido
        toolbarWidgetColor: Colors.white,
        hideBottomControls: false,
      );

  /// Returns the optimal width size for the width available in the container.
  ///
  /// [containerWidth] = The container maximum width available.
  /// [widthForSmallScreen], [widthForMediumScreen], [widthForLargeScreen] is the
  /// width size (in pixels or in percentage (when the value is equal or less
  /// than 1) of [containerWidth]) for Small, Medium or Large Screen Sizes
  /// respectively.
  double responsiveWidth(
    double containerWidth, {
    double widthForSmallScreen = 1,
    double? widthForMediumScreen,
    double? widthForLargeScreen,
  }) {
    double idealWidth(widthOrPercentage) {
      return widthOrPercentage <= 1
          ? (widthOrPercentage * containerWidth)
          : widthOrPercentage;
    }

    if (containerWidth <= smallScreenWidth) {
      return idealWidth(widthForSmallScreen);
    } else if (containerWidth <= mediumScreenWidth) {
      return idealWidth(widthForMediumScreen ?? widthForSmallScreen);
    } else {
      return idealWidth(
          widthForLargeScreen ?? widthForMediumScreen ?? widthForSmallScreen);
    }
  }
}
