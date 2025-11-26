import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pidilite/Utill/AppConstants.dart';
import 'package:pidilite/Utill/app_colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:permission_handler/permission_handler.dart';
class CameraPage extends StatefulWidget {
   CameraPage({super.key,required this.needSelfyMode});
bool needSelfyMode =false;
//String waterText;
  @override
  _MyCameraAppState createState() => _MyCameraAppState();
}

class _MyCameraAppState extends State<CameraPage> {
  late CameraController _controller;
  late List<CameraDescription> _cameras;
  //final _flutterImageEditWatermarkPlugin = FlutterImageEditWatermark();

  bool isLoading = false;
  bool iscamerapreview = false;
int cameramode = 0;
String tempimage="";
  @override
  void initState() {
    setState(() {

        cameramode= widget.needSelfyMode == true ? 1: 0;

      isLoading = true;
    });
    initCamera();
    super.initState();
  }

  Future<void> initCamera() async {
    // final status = await Permission.camera.request();
    //
    // if (status != PermissionStatus.granted) {
    //   setState(() {
    //     isLoading = false;
    //   });
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text("Camera permission is required to continue")),
    //   );
    //   return;
    // }
    _cameras = await availableCameras();
    _controller = CameraController(_cameras[cameramode], ResolutionPreset.high);

