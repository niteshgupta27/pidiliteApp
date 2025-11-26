
import '../../../Utill/app_required.dart';
import '../../../Utill/custom_loader_widget.dart';
import '../controller/AttendeeController.dart';

class AttendeeView extends GetView<AttendeeController>  {
  // final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.whites,

      appBar: AppBar(
        leading: Row(children: [IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primaryColor,size: 30,),
          onPressed: () {
            Get.back();
          },

        ),Text('Attendee ${controller.appStorage.loggedInUser.username}',style: Styles.headerTitel,),]),
        backgroundColor: Colors.white,
        elevation: 5,
        leadingWidth: 200,
        iconTheme:  const IconThemeData(size: 37, color: AppColors.primaryColor),
        shadowColor: AppColors.gray.withOpacity(0.5),
        surfaceTintColor: Colors.transparent,
      ),

      body:  Obx(() {return controller.isLoading==true?CustomLoaderWidget(color: AppColors.primaryColor,):Column(
                children: [
                  if(!controller.ShowAttendeesnote.value)
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Container(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Please update the attendee's with ✏️",
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),InkWell(onTap:()=>controller.attendeeRefesh(),child: Padding(
                    padding: EdgeInsets.all(12), // Ensure proper touch area
                    child: Icon(Icons.refresh, color: AppColors.fountGray),
                  ),)],),
                  
                  Row(
                    children: [
                      // Product Button
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.onButtonPressed(0),
                          child: Container(
                            height: Dimensions.x40,
                            margin: const EdgeInsets.only(
                                top: Dimensions.x20,
                                right: Dimensions.x10,
                                left: Dimensions.x20,
                                bottom: Dimensions.x30
                            ),
                            decoration: BoxDecoration(
                              color: controller.selectedIndex == 0 ? AppColors.primaryColor : AppColors.whites,
                              borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
                              border: Border.all(color: AppColors.primaryColor),
                            ),
                            child: Center(
                              child: Text(
                                'Pending',
                                style: Styles.inriaSansBold.copyWith(fontSize: Dimensions.fontSizeMedium,
                                  color: controller.selectedIndex == 0
                                      ? AppColors.whites
                                      : AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.onButtonPressed(1),
                          child: Container(
                            height: Dimensions.x40,
                            margin: const EdgeInsets.only(
                              top: Dimensions.x20,
                              bottom: Dimensions.x30,
                              right: Dimensions.x20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radiusSizeSmall),
                              border: Border.all(color: AppColors.primaryColor),
                              color: controller.selectedIndex == 1 ? AppColors.primaryColor : AppColors.whites,
                            ),
                            child: Center(
                              child: Text(
                                'Completed',
                                style: Styles.inriaSansBold.copyWith(
                                  fontSize: Dimensions.fontSizeMedium,
                                  color: controller.selectedIndex == 1 ? AppColors.whites : AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: controller.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.pages.length,
                      itemBuilder: (context, index) {
                        return controller.pages[controller.selectedIndex.value];
                      },
                      onPageChanged: (value) {
                        controller.selectedIndex.value = value;
                      },
                    ),
                  ),
                ],);
      }),
      floatingActionButton: FloatingActionButton(
          onPressed:()=> controller.addAttendee(),
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.add,color: AppColors.whites,size: 42,),
          shape: CircleBorder()
      ),
    );
  }
}
