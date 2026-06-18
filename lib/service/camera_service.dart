import 'dart:io';

import 'package:image_picker/image_picker.dart';

class CameraService {

  final ImagePicker _picker = ImagePicker();

  Future<File?> tirarFoto() async {

    final XFile? foto = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if(foto == null){
      return null;
    }

    return File(foto.path);
  }
}