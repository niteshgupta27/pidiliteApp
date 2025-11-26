import 'package:birla/features/Photos/controller/MeetingPhotosListController.dart';

import '../../../Utill/app_required.dart';
import '../../../Utill/custom_loader_widget.dart';
import '../../meeting/SearchKeyWidget.dart';

class MeetingPhotosList extends GetView<MeetingPhotosListController> {
RxList _contacts = [].obs;
RxList _filteredContacts = [].obs;

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
        //resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor,),
            onPressed: () => Get.back(),
          ),
          title: Text(
            controller.meeting.value.fldLocation!,
            style: Styles.headerTitel,
          ),
          backgroundColor: Colors.white,
          elevation: 5,
          shadowColor: AppColors.gray.withOpacity(0.5),
          surfaceTintColor: Colors.transparent,
        ),
        body: controller.isLoading == true ? CustomLoaderWidget(color: AppColors.primaryColor,) :  Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

    // Horizontal List for Each Group
    SizedBox(
    height: 50, // Adjust height as needed
    child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount:controller.groupedMeetings.keys.length,
    itemBuilder: (context, index) {
      String category = controller.groupedMeetings.keys.elementAt(index);
      bool isSelected = category == controller.selectedCategory.value;

      return InkWell(onTap:(){controller.selectedCategory.value = category;controller.getimagedata();controller.selected.value=index;},child: Container(
    width: 120, // Adjust card width
    //margin: EdgeInsets.only(right: 5),
    decoration: BoxDecoration(
      //color: isSelected ? Colors.blueAccent : Colors.grey.shade300,
    borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
    child: Padding(
    padding: const EdgeInsets.all(5.0),
    child: Text(
      category, // Show purpose
   // style: TextStyle(color: isSelected ?AppColors.primaryColor:AppColors.fountGray),
      style: Styles.inriaSansRegular.copyWith(
        fontSize: Dimensions.fontSizeLarge17,
        fontWeight: isSelected
            ? FontWeight.w600
            : FontWeight.w400,
        color: isSelected
            ? AppColors.primaryColor
            : AppColors.fountGray,
      ),
    textAlign: TextAlign.center,
    ),
    ),
    ),
    ));
    },
    ),
    ),



                  const SizedBox(height: 5),
                  Expanded(
                      child:ListView(
                    shrinkWrap: true, // ✅ Prevent infinite height error
                   // physics: NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(top: 5,bottom: 40),
                    children: controller.groupedMeetingsimages.entries.map((entry) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// 🟢 Section Title (Purpose)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
                            child: Text(
                              entry.key, // Purpose Title
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),

                          /// 🟡 Horizontal List of Images + Text
                      GridView.builder(
                      itemCount: entry.value.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Number of columns in the grid
                      crossAxisSpacing: 8, // Horizontal spacing
                      mainAxisSpacing: 8, // Vertical spacing
                      childAspectRatio: 1, // Ensures square items
                      ),
                      shrinkWrap: true, // Ensures GridView only takes necessary space
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                                final imageItem = entry.value[index];

                                return Container(
                                  width: 120, // Width of each item
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  child:  Stack(
                                    children: [
                                      /// 🔵 Image
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          imageItem.imageUrl ?? '',
                                          height: 120,
                                          width: 120,
                                          fit: BoxFit.fill,
                                          errorBuilder: (context, error, stackTrace) =>
                                              Icon(Icons.broken_image, size: 50),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap:()=> controller.deleteNoteAt(imageItem.id!), // Handle delete action
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
                                );
                              },
                            ),

                          SizedBox(height: 5), // Spacing between sections
                        ],
                      );
                    }).toList(),
                  ))
                  // Cancel and Submit Buttons

                ],
              ),
            ),
        floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print(controller.groupedMeetings[controller.selectedCategory.value]);
          final result= await Get.toNamed(Routes.AddmeetingPhotos,arguments: {"data":controller.meeting.value.toJson(),"cat":controller.groupedMeetings[controller.selectedCategory.value]});
          print("Result received from AddNotes: $result");
          if(result !=null){
            controller.CallGetdata();
          }
      // Handle adding new photo logic
    },
          backgroundColor: AppColors.primaryColor,
          shape: CircleBorder(),
    child: Icon(Icons.add,color: AppColors.whites,size: 42,),
    ),
    );
  });

}}