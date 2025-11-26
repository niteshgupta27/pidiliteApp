import 'dart:io';

import 'package:birla/features/Detail/controller/MeetingDetailController.dart';
import 'package:flutter/services.dart';

import '../../../Utill/app_required.dart';
import '../../../Utill/custom_loader_widget.dart';

class MeetingDetailView extends GetView<MeetingDetailController> {
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
              "Meeting Details",
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
                    TextField(controller: controller.Actual_AttendanceController.value,keyboardType: TextInputType.number, // Numeric keyboard

                      decoration: InputDecoration(labelText: 'Actual Attendance',
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
                    TextField(controller: controller.Total_Gift_GivenController.value,keyboardType: TextInputType.number, // Numeric keyboard

                      decoration: InputDecoration(labelText: 'Total Gift Given (Optional)',
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
                    TextField(controller: controller.nonParticipantsController.value,keyboardType: TextInputType.number, // Numeric keyboard

                      decoration: InputDecoration(labelText: 'Non Participants',
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
                    Text(
                      "(Dealers / Workers / Client  Nebula Team)",
                      style:  Styles.inriaSansRegular,
                    ),
                    const SizedBox(height: 16),
                    TextField(controller: controller.Number_of_Orders_PlacedController.value,keyboardType: TextInputType.number, // Numeric keyboard

                      decoration: InputDecoration(labelText: 'Number of Orders Placed (Optional)',
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
                    Text(
                      "No. of Attendee who placed order",
                      style:  Styles.inriaSansRegular,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Gift Options',
                        labelStyle: const TextStyle(color: AppColors.fountGray),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)), // Default border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)), // Unfocused border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4), width: 2.0), // Focused border
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      value:controller.selectedGift, // Currently selected item
                      items: controller.giftOptions.map((String gift) {
                        return DropdownMenuItem<String>(
                          value: gift,
                          child: Text(gift),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          controller.selectedGift = newValue;
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(controller: controller.giftitemController.value, // Numeric keyboard

                      decoration: InputDecoration(labelText: 'Gift Item (Optional)',
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
                    TextField(controller: controller.remarkController.value, // Numeric keyboard
                      maxLines: 4,
                      decoration: InputDecoration(labelText: 'Remark (Optional)',
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
                    Text('Hotel Bill Photos', style: Styles.headerTitel,),
                    const SizedBox(height: 16),
                   Row(children: [promotionimage(context),traningimage(context)],),
                    const SizedBox(height: 16),


                    // Cancel and Submit Buttons
                    Row(
                      children: [
                        Expanded(child: SizedBox(height: 50, child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.fountGray, shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Set the radius here
                          ),),
                          onPressed: () {
                            Get.back(result: {"status": "success",});
                          },
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
      children: [
      if(controller.fld_p_image_path.value.contains("http"))
      Card(
      elevation: 5, // Equivalent to android:elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5), // Equivalent to cardCornerRadius
      ),
      child: Container(
        width: 175, // Equivalent to @dimen/_150sdp
        height: 175, // Equivalent to @dimen/_130sdp
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
            width: 175, // Equivalent to @dimen/_150sdp
            height: 175, // Equivalent to @dimen/_130sdp
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
            width: 175, // Equivalent to android:layout_width
            height: 175, // Equivalent to android:layout_height
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
      children: [
      if(controller.fld_t_image_path.value.contains("http"))
        Card(
          elevation: 5, // Equivalent to android:elevation
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), // Equivalent to cardCornerRadius
          ),
          child: Container(
            width: 175, // Equivalent to @dimen/_150sdp
            height: 175, // Equivalent to @dimen/_130sdp
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
            width: 175, // Equivalent to @dimen/_150sdp
            height: 175, // Equivalent to @dimen/_130sdp
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
            width: 175, // Equivalent to android:layout_width
            height: 175, // Equivalent to android:layout_height
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
                Text(
                  '(Optional)',
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