import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../presentation/shared/helpers/image_picker_helper.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit() : super(const ImageState(null));

  Future<void> selectImage() async {
    final file = await ImagePickerHelper.pickImage();
    if (file != null) {
      final croppedFile = await ImagePickerHelper.cropImage(file);
      if (croppedFile != null) emit(ImageState(croppedFile));
    }
    // emit(ImageState(file));
  }

  void resetState() => emit(const ImageState(null));
}
