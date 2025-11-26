import 'dart:io';

import 'package:birla/features/Photos/controller/AddMeetingPhotosController.dart';
import 'package:birla/features/Start/controller/MeetingStartController.dart';
import 'package:flutter/services.dart';

import '../../../Utill/app_required.dart';
import '../../../Utill/custom_loader_widget.dart';
import '../model/MeetingPhotoTypesResponse.dart';

class AddMeetingPhotosView extends GetView<AddMeetingPhotosController> {
  RxList _contacts = [].obs;
  RxList _filteredContacts = [].obs;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bottomInsets = MediaQuery
        .of(context)
        .viewInsets
        .bottom;
    // controller.onInit();
    return Obx(() {
      return Scaffold(
          backgroundColor: AppColors.whites,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor,),
              onPressed: () => Get.back(),
            ),
            title: Text(
              "Meeting Photos",
              style: Styles.headerTitel,
            ),
            backgroundColor: Colors.white,
            elevation: 5,
            shadowColor: AppColors.gray.withOpacity(0.5),
            surfaceTintColor: Colors.transparent,
          ),
          body: controller.isLoading == true ? CustomLoaderWidget(color: AppColors.primaryColor,) :
      Padding(
          padding: const EdgeInsets.all(26.0),
      child: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   // const SizedBox(height: 5),

                    Padding(padding: EdgeInsets.all(5),child:  Text(
                      "Photo Type",
                      style:  Styles.headerTitel,
                    ),),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 0,
                      runSpacing: 0,
                      children: controller.data.map((tag) {
                        return RadioListTile<MeetingPhotoTypesData>(
                          title: Text(
                            tag.fldPurpose,
                            style: TextStyle(fontSize: 14, height: 1), // smaller & tighter
                          ),
                          value: tag,
                          groupValue: controller.selectedOption.value,
                          onChanged: (MeetingPhotoTypesData? value) {
                            controller.selectedOption.value = value;
                          },
                          contentPadding: EdgeInsets.zero, // remove padding
                          visualDensity: VisualDensity(horizontal: -3, vertical: -3), // shrink space
                         // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // reduce touch area
                          dense: true, // makes list tile more compact
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    promotionimage(context),
                    const SizedBox(height: 16),

                    // Cancel and Submit Buttons
                    Row(
                      children: [
                        Expanded(child: SizedBox(height: 50, child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.fountGray, shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Set the radius here
                          ),),
                          onPressed: () {Get.back(result: {"status": "success",});},
                          child: Text("CANCEL".tr, style: const TextStyle(color: AppColors.whites),),
                        ),)

                        ),
                        const SizedBox(width: 10),
                        Expanded(
                            child: SizedBox(height: 50, child: ElevatedButton(

                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor, shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // Set the radius here
                              ),),
                              onPressed: () {
                                controller.validateAndProcess();
                              },
                              child: Text(
                                "SUBMIT".tr,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),)

                        ),
                      ],
                    )
                  ],
                ),
              )
      ));
    });

  }
  Widget promotionimage(BuildContext context){
    return InkWell(onTap:()=>controller.takePhoto("p",context),child: Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        if( controller.fld_p_image_path.value.isNotEmpty)
          Card(
            elevation: 5, // Equivalent to android:elevation
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5), // Equivalent to cardCornerRadius
            ),
            child: Container(
              width: 190, // Equivalent to @dimen/_150sdp
              height: 190, // Equivalent to @dimen/_130sdp
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child:  Image.file(
                      File(controller.fld_p_image_path.value),
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.fill, // Equivalent to android:scaleType="fitXY"
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap:()=> controller.deleteNoteAt("p"), // Handle delete action
                      child: Container(
                        width: 30, // Equivalent to @dimen/_30sdp
                        height: 30, // Equivalent to @dimen/_30sdp
                        decoration: BoxDecoration(
                          color: Colors.white, // Equivalent to android:color="@color/white"
                          border: Border.all(
                            color: Colors.white, // Equivalent to android:stroke
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),  // android:topLeftRadius="20dp"
                            topRight: Radius.circular(6),   // android:topRightRadius="6dp"
                            bottomLeft: Radius.circular(0), // android:bottomLeftRadius="0dp"
                            bottomRight: Radius.circular(0),// android:bottomRightRadius="0dp"
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Image.asset(
                          Images.delete_icon, // Equivalent to @drawable/delete_icon
                          width: 15, // Equivalent to @dimen/_15sdp
                          height: 15, // Equivalent to @dimen/_15sdp
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        if(controller.fld_p_image_path.value.isEmpty)
          Card(
            elevation: 5, // Equivalent to android:elevation
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5), // Equivalent to cardCornerRadius
            ),
            child: Container(
              width: 190, // Equivalent to android:layout_width
              height: 190, // Equivalent to android:layout_height
              padding: const EdgeInsets.all(10), // Equivalent to android:padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Equivalent to android:gravity="center"
                children: [
                  Image.asset(
                    Images.camera, // Equivalent to android:src="@drawable/camera"
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(height: 10), // Equivalent to android:layout_marginVertical
                  Text(
                    'Take Photo',
                    style: TextStyle(
                      fontFamily: 'Poppins-SemiBold', // Equivalent to android:fontFamily
                      fontSize: 14, // Equivalent to textSize
                      color: AppColors.primaryColor, // Equivalent to android:textColor="@color/primary"
                    ),
                  ),
                ],
              ),
            ),
          )
      ],));
  }
}