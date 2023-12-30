import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../Constants/color.dart';

class FilePickerService {
  FilePickerResult? result;

  Future<File?> singleFilePicker({List<String>? allowedExtensions}) async {
    result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: allowedExtensions,
      type: FileType.custom,
    );

    if (result != null) {
      File file = File(result!.files.single.path!);
      return file;
    } else {
      return null;
    }
  }

  Future<List<File>?> multiFilePicker({List<String>? allowedExtensions}) async {
    result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      allowedExtensions: allowedExtensions,
      onFileLoading: (p0) {
        return p0 == FilePickerStatus.picking
            ? CircularProgressIndicator(
                color: AppColors.PRIMARY_COLOR,
              )
            : null;
      },

    );

    if (result != null) {
      List<File> files = result!.paths.map((path) => File(path!)).toList();
      return files;
    } else {
      return null;
    }
  }
}
