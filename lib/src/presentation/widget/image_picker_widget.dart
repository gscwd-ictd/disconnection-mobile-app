import 'dart:io';

import 'package:diconnection/src/core/handler/utils_handler.dart';
import 'package:diconnection/src/presentation/widget/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:mime/mime.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function onChanged;
  const ImagePickerWidget({Key? key, required this.onChanged})
      : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final ImagePicker _picker = ImagePicker();
  double compression = 0.2;
  String? _retrieveDataError;
  dynamic _pickImageError;
  VideoPlayerController? _toBeDisposed;
  VideoPlayerController? _controller;
  bool isVideo = false;
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  void _setImageFileListFromFile(XFile? value) {
    if (value != null) {
      UtilsHandler.mediaFileList = <XFile>[value];
    }
    widget.onChanged();
  }

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed!.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }

  Widget _handlePreview() {
    if (isVideo) {
      return _previewVideo();
    } else {
      return _previewImages();
    }
  }

  Widget _previewVideo() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_controller == null) {
      return const Text(
        'You have not yet picked a video',
        textAlign: TextAlign.center,
      );
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatioVideo(_controller),
    );
  }

  Widget _buildInlineVideoPlayer(int index) {
    final VideoPlayerController controller = VideoPlayerController.file(
        File(UtilsHandler.mediaFileList![index].path));
    const double volume = kIsWeb ? 0.0 : 1.0;
    controller.setVolume(volume);
    controller.initialize();
    controller.setLooping(true);
    controller.play();
    return Center(child: AspectRatioVideo(controller));
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Card(
            elevation: 2.0,
            color: Colors.blueGrey,
            child: Center(
                child: FutureBuilder<void>(
              future: retrieveLostData(),
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const Padding(
                      padding: EdgeInsets.all(33.0),
                      child: Icon(Icons.image_outlined),
                    );
                  case ConnectionState.done:
                    return UtilsHandler.mediaFileList!.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.all(33.0),
                            child: Icon(Icons.image_outlined))
                        : SizedBox(
                            height: 88,
                            width: 88,
                            child: Center(child: _handlePreview()));
                  case ConnectionState.active:
                    if (snapshot.hasError) {
                      return const Padding(
                          padding: EdgeInsets.all(33.0),
                          child: Icon(Icons.image_outlined));
                    } else {
                      return const Padding(
                        padding: EdgeInsets.all(33.0),
                        child: Icon(Icons.image_outlined),
                      );
                    }
                }
              },
            ))), //_onImageButtonPressed(ImageSource.camera, context: context);
        IconButton(
          color:
              UtilsHandler.mediaFileList!.isEmpty ? Colors.grey : Colors.black,
          onPressed: UtilsHandler.mediaFileList!.isEmpty
              ? () {}
              : () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: SizedBox(
                            height: 40.h,
                            width: 100.w,
                            child: InteractiveViewer(child: _handlePreview()),
                          ),
                          actions: [],
                        );
                      });
                },
          icon: const Icon(FontAwesomeIcons.magnifyingGlass),
        ),
        IconButton(
          icon: const Icon(Icons.camera_alt_outlined),
          onPressed: () {
            _onImageButtonPressed(ImageSource.camera, context: context);
          },
        ),
      ],
    );
  }

  Future<void> _onImageButtonPressed(
    ImageSource source, {
    required BuildContext context,
    bool isMultiImage = false,
    bool isMedia = false,
  }) async {
    if (_controller != null) {
      await _controller!.setVolume(0.0);
    }
    if (context.mounted) {
      if (isVideo) {
        final XFile? file = await _picker.pickVideo(
            source: source, maxDuration: const Duration(seconds: 10));
        await _playVideo(file);
      } else if (isMultiImage) {
        await _displayPickImageDialog(context,
            (double? maxWidth, double? maxHeight, int? quality) async {
          try {
            final List<XFile> pickedFileList = isMedia
                ? await _picker.pickMultipleMedia(
                    maxWidth: maxWidth,
                    maxHeight: maxHeight,
                    imageQuality: quality,
                  )
                : await _picker.pickMultiImage(
                    maxWidth: maxWidth,
                    maxHeight: maxHeight,
                    imageQuality: quality,
                  );
            setState(() {
              if (pickedFileList.isNotEmpty) {
                UtilsHandler.mediaFileList = pickedFileList;
              }
            });
          } catch (e) {
            setState(() {
              _pickImageError = e;
            });
          }
        });
      } else if (isMedia) {
        await _displayPickImageDialog(context,
            (double? maxWidth, double? maxHeight, int? quality) async {
          try {
            final List<XFile> pickedFileList = <XFile>[];
            final XFile? media = await _picker.pickMedia(
              maxWidth: maxWidth,
              maxHeight: maxHeight,
              imageQuality: quality,
            );
            if (media != null) {
              pickedFileList.add(media);
              setState(() {
                if (pickedFileList.isNotEmpty) {
                  UtilsHandler.mediaFileList = pickedFileList;
                }
              });
            }
          } catch (e) {
            setState(() {
              _pickImageError = e;
            });
          }
        });
      } else {
        await _displayPickImageDialog(context,
            (double? maxWidth, double? maxHeight, int? quality) async {
          try {
            final XFile? pickedFile = await _picker.pickImage(
              source: source,
              maxWidth: maxWidth,
              maxHeight: maxHeight,
              imageQuality: quality,
            );
            setState(() {
              _setImageFileListFromFile(pickedFile);
            });
          } catch (e) {
            setState(() {
              _pickImageError = e;
            });
          }
        });
      }
    }
  }

  Future<void> _playVideo(XFile? file) async {
    if (file != null && mounted) {
      await _disposeVideoController();
      late VideoPlayerController controller;
      if (kIsWeb) {
        // TODO(gabrielokura): remove the ignore once the following line can migrate to
        // use VideoPlayerController.networkUrl after the issue is resolved.
        // https://github.com/flutter/flutter/issues/121927
        // ignore: deprecated_member_use
        controller = VideoPlayerController.network(file.path);
      } else {
        controller = VideoPlayerController.file(File(file.path));
      }
      _controller = controller;
      // In web, most browsers won't honor a programmatic call to .play
      // if the video has a sound track (and is not muted).
      // Mute the video so it auto-plays in web!
      // This is not needed if the call to .play is the result of user
      // interaction (clicking on a "play" button, for example).
      const double volume = kIsWeb ? 0.0 : 1.0;
      await controller.setVolume(volume);
      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();
      setState(() {});
    }
  }

  Future<void> _displayPickImageDialog(
      BuildContext context, OnPickImageCallback onPick) async {
    //onPick(width, height, quality);
    onPick(null, null, 10);
    // return showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: const Text('Add optional parameters'),
    //         content: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: <Widget>[
    //             TextField(
    //               controller: maxWidthController,
    //               keyboardType:
    //                   const TextInputType.numberWithOptions(decimal: true),
    //               decoration: const InputDecoration(
    //                   hintText: 'Enter maxWidth if desired'),
    //             ),
    //             TextField(
    //               controller: maxHeightController,
    //               keyboardType:
    //                   const TextInputType.numberWithOptions(decimal: true),
    //               decoration: const InputDecoration(
    //                   hintText: 'Enter maxHeight if desired'),
    //             ),
    //             TextField(
    //               controller: qualityController,
    //               keyboardType: TextInputType.number,
    //               decoration: const InputDecoration(
    //                   hintText: 'Enter quality if desired'),
    //             ),
    //           ],
    //         ),
    //         actions: <Widget>[
    //           TextButton(
    //             child: const Text('CANCEL'),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //           ),
    //           TextButton(
    //               child: const Text('PICK'),
    //               onPressed: () {
    //                 final double? width = maxWidthController.text.isNotEmpty
    //                     ? double.parse(maxWidthController.text)
    //                     : null;
    //                 final double? height = maxHeightController.text.isNotEmpty
    //                     ? double.parse(maxHeightController.text)
    //                     : null;
    //                 final int? quality = qualityController.text.isNotEmpty
    //                     ? int.parse(qualityController.text)
    //                     : null;
    //                 onPick(width, height, quality);
    //                 Navigator.of(context).pop();
    //               }),
    //         ],
    //       );
    //     });
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.video) {
        isVideo = true;
        await _playVideo(response.file);
      } else {
        isVideo = false;
        setState(() {
          if (response.files == null) {
            _setImageFileListFromFile(response.file);
          } else {
            if (response.files != null) {
              UtilsHandler.mediaFileList = response.files;
            }
          }
        });
      }
    } else {
      _retrieveDataError = response.exception!.code;
      Logger i = Logger();
      i.t(_retrieveDataError);
    }
  }

  Widget _previewImages() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (UtilsHandler.mediaFileList != null) {
      return Semantics(
        label: 'image_picker_example_picked_images',
        child: ListView.builder(
          key: UniqueKey(),
          itemBuilder: (BuildContext context, int index) {
            final String? mime =
                lookupMimeType(UtilsHandler.mediaFileList![index].path);

            // Why network for web?
            // See https://pub.dev/packages/image_picker_for_web#limitations-on-the-web-platform
            return Semantics(
              label: 'image_picker_example_picked_image',
              child: kIsWeb
                  ? Image.network(
                      UtilsHandler.mediaFileList![index].path,
                      fit: BoxFit.fill,
                    )
                  : (mime == null || mime.startsWith('image/')
                      ? Image.file(
                          File(UtilsHandler.mediaFileList![index].path),
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return const Center(
                                child:
                                    Text('This image type is not supported'));
                          },
                        )
                      : _buildInlineVideoPlayer(index)),
            );
          },
          itemCount: UtilsHandler.mediaFileList!.length,
        ),
      );
    } else if (_pickImageError != null) {
      return const Padding(
        padding: EdgeInsets.all(33.0),
        child: Icon(Icons.error_outline),
      );
    } else {
      return const Padding(
        padding: EdgeInsets.all(33.0),
        child: Icon(Icons.image_outlined),
      );
    }
  }
}
