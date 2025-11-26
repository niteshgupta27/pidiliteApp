import 'dart:io';

import 'package:birla/features/Start/controller/MeetingStartController.dart';
import 'package:flutter/services.dart';

import '../../../Utill/app_required.dart';
import '../../../Utill/custom_loader_widget.dart';

class MeetingStartView extends GetView<MeetingStartController> {
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
              "Training Start",
              style: Styles.headerTitel,
            ),
            backgroundColor: Colors.white,
            elevation: 5,
            shadowColor: AppColors.gray.withOpacity(0.5),
            surfaceTintColor: Colors.transparent,
          ),
          body: controller.isLoading == true ? CustomLoaderWidget(color: AppColors.primaryColor,) : SingleChildScrollView(keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,

              child: Padding(
                padding: const EdgeInsets.all(26.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.all(5),child:  Text(
                      controller.meeting.value.fldLocation!,
                      style:  Styles.headerTitel,
                    ),),
                    const SizedBox(height: 16),
                    TextField(controller: controller.Hotel_NameController.value,
                      decoration: InputDecoration(labelText: 'Hotel Name',
                        labelStyle: const TextStyle(color: AppColors.fountGray),
                        // Change label color
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)), // Default border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)), // Unfocused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4), width: 2.0), // Focused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),),
                      // onChanged: (value) => controller.noteTitle.value = value,
                    ),
                    const SizedBox(height: 16),
                    TextField(controller: controller.Hotel_manager_NameController.value,

                      decoration: InputDecoration(labelText: 'Hotel Manager Name',
                        labelStyle: const TextStyle(color: AppColors.fountGray),
                        // Change label color
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)), // Default border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)), // Unfocused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4), width: 2.0), // Focused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),),
                      // onChanged: (value) => controller.noteDescription.value = value,
                    ),
                    const SizedBox(height: 16),
                    TextField(controller: controller.Hotel_manager_NumberController.value,keyboardType: TextInputType.number, // Numeric keyboard
                      maxLength: 10, // Limit to 10 digits
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(labelText: 'Hotel Manager Number',
                        labelStyle: const TextStyle(color: AppColors.fountGray),
                        // Change label color
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)), // Default border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)), // Unfocused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4), width: 2.0), // Focused border color
                          borderRadius: BorderRadius.circular(8.0),
                        ),),
                      // onChanged: (value) => controller.noteDescription.value = value,
                    ),
                    const SizedBox(height: 16),
                    promotionimage(context),
                    const SizedBox(height: 16),
                    traningimage(context),
                    const SizedBox(height: 16),
bussniusimage(context),
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
              ))
      );
    });

  }
  Widget promotionimage(BuildContext context){
    return InkWell(onTap:()=>controller.takePhoto("p",context),child: Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text('Team Selfie photo', style: Styles.headerTitel,),
      if(controller.fld_p_image_path.value.contains("http"))
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
              child: Image.network(
                controller.fld_p_image_path.value,
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
      if(!controller.fld_p_image_path.value.contains("http")&& controller.fld_p_image_path.value.isNotEmpty)
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
  Widget traningimage(BuildContext context){
    return InkWell(onTap:()=>controller.takePhoto("t",context),child:Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text('Training Hotel Photo', style: Styles.headerTitel,),
      if(controller.fld_t_image_path.value.contains("http"))
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
                  child: Image.network(
                    controller.fld_t_image_path.value,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fill, // Equivalent to android:scaleType="fitXY"
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap:()=> controller.deleteNoteAt("t"), // Handle delete action
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
      if(!controller.fld_t_image_path.value.contains("http")&& controller.fld_t_image_path.value.isNotEmpty)
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
                  child: Image.file(
                    File(controller.fld_t_image_path.value),
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fill, // Equivalent to android:scaleType="fitXY"
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap:()=> controller.deleteNoteAt("t"), // Handle delete action
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
      if(controller.fld_t_image_path.value.isEmpty)
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
  Widget bussniusimage(BuildContext context){
    return InkWell(onTap:()=>controller.takePhoto("c",context),child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text('Photo of Hotel Business Card or Hotel Quote', style: Styles.headerTitel,),
      if(controller.fld_c_image_path.value.contains("http"))
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
                  child: Image.network(
                    controller.fld_c_image_path.value,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fill, // Equivalent to android:scaleType="fitXY"
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap:()=> controller.deleteNoteAt("c"), // Handle delete action
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
                          topRight: Radius.circular(0),   // android:topRightRadius="6dp"
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
      if(!controller.fld_c_image_path.value.contains("http")&& controller.fld_c_image_path.value.isNotEmpty)
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
                    File(controller.fld_c_image_path.value),
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fill, // Equivalent to android:scaleType="fitXY"
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap:()=> controller.deleteNoteAt("c"), // Handle delete action
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
                          topRight: Radius.circular(0),   // android:topRightRadius="6dp"
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
      if(controller.fld_c_image_path.value.isEmpty)
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