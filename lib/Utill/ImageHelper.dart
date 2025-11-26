import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import '../features/meeting/model/TableMeetingsModel.dart';
import 'app_storage.dart';
import 'package:image/image.dart' as img;

class ImageHelper {
  /// Process the image (Resize + Overlay Text)
 static Future<File> processImage(File imageFile, TableMeetingsModel meeting, String name) async {
    var appStorage = Get.find<AppStorage>();
    print("object image1");

    Uint8List imageBytes = await imageFile.readAsBytes();
    ui.Codec codec = await ui.instantiateImageCodec(imageBytes);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    ui.Image image = frameInfo.image;

    // Resize Image
    int newWidth = 765;
    int newHeight = 1020;
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    Paint paint = Paint();
    print("object image2");

    // Draw original image
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromLTWH(0, 0, newWidth.toDouble(), newHeight.toDouble()),
      paint,
    );
    print("object image3");

    // Get Location
    //String location = await _getLocation();
    String dateTime = DateFormat("dd-MM-yyyy hh:mm:ss a").format(DateTime.now());

    // Extract Dealer Names
    String dealers = meeting.dealers != null && meeting.dealers!.isNotEmpty
        ? meeting.dealers!.map((d) => d.fldRname ?? "Unknown Dealer").join(", ")
        : "No Dealer Assigned";

    // Text Overlay Content
    String textOverlay ="Name: $name\nLat: ${appStorage.lat} Long: ${appStorage.long}\nDate: $dateTime\nDealer: $dealers\nExecutive: ${appStorage.loggedInUser.username}";
    print("object image4");

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: textOverlay,
        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      textAlign: TextAlign.left,
      textDirection: ui.TextDirection.ltr, // Fix type issue
    );
    print("object image5");

    textPainter.layout();
    textPainter.paint(canvas, Offset(20, newHeight - 150));
    print("object image");

    // Save Image
    ui.Picture picture = recorder.endRecording();
    ui.Image finalImage = await picture.toImage(newWidth, newHeight);
    ByteData? byteData = await finalImage.toByteData(format: ui.ImageByteFormat.png);
    print("object image6");

    return _saveImage(byteData!.buffer.asUint8List(),newWidth,newHeight,70);
  }

  /// Get Location (Mocked - Replace with GPS Implementation)


  /// Save Image to Local Storage
  static Future<File> _saveImage(Uint8List bytes ,int width, int height, int quality) async {
    Directory directory = await getApplicationDocumentsDirectory();
    print("object image7 $directory");

    String timestamp = DateFormat("ddMMyyyy_HHmmss").format(DateTime.now());
    String filePath = "${directory.path}/image_$timestamp.png";
    File file = File(filePath);
    print("object image8${file.path}");
    // Convert RGBA Uint8List to `image` package format
   // img.Image image = img.Image.fromBytes(width: width, height: height, bytes: bytes.buffer);
    print("object image8");
    img.Image image = img.decodeImage(bytes)!;

    // Compress and save as JPEG
    List<int> compressedBytes = img.encodeJpg(image, quality: quality);
    await file.writeAsBytes(compressedBytes);
    print("object image9");

    return file;
  }

  /// Convert Image to Base64
  static Future<String> convertToBase64(File imageFile) async {
    Uint8List imageBytes = await imageFile.readAsBytes();
    return base64Encode(imageBytes);
  }
}
