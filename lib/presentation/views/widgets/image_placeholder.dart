import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octo_image/octo_image.dart';

import '../../../logic/image_cubit/image_cubit.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.r),
      child: BlocBuilder<ImageCubit, ImageState>(
        builder: (context, state) {
          if (state.file != null) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 2.3,
              child: OctoImage(
                image: FileImage(state.file!),
                fit: BoxFit.cover,
                imageBuilder: (context, image) => Stack(
                  children: [
                    image,
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        height:
                            (MediaQuery.of(context).size.height / 2.3) / 4.5,
                        width: (MediaQuery.of(context).size.width),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black54,
                              Colors.transparent,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        height:
                            (MediaQuery.of(context).size.height / 2.3) / 4.5,
                        width: (MediaQuery.of(context).size.width),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black54,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20.w,
                      right: 20.w,
                      child: Material(
                        color: Colors.transparent,
                        child: IconButton(
                          onPressed: () async =>
                              await context.read<ImageCubit>().selectImage(),
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                progressIndicatorBuilder:
                    (BuildContext context, ImageChunkEvent? progress) {
                  return Center(
                    child: progress == null
                        ? const CircularProgressIndicator()
                        : CircularProgressIndicator(
                            value: progress.cumulativeBytesLoaded.toDouble(),
                          ),
                  );
                },
              ),
            );
          }
          return const NoImageSelectedWidget();
        },
      ),
    );
  }
}

class NoImageSelectedWidget extends StatelessWidget {
  const NoImageSelectedWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () async {
          await context.read<ImageCubit>().selectImage();
        },
        borderRadius: BorderRadius.circular(20.r),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.image_outlined,
                size: 800.w,
                color: Colors.grey,
              ),
              Text(
                'Add Image',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 33.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
