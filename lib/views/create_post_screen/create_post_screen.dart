import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credbud/views/constants/app_colors.dart';
import 'package:credbud/views/welcome_screen/divider_with_margins.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../../state/profile/providers/profile_providers.dart';
import '../components/animations/lottie_animations_view.dart';
import '../components/animations/models/lottie_animations.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  const CreatePostScreen({super.key});

  @override
  ConsumerState createState() => _CreatePostScreenState();
}

enum PostType { other, nptel, spokenTutorial }

enum UploadType { image, pdf }

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  PostType selectedPostType = PostType.other;
  UploadType selectedUploadType = UploadType.image;

  final TextEditingController _captionController = TextEditingController();
  final TextEditingController _otherController = TextEditingController();
  XFile? _image;
  FilePickerResult? _pdfFile;

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    setState(() {
      _image = image;
    });
  }

  Future<XFile?> _compressImage(XFile image) async {
    final filePath = image.path;
    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    var result = await FlutterImageCompress.compressAndGetFile(
      filePath,
      outPath,
      quality: 50,
    );
    return result;
  }

  Future<String> _uploadImageToCloudinary(XFile image) async {
    final compressedImage = await _compressImage(image);

    if (compressedImage != null) {
      final url = Uri.parse('https://api.cloudinary.com/v1_1/dfeqycn5v/upload');
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'credbud_user'
        ..files.add(
            await http.MultipartFile.fromPath('file', compressedImage.path));
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes();
        final responseString = utf8.decode(responseData);
        final jsonMap = jsonDecode(responseString);
        final url = jsonMap['url'];
        return url;
      }
    }
    return '';
  }

  Future<String> _uploadPdfToCloudinary(PlatformFile pdfFile) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dfeqycn5v/upload');
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] =
          'credbud_user_pdf' // Use a different preset for PDFs
      ..files.add(await http.MultipartFile.fromPath('file', pdfFile.path!));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = utf8.decode(responseData);
      final jsonMap = jsonDecode(responseString);
      final url = jsonMap['url'];
      return url;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Create Post",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          // backgroundColor: Colors.transparent,
          // scrolledUnderElevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SegmentedButton<PostType>(
                      style: SegmentedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        // foregroundColor: Colors.red,
                        selectedForegroundColor: Colors.white,
                        selectedBackgroundColor: AppColors.malibu,
                      ),
                      segments: const <ButtonSegment<PostType>>[
                        ButtonSegment<PostType>(
                          value: PostType.other,
                          label: Text('Other'),
                        ),
                        ButtonSegment<PostType>(
                          value: PostType.nptel,
                          label: Text('NPTEL'),
                        ),
                        ButtonSegment<PostType>(
                          value: PostType.spokenTutorial,
                          label: Text('Spoken Tutorial'),
                        ),
                      ],
                      selected: <PostType>{selectedPostType},
                      onSelectionChanged: (Set<PostType> newSelection) {
                        setState(() {
                          // By default there is only a single segment that can be
                          // selected at one time, so its value is always the first
                          // item in the selected set.
                          selectedPostType = newSelection.first;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    selectedPostType == PostType.other
                        ? Column(
                            children: [
                              TextField(
                                controller: _otherController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none, // Remove underline
                                  focusedBorder: InputBorder
                                      .none, // Remove underline on focus
                                  // contentPadding: EdgeInsets.all(8.0), // Add padding for better visual separation
                                  hintText: "Enter Post Type",
                                ),
                                textCapitalization: TextCapitalization.words,
                                // maxLines: null, // Allow unlimited lines for wrapping
                                // keyboardType: TextInputType.multiline,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24,
                                ),
                              ),
                              const DividerWithMarginsZero()
                            ],
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                    TextField(
                      controller: _captionController,
                      decoration: const InputDecoration(
                        border: InputBorder.none, // Remove underline
                        focusedBorder:
                            InputBorder.none, // Remove underline on focus
                        // contentPadding: EdgeInsets.all(8.0), // Add padding for better visual separation
                        hintText: "What's your post about !?",
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: null, // Allow unlimited lines for wrapping
                      keyboardType:
                          TextInputType.multiline, // Enable multiline input
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text(
                          'Upload Type: ',
                          style: TextStyle(fontSize: 22),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SegmentedButton<UploadType>(
                            style: SegmentedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              // foregroundColor: Colors.red,
                              selectedForegroundColor: Colors.white,
                              selectedBackgroundColor: AppColors.mauve,
                            ),
                            segments: const <ButtonSegment<UploadType>>[
                              ButtonSegment<UploadType>(
                                value: UploadType.image,
                                label: Text('Image'),
                              ),
                              ButtonSegment<UploadType>(
                                value: UploadType.pdf,
                                label: Text('PDF'),
                              ),
                            ],
                            selected: <UploadType>{selectedUploadType},
                            onSelectionChanged: (Set<UploadType> newSelection) {
                              setState(() {
                                // By default there is only a single segment that can be
                                // selected at one time, so its value is always the first
                                // item in the selected set.
                                selectedUploadType = newSelection.first;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    selectedUploadType == UploadType.image
                        ? GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return SafeArea(
                                    child: Wrap(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _pickImage(ImageSource.camera);
                                            Navigator.of(context).pop();
                                          },
                                          child: const ListTile(
                                            leading: Icon(Icons.camera),
                                            title: Text("Camera"),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _pickImage(ImageSource.gallery);
                                            Navigator.of(context).pop();
                                          },
                                          child: const ListTile(
                                            leading:
                                                Icon(Icons.photo_library_sharp),
                                            title: Text("Gallery"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              // height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    15.0), // Adjust as needed
                                color: AppColors.malibu.withAlpha(50),
                                border: Border.all(
                                    color: Colors.black,
                                    width: 0.5), // Black border
                              ),
                              constraints: BoxConstraints(
                                  maxHeight: 180.0,
                                  minWidth: MediaQuery.of(context).size.width,
                                  minHeight: 180),
                              child: _image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          15.0), // Match container radius
                                      child: Image.file(
                                        File(_image!.path),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.image_outlined,
                                      size: 80,
                                      color: AppColors.malibu,
                                    ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              _pdfFile = await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['pdf'],
                              );
                              setState(() {});
                              // if (_pdfFile != null) {
                              //   PlatformFile file = _pdfFile!.files.first;
                              //   print(file.name);
                              //   print(file.bytes);
                              //   print(file.size);
                              //   print(file.extension);
                              //   print(file.path);
                              // } else {
                              //   // User canceled the picker
                              // }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: AppColors.mauve.withAlpha(50),
                                border:
                                    Border.all(color: Colors.black, width: 0.5),
                              ),
                              constraints: BoxConstraints(
                                maxHeight: 180.0,
                                minWidth:
                                    MediaQuery.of(context).size.width / 2 - 24,
                                minHeight: 180,
                              ),
                              // child: const Center(
                              //   child: Icon(Icons.picture_as_pdf, size: 80),
                              // ),
                              child: _pdfFile != null
                                  ? Center(
                                      child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            'Ready to upload:\n${_pdfFile!.files.first.name}',
                                            style:
                                                const TextStyle(fontSize: 20),
                                          )))
                                  : const Center(
                                      child: Icon(
                                        Icons.picture_as_pdf,
                                        size: 80,
                                        color: Colors.red,
                                      ),
                                    ),
                            ),
                          ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: NeoPopButton(
                        color: AppColors.cornflowerBlue,
                        buttonPosition: Position.fullBottom,
                        depth: 10.0,
                        onTapUp: () async {
                          if (selectedPostType == PostType.other &&
                              _otherController.text.toString() != '') {
                            if (selectedUploadType == UploadType.image &&
                                _image != null &&
                                _captionController.text.isNotEmpty) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.4),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white),
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        child: const LottieAnimationView(
                                          animation: LottieAnimation.loading,
                                          repeat: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );

                              // ToDo: might need to handle profile not available error if required
                              final profile = ref.read(profileStateProvider);
                              // print(profile.valueOrNull?.name);

                              try {
                                final imageUrl =
                                    await _uploadImageToCloudinary(_image!);

                                if (imageUrl != '') {
                                  final postsCollection = FirebaseFirestore
                                      .instance
                                      .collection('Sinhgad/users/posts');
                                  final newPostDoc = postsCollection.doc();
                                  final postData = {
                                    'credPoints': 0,
                                    'department':
                                        profile.valueOrNull!.department,
                                    'imageUrl': imageUrl,
                                    'isVerified': false,
                                    'ownerId': profile.valueOrNull!.id,
                                    'ownerName': profile.valueOrNull!.name,
                                    'postText':
                                        _captionController.text.toString(),
                                    'postType':
                                        selectedPostType == PostType.other
                                            ? _otherController.text.toString()
                                            : selectedPostType == PostType.nptel
                                            ? 'NPTEL'
                                            : 'Spoken Tutorial',
                                    'timestamp': FieldValue.serverTimestamp(),
                                    'verifiedBy': ''
                                  };
                                  await newPostDoc.set(postData);
                                } else {
                                  throw Exception('Post upload failed :(');
                                }

                                Navigator.of(context)
                                    .pop(); // Close the loading dialog

                                setState(() {
                                  _image = null;
                                  _pdfFile = null;
                                  _captionController.text = '';
                                  _otherController.text = '';
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      showCloseIcon: true,
                                      backgroundColor: Colors.green,
                                      content:
                                          Text('Post uploaded successfully!')),
                                );
                              } catch (error) {
                                Navigator.of(context)
                                    .pop(); // Close the loading dialog
                                setState(() {
                                  _image = null;
                                  _pdfFile = null;
                                  _captionController.text = '';
                                  _otherController.text = '';
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      showCloseIcon: true,
                                      backgroundColor: Colors.red,
                                      content: Text('$error')),
                                );
                              }
                            } else if (selectedUploadType == UploadType.pdf &&
                                _pdfFile != null &&
                                _captionController.text.isNotEmpty) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.4),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white),
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        child: const LottieAnimationView(
                                          animation: LottieAnimation.loading,
                                          repeat: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );

                              // ToDo: might need to handle profile not available error if required
                              final profile = ref.read(profileStateProvider);
                              // print(profile.valueOrNull?.name);

                              try {
                                final pdfUrl = await _uploadPdfToCloudinary(
                                    _pdfFile!.files.first);

                                if (pdfUrl != '') {
                                  final postsCollection = FirebaseFirestore
                                      .instance
                                      .collection('Sinhgad/users/posts');
                                  final newPostDoc = postsCollection.doc();
                                  final postData = {
                                    'credPoints': 0,
                                    'department':
                                        profile.valueOrNull!.department,
                                    'imageUrl': pdfUrl,
                                    'isVerified': false,
                                    'ownerId': profile.valueOrNull!.id,
                                    'ownerName': profile.valueOrNull!.name,
                                    'postText':
                                        _captionController.text.toString(),
                                    'postType':
                                        selectedPostType == PostType.other
                                            ? _otherController.text.toString()
                                            : selectedPostType == PostType.nptel
                                                ? 'NPTEL'
                                                : 'Spoken Tutorial',
                                    'timestamp': FieldValue.serverTimestamp(),
                                    'verifiedBy': ''
                                  };
                                  await newPostDoc.set(postData);
                                } else {
                                  throw Exception('Post upload failed :(');
                                }

                                Navigator.of(context)
                                    .pop(); // Close the loading dialog

                                setState(() {
                                  _image = null;
                                  _pdfFile = null;
                                  _captionController.text = '';
                                  _otherController.text = '';
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      showCloseIcon: true,
                                      backgroundColor: Colors.green,
                                      content:
                                          Text('Post uploaded successfully!')),
                                );
                              } catch (error) {
                                Navigator.of(context)
                                    .pop(); // Close the loading dialog
                                setState(() {
                                  _image = null;
                                  _pdfFile = null;
                                  _captionController.text = '';
                                  _otherController.text = '';
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      showCloseIcon: true,
                                      backgroundColor: Colors.red,
                                      content: Text('$error')),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    showCloseIcon: true,
                                    backgroundColor: Colors.red,
                                    content: Text('Missing fields :(')),
                              );
                            }
                          } else if (selectedPostType != PostType.other) {
                            if (selectedUploadType == UploadType.image &&
                                _image != null &&
                                _captionController.text.isNotEmpty) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.4),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white),
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        child: const LottieAnimationView(
                                          animation: LottieAnimation.loading,
                                          repeat: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );

                              // ToDo: might need to handle profile not available error if required
                              final profile = ref.read(profileStateProvider);
                              // print(profile.valueOrNull?.name);

                              try {
                                final imageUrl =
                                    await _uploadImageToCloudinary(_image!);

                                if (imageUrl != '') {
                                  final postsCollection = FirebaseFirestore
                                      .instance
                                      .collection('Sinhgad/users/posts');
                                  final newPostDoc = postsCollection.doc();
                                  final postData = {
                                    'credPoints': 0,
                                    'department':
                                        profile.valueOrNull!.department,
                                    'imageUrl': imageUrl,
                                    'isVerified': false,
                                    'ownerId': profile.valueOrNull!.id,
                                    'ownerName': profile.valueOrNull!.name,
                                    'postText':
                                        _captionController.text.toString(),
                                    'postType':
                                        selectedPostType == PostType.other
                                            ? _otherController.text.toString()
                                            : selectedPostType == PostType.nptel
                                            ? 'NPTEL'
                                            : 'Spoken Tutorial',
                                    'timestamp': FieldValue.serverTimestamp(),
                                    'verifiedBy': ''
                                  };
                                  await newPostDoc.set(postData);
                                } else {
                                  throw Exception('Post upload failed :(');
                                }

                                Navigator.of(context)
                                    .pop(); // Close the loading dialog
                                setState(() {
                                  _image = null;
                                  _pdfFile = null;
                                  _captionController.text = '';
                                  _otherController.text = '';
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      showCloseIcon: true,
                                      backgroundColor: Colors.green,
                                      content:
                                          Text('Post uploaded successfully!')),
                                );
                              } catch (error) {
                                Navigator.of(context)
                                    .pop(); // Close the loading dialog
                                setState(() {
                                  _image = null;
                                  _pdfFile = null;
                                  _captionController.text = '';
                                  _otherController.text = '';
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      showCloseIcon: true,
                                      backgroundColor: Colors.red,
                                      content: Text('$error')),
                                );
                              }
                            } else if (selectedUploadType == UploadType.pdf &&
                                _pdfFile != null &&
                                _captionController.text.isNotEmpty) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.4),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white),
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        child: const LottieAnimationView(
                                          animation: LottieAnimation.loading,
                                          repeat: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );

                              // ToDo: might need to handle profile not available error if required
                              final profile = ref.read(profileStateProvider);
                              // print(profile.valueOrNull?.name);

                              try {
                                final pdfUrl = await _uploadPdfToCloudinary(
                                    _pdfFile!.files.first);

                                if (pdfUrl != '') {
                                  final postsCollection = FirebaseFirestore
                                      .instance
                                      .collection('Sinhgad/users/posts');
                                  final newPostDoc = postsCollection.doc();
                                  final postData = {
                                    'credPoints': 0,
                                    'department':
                                        profile.valueOrNull!.department,
                                    'imageUrl': pdfUrl,
                                    'isVerified': false,
                                    'ownerId': profile.valueOrNull!.id,
                                    'ownerName': profile.valueOrNull!.name,
                                    'postText':
                                        _captionController.text.toString(),
                                    'postType':
                                        selectedPostType == PostType.other
                                            ? _otherController.text.toString()
                                            : selectedPostType == PostType.nptel
                                            ? 'NPTEL'
                                            : 'Spoken Tutorial',
                                    'timestamp': FieldValue.serverTimestamp(),
                                    'verifiedBy': ''
                                  };
                                  await newPostDoc.set(postData);
                                } else {
                                  throw Exception('Post upload failed :(');
                                }

                                Navigator.of(context)
                                    .pop(); // Close the loading dialog

                                setState(() {
                                  _image = null;
                                  _pdfFile = null;
                                  _captionController.text = '';
                                  _otherController.text = '';
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      showCloseIcon: true,
                                      backgroundColor: Colors.green,
                                      content:
                                          Text('Post uploaded successfully!')),
                                );
                              } catch (error) {
                                Navigator.of(context)
                                    .pop(); // Close the loading dialog
                                setState(() {
                                  _image = null;
                                  _pdfFile = null;
                                  _captionController.text = '';
                                  _otherController.text = '';
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      showCloseIcon: true,
                                      backgroundColor: Colors.red,
                                      content: Text('$error')),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    showCloseIcon: true,
                                    backgroundColor: Colors.red,
                                    content: Text('Missing fields :(')),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  showCloseIcon: true,
                                  backgroundColor: Colors.red,
                                  content: Text('Missing Post Type :(')),
                            );
                          }
                        },
                        onTapDown: () {
                          HapticFeedback.heavyImpact();
                        },
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 15.0),
                            child: Text('Post',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
