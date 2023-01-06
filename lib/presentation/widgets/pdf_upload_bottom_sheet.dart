import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../cubits/image_cubit/image_cubit.dart';
import 'bm_button.dart';
import 'handle_bar_widget.dart';

class PDFUploadBottomSheet extends StatefulWidget {
  final Function(String) onPdfUploaded;
  const PDFUploadBottomSheet({Key? key, required this.onPdfUploaded})
      : super(key: key);

  @override
  State<PDFUploadBottomSheet> createState() => _PDFUploadBottomSheetState();
}

class _PDFUploadBottomSheetState extends State<PDFUploadBottomSheet> {
  File? _pdf; //?
  double? _pdfPreviewRadius = 0;
  double? _previewBorderOpacity = 0;
  bool isNotChanged = true;
  bool isPickerInit = true;
  @override
  void initState() {
    super.initState();
  }

  //method to open image from gallery
  _pdfFromFile() async {
    // using file picker
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path.toString());
      setState(() {
        _pdf = file;
      });
    } else {
      // User canceled the picker
    }
  }

  //method to open image from camera

  List<Widget> previewPdfs() {
    List<Widget> pdfs = [];
    if (_pdf == null) {
      return pdfs;
    }
    context.read<ImageCubit>().localPDFChanged(_pdf!);
    pdfs.add(
      Image.file(
        _pdf!,
        // height: 200,
        // width: 200,
      ),
    );
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _pdfPreviewRadius = 100;
        _previewBorderOpacity = 1;
      });
    });

    return pdfs;
  }

  @override
  Widget build(BuildContext context) {
    ImageCubit imageCubit = BlocProvider.of<ImageCubit>(context);
    return SizedBox(
      child: SingleChildScrollView(
        child: BlocConsumer<ImageCubit, ImageState>(
          listener: (context, state) {
            if (state.status == Status.success) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Image Uploaded Successfully'),
                  duration: Duration(seconds: 2),
                ),
              );
            } else if (state.status == Status.error) {
              // alert dialog
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Error'),
                    content: Text(state.errorMessage),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                },
              );
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const SheetHandleBarWidget(),
                const SizedBox(
                  height: 20,
                ),
                previewPdfs().isNotEmpty
                    ? GestureDetector(
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Image'),
                              content: const Text(
                                  'Are you sure you want to delete this image?'),
                              actions: [
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                TextButton(
                                  child: const Text('Delete'),
                                  onPressed: () {
                                    setState(() {
                                      _pdf = null;
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                          setState(() {});
                        },
                        child: AnimatedContainer(
                          height: 300,
                          duration: const Duration(milliseconds: 1000),
                          // preview pdf
                          child: PDFView(
                            filePath: _pdf!.path,
                            enableSwipe: true,
                            swipeHorizontal: true,
                            autoSpacing: false,
                            pageFling: false,
                            pageSnap: true,
                            defaultPage: 0,
                            fitPolicy: FitPolicy.BOTH,
                            preventLinkNavigation:
                                false, // if set to true the link is handled in flutter
                            onRender: (pages) {
                              setState(() {
                                // _pdfPreviewRadius = 100;
                                // _previewBorderOpacity = 1;
                              });
                            },
                            onError: (error) {
                              print(error.toString());
                            },
                            onPageError: (page, error) {
                              print('$page: ${error.toString()}');
                            },
                            onViewCreated:
                                (PDFViewController pdfViewController) {
                              // _controller.complete(pdfViewController);
                            },
                            onPageChanged: (int? page, int? total) {
                              print('page change: $page/$total');
                            },
                            onLinkHandler: (String? uri) {
                              print('goto uri: $uri');
                            },
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
                previewPdfs().isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        child: Column(
                          children: [
                            // upload and delete button

                            BlocBuilder<ImageCubit, ImageState>(
                              builder: (context, state) {
                                return BMButton(
                                  isLoading: state.status == Status.loading,
                                  text: "Confirm Upload",
                                  color: Theme.of(context).colorScheme.primary,
                                  onPressed: () async {
                                    if (_pdf == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Please select an image'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                      return;
                                    }
                                    final pdfUrl = await imageCubit.uploadPdf();
                                    widget.onPdfUploaded(pdfUrl);
                                  },
                                );
                              },
                            ),

                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      )
                    : Container(),
                isNotChanged
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                _pdfFromFile();
                              },
                              icon: const Icon(Icons.camera),
                              label: const Text('File'),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        child: BMButton(
                          text: "Change",
                          color: Theme.of(context).colorScheme.error,
                          outlined: true,
                          onPressed: () {
                            setState(() {
                              isNotChanged = !isNotChanged;
                            });
                          },
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
