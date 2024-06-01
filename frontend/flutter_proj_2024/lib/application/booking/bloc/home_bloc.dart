
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageEvent {}

class LoadImages extends ImageEvent {}

class ImageState {
  final List<String> images;
  ImageState(this.images);
}

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageState([])) {
    on<LoadImages>((event, emit) {
      emit(ImageState([
        'lib/images/entry.jpeg',
        'lib/images/entry2.jpeg',
        'lib/images/entry3.jpeg',
      ]));
    });
  }
}