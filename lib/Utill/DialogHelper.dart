
import 'dart:ui';

import 'package:pidilite/Utill/app_required.dart';
import 'package:get/get_core/src/get_main.dart';

class DialogHelper {
  // Reusable delete confirmation dialog
  static void showDeleteDialog({
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) {
    Get.defaultDialog(
      title: title,
      titleStyle: TextStyle(fontWeight: FontWeight.bold),
      middleText: content,
      middleTextStyle: TextStyle(color: Colors.grey[700]),
      barrierDismissible: false, // Prevent dismiss on outside touch
      contentPadding: EdgeInsets.all(16),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Cancel Button
            ElevatedButton(
              onPressed: () {
                Get.back(); // Close the dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // 5 radius
                ),
              ),
              child: Text("Cancel"),
            ),
            // Delete Button
            ElevatedButton(
              onPressed: () {
                onConfirm(); // Execute confirm action
                Get.back(); // Close the dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // 5 radius
                ),
              ),
              child: Text("Delete"),
            ),
          ],
        ),
      ],
    );
  }
}