    _controller.initialize().then((_) {
      // _initializeControllerFuture = true;
      if (!mounted) {
        return;
      }
      setState(() {
        isLoading = false;
      });
    }).catchError((Object e) {
      setState(() {
        isLoading = false;
      });
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
          // Handle access errors here.
            print(e);
            break;
          default:
            print(e);
          // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  Future<void> _takePicture(BuildContext context) async {
    try {

      // Directory documentsDirectory = await getApplicationDocumentsDirectory();
      //
      // // Create a subdirectory
      // String directoryName = AppConstants.appName;
      // Directory newDirectory = Directory('${documentsDirectory.path}/$directoryName');
      // bool directoryExists = await newDirectory.exists();
      // if (!directoryExists) {
      //   // Create the directory if it doesn't exist
      //   await newDirectory.create(recursive: true);
      //   print('Directory created successfully: ${newDirectory.path}');
      // } else {
      //   print('Directory already exists: ${newDirectory.path}');
      // }
      // String galleryPath = newDirectory.path;
      //
      // String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      // String imageFileName = "IMG_$timeStamp.jpg";
      // String imagePath = '$galleryPath/$imageFileName';
     // File imageFile = File(imagePath);
       await _controller.takePicture().then((XFile value) async {
         tempimage = value.path;
         setState(() {
           iscamerapreview=true;
         });


        //  File fixedFile = await fixOrientation(File(path));
        //
        // Uint8List? resizedImage = await FlutterImageCompress.compressWithFile(fixedFile.path, quality: 75,autoCorrectionAngle: true,keepExif: true);
        //
        // // Save the resized image to the specified directory
        // await File(imagePath).writeAsBytes(resizedImage as List<int>);
        // // var filestring = await _flutterImageEditWatermarkPlugin.editImage(path!, text);
        // // if (filestring != null) {
        // //   // Compress and resize the edited image
        //
        //   debugPrint("Captured, edited, and resized image saved at: $imagePath");
        // // } else {
        // //   debugPrint("Failed to edit image.");
        // // }
        // debugPrint("captured image path ======> $path");
        //
        // Navigator.pop(context, {"result" : imagePath});
      });
    } catch (e) {
      debugPrint("Error taking picture: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Keep Camera in Portrait Mode",style: TextStyle(
              fontSize: 18.0,
              color: AppColors.whites,
              fontWeight: FontWeight.w500,
              fontFamily: 'poppins'),
          ),
        backgroundColor: AppColors.primaryColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          )
         ),
      body: Stack(
        children: <Widget>[
          ModalProgressHUD(

            inAsyncCall: isLoading,
            opacity: 0.5,
            child: isLoading ? const Center(child: CircularProgressIndicator()) :iscamerapreview? Positioned.fill(child: Image.file(
              File(tempimage),
             // width: double.infinity,
             // height: double.infinity,
              fit: BoxFit.fill, // Equivalent to android:scaleType="fitXY"
            ),):Positioned.fill(child:CameraPreview(_controller)),
          ),
          if(!iscamerapreview)
          Align(
            alignment: Alignment.bottomCenter,

            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child:  FloatingActionButton(
              onPressed: () {
                _takePicture(context);
              }, backgroundColor: Colors.transparent,
              shape: CircleBorder(),
              child: Icon(Icons.camera,size: 70,color: AppColors.primaryColor,),
            ),)
          ),
          if(iscamerapreview)
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(Icons.close, "Cancel", _cancel),
                _buildButton(Icons.rotate_right, "Rotate", _rotateImage),
                _buildButton(Icons.check, "Ok", _saveImage),
              ],
            ),
          )
        ],
      ),
    );

  }
  Widget _buildButton(IconData icon, String label, VoidCallback onPressed) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      onPressed: onPressed,
      icon: Icon(icon,color: AppColors.primaryColor,),
      label: Text(label,style: TextStyle(
          fontSize: 13.0,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w500,
          fontFamily: 'poppins'),),
    );
  }
  void _cancel() {
    setState(() {
      iscamerapreview=false;
    });
   // Navigator.pop(context);
  }
  int manualRotation = 0;

  Future<void> _rotateImage() async {
    print(manualRotation);
    manualRotation = (manualRotation + 90) % 360;
    final bytes = await File(tempimage).readAsBytes();
    final decodedImage = img.decodeImage(bytes);
    final rotated = img.copyRotate(decodedImage!, angle: manualRotation);
    final dir = await getTemporaryDirectory();
    final newPath = "${dir.path}/manually_rotated_${DateTime.now().millisecondsSinceEpoch}.jpg";
    final newFile = File(newPath);
    await newFile.writeAsBytes(img.encodeJpg(rotated));
    setState(() {
      tempimage = newFile.path;
    });
  }
  Future<void> _saveImage() async {
    // File fixedFile = await fixOrientation(File(path));

    Uint8List? resizedImage = await FlutterImageCompress.compressWithFile(tempimage, quality: 75,autoCorrectionAngle: true,keepExif: true);

    // Save the resized image to the specified directory
    await File(tempimage).writeAsBytes(resizedImage as List<int>);
    // var filestring = await _flutterImageEditWatermarkPlugin.editImage(path!, text);
    // if (filestring != null) {
    //   // Compress and resize the edited image

      debugPrint("Captured, edited, and resized image saved at: $tempimage");
    // } else {
    //   debugPrint("Failed to edit image.");
    // }
    debugPrint("captured image path ======> $tempimage");

    Navigator.pop(context, {"result" : tempimage});
  }
  // Future<File> fixExifRotation(String imagePath) async {
  //   final originalFile = File(imagePath);
  //   List<int> imageBytes = await originalFile.readAsBytes();
  //   Uint8List uint8List = Uint8List.fromList(imageBytes);
  //   final originalImage = img.decodeImage(uint8List);
  //
  //   if (originalImage == null) {
  //     throw Exception("Couldn't decode image");
  //   }
  //
  //   // Read the EXIF data to determine the orientation
  //   final exifData = await readExifFromBytes(imageBytes);
  //
  //   img.Image fixedImage = originalImage;
  //
  //   if (exifData!.isNotEmpty) {
  //     final orientation = exifData['Image Orientation'];
  //     if (orientation != null) {
  //       switch (orientation.values?.first) {
  //         case 3:
  //           fixedImage = img.copyRotate(originalImage,angle: 180);
  //           break;
  //         case 6:
  //           fixedImage = img.copyRotate(originalImage,angle: 90);
  //           break;
  //         case 8:
  //           fixedImage = img.copyRotate(originalImage,  angle: -90);
  //           break;
  //       }
  //     }
  //   }
  //
  //   // Save the fixed image
  //   final fixedFile = await originalFile.writeAsBytes(img.encodeJpg(fixedImage));
  //
  //   return fixedFile;
  // }
  Future<File> fixOrientation(File file) async {
    final Uint8List bytes = await file.readAsBytes();
    int rotation = 90;
    // Try reading EXIF metadata
//     final tags = await readExifFromBytes(bytes);
//      // fallback for portrait
//
//     if (tags!.containsKey('Image Orientation')) {
//       final orientation = tags['Image Orientation']?.printable;
// print("orientation:$orientation");
//       switch (orientation) {
//         case 'Rotated 90 CW':
//           rotation = 90;
//           break;
//         case 'Rotated 180':
//           rotation = 180;
//           break;
//         case 'Rotated 270 CW':
//           rotation = 270;
//           break;
//         default:
//           rotation = 0;
//       }
//     }

    final decoded = img.decodeImage(bytes);
    if (decoded == null) throw Exception("Unable to decode image");

    final rotated = img.copyRotate(decoded,angle: rotation);
    final rotatedBytes = Uint8List.fromList(img.encodeJpg(rotated));

    // final dir = await getTemporaryDirectory();
    // final newPath = path.join(dir.path, 'fixed_${DateTime.now().millisecondsSinceEpoch}.jpg');
    // final newFile = File(newPath);
    await file.writeAsBytes(rotatedBytes);
    return file;
  }
}
