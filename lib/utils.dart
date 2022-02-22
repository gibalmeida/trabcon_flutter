import 'dart:io';

import 'package:image_picker/image_picker.dart';

const smallScreenWidth = 640.0;
const mediumScreenWidth = 1007.0;

class Utils {
  static Future<File?> pickPhoto({
    required fromGallery,
    Future<File?> Function(File file)? cropImage,
  }) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera);

    if (pickedFile == null) {
      return null;
    }

    if (cropImage == null) {
      return File(pickedFile.path);
    } else {
      return cropImage(File(pickedFile.path));
    }
  }

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
