import 'dart:io';

import 'package:flutter/services.dart';

import '../../../Utill/app_required.dart';
import '../../../Utill/custom_loader_widget.dart';
import '../../meeting/model/TableMeetingsModel.dart';
import '../controller/AddAttendee3Controller.dart';
import '../model/RoleModel.dart';

class AddAttendee3View extends GetView<AddAttendee3Controller> {

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
              "Attendee Details ${controller.appStorage.loggedInUser.username}",
              style: Styles.headerTitel,
            ),
            backgroundColor: Colors.white,
            elevation: 5,
            shadowColor: AppColors.gray.withOpacity(0.5),
            surfaceTintColor: Colors.transparent,
          ),
          body: controller.isLoading == true ? CustomLoaderWidget(color: AppColors.primaryColor,) : SingleChildScrollView(keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,

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
                    TextField(controller: controller.Painter_NameController.value,
                      decoration: InputDecoration(labelText: 'Painter Name',
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
                    TextField(controller: controller.Phone_NumberController.value,
                      maxLength: 10, // Limit to 10 digits
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Phone Number',
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
                    // TextField(controller: controller.Pan_CardController.value,
                    //   maxLength: 30, // Limit to 10 digits
                    //
                    //   decoration: InputDecoration(labelText: 'Pan Card (Optional)',
                    //     labelStyle: const TextStyle(color: AppColors.fountGray),
                    //     // Change label color
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)), // Default border
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)), // Unfocused border color
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4), width: 2.0), // Focused border color
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),),
                    //   // onChanged: (value) => controller.noteDescription.value = value,
                    // ),
              Padding(padding: EdgeInsets.only(left: 5,right: 5),child:  Text(
                "Participant?",
                style:  Styles.headerTitel,
              ),),
              const SizedBox(height: 5),
              Wrap(
                spacing: 0,
                children: controller.radiooptions.map((tag) {
                  // final isSelected = controller.selectedTags.contains(tag);
                  return RadioListTile<String>(
                    title: Text(tag),
                    value: tag,
                    groupValue: controller.participantOption.value,
                    onChanged: (String? value) {
                      controller.participantOption.value = value!;
                    },
                    contentPadding: EdgeInsets.zero, // Removes extra padding
                    visualDensity: VisualDensity.compact, // Reduces spacing
                  );
                }).toList(),
              ),
              if(controller.participantOption.value=="Yes")
        Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    // const SizedBox(height: 16),
                    // TextField(controller: controller.QualificationController.value,
                    //   decoration: InputDecoration(labelText: 'Qualification (Optional)',
                    //     labelStyle: const TextStyle(color: AppColors.fountGray),
                    //     // Change label color
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)), // Default border
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)), // Unfocused border color
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4), width: 2.0), // Focused border color
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),),
                    //   // onChanged: (value) => controller.noteDescription.value = value,
                    // ),
          const SizedBox(height: 16),
          Padding(padding: EdgeInsets.all(5),child:  Text(
            "Contractor?",
            style:  Styles.headerTitel,
          ),),
          const SizedBox(height: 5),
          Wrap(
            spacing: 0,
            children: controller.radiooptions.map((tag) {
              // final isSelected = controller.selectedTags.contains(tag);
              return RadioListTile<String>(
                title: Text(tag),
                value: tag,
                groupValue: controller.Contractoroption.value,
                onChanged: (String? value) {
                  controller.Contractoroption.value = value!;
                },
                contentPadding: EdgeInsets.zero, // Removes extra padding
                visualDensity: VisualDensity.compact, // Reduces spacing
              );
            }).toList(),
          ),
          if(controller.Contractoroption.value=="Yes")
            Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
              const SizedBox(height: 16),
              TextField(controller: controller.teamSizeController.value,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Painters Team Size',
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
              TextField(controller: controller.sitesController.value,keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Painters Number of Site',
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
              ),]),
                    const SizedBox(height: 16),
                    Padding(padding: EdgeInsets.all(5),child:  Text(
                      "Smartphone?",
                      style:  Styles.headerTitel,
                    ),),
                    const SizedBox(height: 5),
                    Wrap(
                      spacing: 0,
                      children: controller.radiooptions.map((tag) {
                        // final isSelected = controller.selectedTags.contains(tag);
                        return RadioListTile<String>(
                          title: Text(tag),
                          value: tag,
                          groupValue: controller.smartphoneOption.value,
                          onChanged: (String? value) {
                            controller.smartphoneOption.value = value!;
                          },
                          contentPadding: EdgeInsets.zero, // Removes extra padding
                          visualDensity: VisualDensity.compact, // Reduces spacing
                        );
                      }).toList(),
                    ),
                    if(controller.smartphoneOption.value=="Yes"  && controller.Contractoroption.value=="Yes")
                    Column(crossAxisAlignment: CrossAxisAlignment.start,children: [ const SizedBox(height: 16),
                      Padding(padding: EdgeInsets.all(5),child:  Text(
                        "${AppConstants.otherApp} downloaded by Nebula Person?",
                        style:  Styles.headerTitel,
                      ),),
                      const SizedBox(height: 5),
                      Wrap(
                        spacing: 0,
                        children: controller.radiooptions.map((tag) {
                          // final isSelected = controller.selectedTags.contains(tag);
                          return RadioListTile<String>(
                            title: Text(tag),
                            value: tag,
                            groupValue: controller.DownloadApp.value,
                            onChanged: (String? value) {
                              controller.DownloadApp.value = value!;
                            },
                            contentPadding: EdgeInsets.zero, // Removes extra padding
                            visualDensity: VisualDensity.compact, // Reduces spacing
                          );
                        }).toList(),
                      ),],),
      if(controller.smartphoneOption.value=="Yes"&&controller.DownloadApp.value=="No"  && controller.Contractoroption.value=="Yes")
      Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    const SizedBox(height: 16),
                    Padding(padding: EdgeInsets.all(5),child:  Text(
                      "${AppConstants.otherApp} downloaded earlier by Painter?",
                      style:  Styles.headerTitel,
                    ),),
                    const SizedBox(height: 5),
                    Wrap(
                      spacing: 0,
                      children: controller.radiooptions.map((tag) {
                        // final isSelected = controller.selectedTags.contains(tag);
                        return RadioListTile<String>(
                          title: Text(tag),
                          value: tag,
                          groupValue: controller.PolisherApp.value,
                          onChanged: (String? value) {
                            controller.PolisherApp.value = value!;
                          },
                          contentPadding: EdgeInsets.zero, // Removes extra padding
                          visualDensity: VisualDensity.compact, // Reduces spacing
                        );
                      }).toList(),
                    ),]),
      if(controller.smartphoneOption.value=="Yes"&&controller.DownloadApp.value=="No"&&controller.PolisherApp.value=="No"  && controller.Contractoroption.value=="Yes")
      Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    const SizedBox(height: 16),
                    TextField(controller: controller.ReasonController.value,
                      decoration: InputDecoration(labelText: 'Reason for ${AppConstants.otherApp} not download',
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
                    ),]),
                   ]),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<Dealer>(value: controller.selectedDealer.value,
                      decoration: InputDecoration(
                        labelText: "Dealer",
                        labelStyle: const TextStyle(color: AppColors.fountGray),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4), width: 2.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      items: controller.dealers.map((Dealer dealer) {
                        return DropdownMenuItem<Dealer>(
                          value: dealer,
                          child: Text(dealer.fldRname ?? 'Unknown'),
                        );
                      }).toList(),
                      onChanged: (Dealer? value) {
                        controller.selectedDealer.value = value!;
                        controller.DealerCodeController.value.text=value.fldRcode!;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(controller: controller.DealerCodeController.value,keyboardType: TextInputType.number,readOnly: true,
                      decoration: InputDecoration(labelText: 'Dealer Code',
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
      if(controller.participantOption.value=="Yes")
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,children: [
                    Padding(padding: EdgeInsets.all(5),child:  Text(
                      "Order Placed",
                      style:  Styles.headerTitel,
                    ),),
                    const SizedBox(height: 5),
                    Wrap(
                      spacing: 0,
                      children: controller.radiooptions.map((tag) {
                        // final isSelected = controller.selectedTags.contains(tag);
                        return RadioListTile<String>(
                          title: Text(tag),
                          value: tag,
                          groupValue: controller.orderoption.value,
                          onChanged: (String? value) {
                            controller.orderoption.value = value!;
                          },
                          contentPadding: EdgeInsets.zero, // Removes extra padding
                          visualDensity: VisualDensity.compact, // Reduces spacing
                        );
                      }).toList(),
                    ),]),
      if(controller.orderoption.value=="Yes")
      Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    const SizedBox(height: 16),
                    TextField(controller: controller.orderValueController.value,keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Order Value (optional)',
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
        TextField(controller: controller.orderDeailController.value,keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Order Details',
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
        ),]),
                    // const SizedBox(height: 16),
                    // TextField(controller: controller.GiftGivenController.value,
                    //   decoration: InputDecoration(labelText: 'Gift Given ',
                    //     labelStyle: const TextStyle(color: AppColors.fountGray),
                    //     // Change label color
                    //     border: OutlineInputBorder(
                    //       borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)), // Default border
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)), // Unfocused border color
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4), width: 2.0), // Focused border color
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),),
                    //   // onChanged: (value) => controller.noteDescription.value = value,
                    // ),
                    if(controller.participantOption.value=="No")
                      Column(children: [ const SizedBox(height: 16),
                        DropdownButtonFormField<RoleModel>(value: controller.selectedRoll.value,
                          decoration: InputDecoration(
                            labelText: "Who is Non Participant?",
                            labelStyle: const TextStyle(color: AppColors.fountGray),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4)),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.fountGray.withOpacity(0.4), width: 2.0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          items: controller.rolluser.map((RoleModel dealer) {
                            return DropdownMenuItem<RoleModel>(
                              value: dealer,
                              child: Text(dealer.fldRole ?? 'Unknown'),
                            );
                          }).toList(),
                          onChanged: (RoleModel? value) {
                            controller.selectedRoll.value = value!;
                            //controller.DealerCodeController.value.text=value.fldRcode!;
                          },
                        ),
                      ],),
                    const SizedBox(height: 16),
                    TextField(controller: controller.competition_pointsController.value,
                      decoration: InputDecoration(labelText: 'competition points (Optional)',
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
                    TextField(controller: controller.remark1Controller.value,
                      decoration: InputDecoration(labelText: 'Remarks 1 (Optional)',
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
                    TextField(controller: controller.remark2Controller.value,
                      decoration: InputDecoration(labelText: 'Remarks 2 (Optional)',
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
                    TextField(controller: controller.remark3Controller.value,
                      decoration: InputDecoration(labelText: 'Remarks 3 (Optional)',
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
                    const SizedBox(height: 26),
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

}