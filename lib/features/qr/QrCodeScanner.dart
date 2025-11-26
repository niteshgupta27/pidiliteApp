import 'package:mobile_scanner/mobile_scanner.dart';

import '../../Utill/Apputills.dart';
import '../../Utill/app_base_client.dart';
import '../../Utill/app_required.dart';
class QrCodeScannerPage extends StatefulWidget {
  final int meetingId; // Add a field to hold the meeting ID
  final String Userid;
  QrCodeScannerPage({Key? key, required this.meetingId,required this.Userid}) : super(key: key);

  @override
  _QrCodeScannerPageState createState() => _QrCodeScannerPageState();
}

class _QrCodeScannerPageState extends State<QrCodeScannerPage> {

  final MobileScannerController controller = MobileScannerController();
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: isLoading==true ?  const Center(child: CircularProgressIndicator()) :Stack(
        children: [
          // Semi-transparent background
          Container(
            color: Colors.black
          ),
          // Centered scanner area

          Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 190,horizontal: 50),

              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 2), // Optional: Add a border for better visibility
              ),
              child: MobileScanner(
                controller: controller,
                onDetect: (BarcodeCapture capture) {
                  final List<Barcode> barcodes = capture.barcodes;

                  for (final barcode in barcodes) {
                    print(barcode.rawValue);
                    handleScanResult(barcode);
                  }
                },
              ),
            ),
          ),
          // Custom overlay to create a transparent cutout
          CustomPaint(
            painter: ScannerOverlay(
              scanWindow: Rect.fromCenter(
                center: MediaQuery.of(context).size.center(Offset.infinite),
                width: 600,
                height:  600,
              ),
            ),
          ),

        ],
      ),
    );
  }
  void handleScanResult(Barcode scanData) {
    String scannedText = scanData.rawValue ?? '';
    List<String> arrstring = scannedText.split("-");

    // Assuming meetings is an object that has a method getFldMId() which returns an integer
    // and mFunSignIn is a method you want to call if the IDs match
    if(widget.meetingId == int.tryParse(arrstring[0])){
      setState(() {
        isLoading=true;
      });
      mFunSignIn(scannedText);
    }
    else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text("Invalid Meeting User"))
      // );
      // Assuming finish() is a method to close the current page, you can use Navigator to pop the page
      Navigator.of(context).pop();
    }
  }
  Future<void> mFunSignIn(String scannedText) async {
    // Your implementation here
    var requestBody = {
      'user_id': widget.Userid,
      'qr_value':scannedText,
    };
    try {
      final response = await BaseClient.sharedClient.postRequest(
          endPoint: AppConstants.attendance,body:requestBody );
     if(response['success']==true){
       setState(() {
         isLoading=false;
       });
       Navigator.of(context).pop();
     }else{
       AppUtils.showSnackbar(response['message'],"Error");
       setState(() {
         isLoading=false;
       });
     }
    } catch (exception) {
      print("response=====$exception");
      rethrow;
    }
  }
}
class ScannerOverlay extends CustomPainter {
  final Rect scanWindow;

  ScannerOverlay({required this.scanWindow});

  @override
  void paint(Canvas canvas, Size size) {
    // Create a path for the entire screen
    final backgroundPath = Path()..addRect(Rect.largest);

    // Create a path for the scan window
    final cutoutPath = Path()..addRect(scanWindow);

    // Create a combined path with the cutout
    final combinedPath = Path.combine(PathOperation.difference, backgroundPath, cutoutPath);

    // Paint the combined path with a semi-transparent color
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    canvas.drawPath(combinedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}