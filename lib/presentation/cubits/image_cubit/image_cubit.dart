import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:businessmates_admin/di/injector.dart';
import 'package:businessmates_admin/domain/repositories/repository.dart';
import 'package:businessmates_admin/presentation/widgets/pdf_upload_bottom_sheet.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../widgets/image_upload_bottom_sheet.dart';

part 'image_state.dart';

@LazySingleton()
class ImageCubit extends Cubit<ImageState> {
  final Repository _repository;
  ImageCubit()
      : _repository = repository,
        super(ImageState.initial());

  File? _localImage;
  File? _localPdf;

// sinks
  localImageChanged(File images) => _localImage = images;
  localPDFChanged(File pdf) => _localPdf = pdf;

// getters
  File? get localImage => _localImage;
  File? get localPdf => _localPdf;

  // use case to upload image
  Future<String> uploadImages() async {
    if (_localImage == null) {
      return "";
    }
    emit(state.copyWith(status: Status.loading));
    var imageEither = await _repository.uploadSingleImage(
      image: _localImage!,
    );
    imageEither.fold(
      (failure) => emit(
        state.copyWith(
          errorMessage: failure.message,
          status: Status.error,
        ),
      ),
      (success) async {
        emit(state.copyWith(
          uploadedImage: success,
          status: Status.success,
        ));
      },
    );
    return state.uploadedImage;
  }

  void setImageUploadStatus(Status status) {
    emit(state.copyWith(status: status));
  }

  Future<String> showImageUploadSheet(BuildContext context) async {
    String imagePath = "";
    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(MediaQuery.of(context).size.width * 0.02),
          topRight: Radius.circular(MediaQuery.of(context).size.width * 0.02),
        ),
      ),
      context: context,
      builder: (builder) => ImageUploadBottomSheet(
        onImageUploaded: (String path) {
          imagePath = path;
        },
      ),
    );
    return imagePath;
  }

  Future<String> showPdfUploadSheet(BuildContext context) async {
    String pdfPath = "";
    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(MediaQuery.of(context).size.width * 0.02),
          topRight: Radius.circular(MediaQuery.of(context).size.width * 0.02),
        ),
      ),
      context: context,
      builder: (builder) => PDFUploadBottomSheet(
        onPdfUploaded: (String path) {
          pdfPath = path;
        },
      ),
    );
    return pdfPath;
  }

  // use case to upload pdf
  Future<String> uploadPdf() async {
    if (_localImage == null) {
      return "";
    }
    emit(state.copyWith(status: Status.loading));
    var imageEither = await _repository.uploadSinglePdf(
      pdf: _localImage!,
    );
    imageEither.fold(
      (failure) => emit(
        state.copyWith(
          errorMessage: failure.message,
          status: Status.error,
        ),
      ),
      (success) async {
        emit(state.copyWith(
          uploadedImage: success,
          status: Status.success,
        ));
      },
    );
    return state.uploadedImage;
  }
}
