part of 'image_cubit.dart';

class ImageState extends Equatable {
  const ImageState(this.file);
  final File? file;
  @override
  List<Object> get props => [if (file != null) file!];
}
