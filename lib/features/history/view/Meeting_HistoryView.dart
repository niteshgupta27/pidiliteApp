import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../Utill/app_required.dart';
import '../../meeting/model/TableMeetingsModel.dart';
import '../../menu/SidebarMenu.dart';

import '../controller/Meeting_HistoryController.dart';



class Meeting_HistoryView extends GetView<Meeting_HistoryController> {
  Meeting_HistoryView({super.key});

  @override
  Widget build(BuildContext context) {

    final ScrollController scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appBarColorNotifier.value = AppColors.primaryColor;
    });
    return Scaffold(
      drawer:  SidebarMenu(),

      backgroundColor: AppColors.whites,
      appBar:
            AppBar(
              //backgroundColor: Colors.transparent, // Make AppBar transparent
              elevation: 0,
              // leading: IconButton(
              //   icon: Icon(Icons.menu, color: Colors.white),
              //   onPressed: () {
              //     // Open drawer or add functionality
              //   },
              // ),
              title: Text(
                "welcome ${controller.appStorage.loggedInUser.username}",
                style:  Styles.PageTitle,
              ),
              centerTitle: false,
              iconTheme:  IconThemeData(size: 37, color: AppColors.whites),

            ),

      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child:Obx(() =>controller.isLoading.value ?  const Center(child: CircularProgressIndicator()) : Center(
              child: Container(
               // color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //headerMedile(),
                    // Center(
                    //   child: Stack(
                    //     children: [
                    //       // Background image
                    //       CustomPaint(
                    //         size: const Size(170, 30),
                    //         painter: ShapePainter(Colore: AppColors.primaryColor),
                    //       ),
                    //
                    //       // Your Container with the discount label
                    //       Positioned.fill(
                    //         child: Text(
                    //           '',
                    //           textAlign: TextAlign.center,
                    //           style: Styles.inriaSansBold.copyWith(
                    //               color: AppColors.whites,
                    //               fontSize: Dimensions.fontSizeLarge),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                   // SearchKeyWidget(items: controller.tages, onTap: (index) {},),
                    ListView(
                      shrinkWrap: true, // ✅ Prevent infinite height error
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(top: 5,bottom: 40),
                      children: controller.groupedMeetings.entries.map((entry) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// 🟢 Section Title (Purpose)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
                              child: Text(
                                entry.key!, // Purpose Title
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),

                            /// 🟡 Horizontal List of Images + Text
                            ListView.separated(
                              itemCount: entry.value.length,

                              shrinkWrap: true, // Ensures GridView only takes necessary space
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final imageItem = entry.value[index];

                                return meetingitem(context,imageItem);
                              },
                              separatorBuilder: (context,index) {
                                return const SizedBox(height: Dimensions.x0_6);
                              },
                            ),

                            //SizedBox(height: 5), // Spacing between sections
                          ],
                        );
                      }).toList(),
                    ),

                    // Column(
                    //   children: _buildDynamicRowsproductSlider(context), // Generate rows dynamically from data
                    // ),
                    const SizedBox(height: Dimensions.x36),

                    // OR continue with text
                    // Text(
                    //   '-- Powered By --',
                    //   textAlign: TextAlign.center,
                    //   style: Styles.inriaSansBold.copyWith(
                    //     fontSize: Dimensions.fontSizeLarge,
                    //     color: const Color(0xFF626262),
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),

                    const SizedBox(height: Dimensions.x16),


                    // Terms & Conditions
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Image.asset(Images.poweredby)
                    ),
                    const SizedBox(height: Dimensions.x0_8),

                    Text(
                      "App Version ${controller.appName.value}",
                      textAlign: TextAlign.center,
                      style: Styles.inriaSansBold.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                        color: const Color(0xFF626262),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),)
          ),
        ],
      ),
      // floatingActionButtonLocation: MyCustomFabLocation(),
      // // Use custom FAB location
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Handle your button press logic here
      //     showDialog(
      //       context: context,
      //       builder: (context) => PopupDialog(data: controller.childes,),
      //     );
      //   },
      //   backgroundColor: Colors.red,
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(16.0),
      //       bottomLeft: Radius.circular(16.0),
      //     ),
      //   ),
      //   child: Image.asset(Images.category_icon),
      // ),
      // bottomNavigationBar: BottomAppBar(
      //   padding: EdgeInsets.zero,
      //   shape: const CircularNotchedRectangle(),
      //   notchMargin: 8.0,
      //   child: Container(
      //     width: double.maxFinite,
      //     decoration: const BoxDecoration(
      //       color: AppColors.lightSky,
      //       borderRadius: BorderRadius.only(
      //         topLeft: Radius.circular(20),
      //         topRight: Radius.circular(20),
      //       ),
      //     ),
      //     child: SingleChildScrollView(
      //       child: Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           Padding(
      //             padding: const EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
      //             child: Row(
      //               children: [
      //                 SvgPicture.asset(Images.scotor,
      //                   width: 24,
      //                   height: 24,
      //                 ),
      //                 const SizedBox(width: 8),
      //                 Expanded(
      //                   child: Text(
      //                     "Get delivery within 2 hours on selected products",
      //                     style:Theme.of(context).textTheme.titleSmall!.copyWith(
      //                         color: AppColors.darkBlue,
      //                         fontWeight: FontWeight.w600,
      //                         fontSize: 12
      //                     ),
      //                     overflow: TextOverflow.ellipsis,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           Container(
      //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //             height: 60,
      //             decoration: const BoxDecoration(
      //               color: Colors.red,
      //               borderRadius: BorderRadius.only(
      //                 topLeft: Radius.circular(20),
      //                 topRight: Radius.circular(20),
      //               ),
      //             ),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Row(
      //                   children: [
      //                     Icon(Icons.shopping_bag, color: Colors.white),
      //                     SizedBox(width: 8),
      //                     Text(
      //                       '1 item added',
      //                       style: TextStyle(color: Colors.white),
      //                     ),
      //                   ],
      //                 ),
      //                 Text(
      //                   '₹22,150',
      //                   style: TextStyle(
      //                     color: Colors.white,
      //                     fontWeight: FontWeight.w300,
      //                     decoration: TextDecoration.lineThrough,
      //                   ),
      //                 ),
      //                 ElevatedButton(
      //                   onPressed: () {},
      //                   style: ElevatedButton.styleFrom(
      //                     backgroundColor: Colors.white,
      //                     foregroundColor: Colors.red,
      //                     shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(10),
      //                     ),
      //                   ),
      //                   child: Text('Next'),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }




  Widget meetingitem(BuildContext context,TableMeetingsModel meeting) {
    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      color: AppColors.fountGray,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Row(
          children: [
            // Left section
            Expanded(
              flex: 1,
              child: Container(
               // padding: const EdgeInsets.all(5),
               // color: AppColors.gray,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Meeting ID

                    // Meeting Name
                    Text(
                      meeting.fldMTypeName!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'PoppinsSemiBold',
                        color: AppColors.whites,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    // CSR
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 5),
                    //   child: Text(
                    //     meeting.fldCsr!,
                    //     textAlign: TextAlign.center,
                    //     style: TextStyle(
                    //       fontFamily: 'PoppinsSemiBold',
                    //       color: Colors.black,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            // Right section
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(12),
                color: AppColors.whites,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Location Row
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 15),
                        SizedBox(width: 5),
                        Text(
                          meeting.fldLocation!,
                          style: TextStyle(
                            fontFamily: 'PoppinsSemiBold',
                           fontWeight: FontWeight.w500
                           // color: Theme.of(context).textTheme.bodyText1?.color,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
                    // Date Row
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 15),
                        SizedBox(width: 5),
                        Text(
                          "${meeting.fldDepoCode!} ( ${meeting.fldDepoName!} )",
                          style: TextStyle(
                            fontFamily: 'PoppinsSemiBold',fontSize: 13
                            //color: Theme.of(context).textTheme.bodyText1?.color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    // Participants and Owner Row
                    Row(
                      children: [
                        Icon(Icons.person, size: 15),
                        SizedBox(width: 5),
                        Text(
                          meeting.fldEstiAttendee!,
                          style: TextStyle(
                            fontFamily: 'PoppinsSemiBold',
                           // color: Theme.of(context).textTheme.bodyText1?.color,
                          ),
                        ),
                        SizedBox(width: 20),
                        Icon(Icons.store, size: 15),
                        SizedBox(width: 5),
                        Text(
                          controller.getOwnerName(meeting),
                          style: TextStyle(
                            fontFamily: 'PoppinsSemiBold',
                           // color: Theme.of(context).textTheme.bodyText1?.color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // View and Invite Buttons

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Column layoutNew(BuildContext context) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       TitleWidget(title: "New Products"),
  //       Container(
  //         height: 120,
  //         child: ListView.separated(
  //           scrollDirection: Axis.horizontal,
  //           itemCount: controller.items.length,
  //           padding: const EdgeInsets.symmetric(
  //               horizontal: Dimensions.paddingSizeDefault),
  //           itemBuilder: (context, index) {
  //             return GestureDetector(
  //               onTap: () {
  //                 Get.toNamed(Routes.ProductDetail);
  //               },
  //               child: Container(
  //                 width: 120,
  //                 height: 120,
  //                 decoration: BoxDecoration(
  //                   borderRadius:
  //                       BorderRadius.circular(Dimensions.radiusSizeMedium),
  //                 ),
  //                 child: ClipRRect(
  //                   borderRadius: const BorderRadius.all(
  //                     Radius.circular(Dimensions.radiusSizeTen),
  //                   ),
  //                   child: CachedNetworkImage(
  //                     imageUrl: 'https://picsum.photos/250?image=9',
  //                     imageBuilder: (context, imageProvider) => Container(
  //                       height: 120,
  //                       width: 120,
  //                       decoration: BoxDecoration(
  //                         image: DecorationImage(
  //                           image: imageProvider,
  //                           fit: BoxFit.cover,
  //                         ),
  //                       ),
  //                     ),
  //                     placeholder: (context, url) =>
  //                          Shimmer.fromColors(
  //                           baseColor: Colors.black12,
  //                           highlightColor: Colors.white,
  //                           enabled: true,  // Shimmer is enabled while loading
  //                           child: Container(
  //                             decoration: BoxDecoration(
  //                               color: AppColors.whites,
  //                               borderRadius: BorderRadius.circular(Dimensions.radiusSizeTen),
  //                             ),
  //                           ),
  //                         ),
  //                     errorWidget: (context, url, error) =>
  //                         const Icon(Icons.error),
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //           separatorBuilder: (context, index) {
  //             return const SizedBox(width: Dimensions.paddingSizeMedium);
  //           },
  //         ),
  //       )
  //     ],
  //   );
  // }

  // Widget layoutNewbaner(BuildContext context, {required RxList<BannerSliderModel> items}) {
  //  // final Size size = MediaQuery.sizeOf(context);
  //   return Container(
  //     width: Dimensions.webScreenWidth,
  //     height: 135,
  //     child: ListView.separated(
  //       shrinkWrap: true,
  //       scrollDirection: Axis.horizontal,
  //       padding: const EdgeInsets.only(
  //           left: Dimensions.paddingSizeDefault,
  //           right: Dimensions.paddingSizeDefault),
  //       itemCount: controller.items.length,
  //       itemBuilder: (context, index) {
  //         return GestureDetector(
  //           onTap: () {},
  //           child: Container(
  //             width: 350,
  //             height: 135,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(Dimensions.radiusSizeTen),
  //             ),
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(Dimensions.radiusSizeTen),
  //               child: Center(
  //                 child: CachedNetworkImage(
  //                   imageUrl: 'https://picsum.photos/250?image=9',
  //                   imageBuilder: (context, imageProvider) => Container(
  //                     decoration: BoxDecoration(
  //                       image: DecorationImage(
  //                         image: imageProvider,
  //                         fit: BoxFit.cover,
  //                         filterQuality: FilterQuality.high,
  //                         alignment: Alignment.center,
  //                       ),
  //                     ),
  //                   ),
  //                   placeholder: (context, url) =>
  //                       const CircularProgressIndicator(),
  //                   errorWidget: (context, url, error) =>
  //                       const Icon(Icons.error),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //       separatorBuilder: (context, index) {
  //         return const SizedBox(width: 12);
  //       },
  //     ),
  //   );
  // }

  // Widget layoutExploreProducts() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const TitleWidget(title: "Explore"),
  //       GridView.builder(
  //         physics: const NeverScrollableScrollPhysics(),
  //         shrinkWrap: true,
  //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //           crossAxisCount: 2,
  //           mainAxisSpacing: 10,
  //           crossAxisSpacing: 10,
  //           mainAxisExtent: 120
  //         ),
  //         itemCount: 6,
  //         padding: const EdgeInsets.only(left: 15,right: 15),
  //         // Adjust number of items
  //         itemBuilder: (context, index) {
  //           return Container(
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(Dimensions.radiusSizeTen),
  //             ),
  //             child: ClipRRect(
  //               borderRadius: const BorderRadius.all(
  //                 Radius.circular(Dimensions.radiusSizeTen),
  //               ),
  //               child: Center(
  //                 child: CachedNetworkImage(
  //                   imageUrl: 'https://picsum.photos/250?image=9',
  //                   imageBuilder: (context, imageProvider) => Container(
  //                     decoration: BoxDecoration(
  //                       image: DecorationImage(
  //                         image: imageProvider,
  //                         fit: BoxFit.cover,
  //                       ),
  //                     ),
  //                   ),
  //                   placeholder: (context, url) =>
  //                       const CircularProgressIndicator(),
  //                   errorWidget: (context, url, error) =>
  //                       const Icon(Icons.error),
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       ),
  //       const SizedBox(
  //         height: Dimensions.paddingSizeMedium,
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.only(
  //             left: Dimensions.x14, right: Dimensions.x14),
  //         child: CcPrimaryButton(
  //           height: 40,
  //           buttonText: "View All",
  //           onPressed: () {},
  //         ),
  //       ),
  //       const SizedBox(
  //         height: Dimensions.paddingSizeDefault,
  //       ),
  //     ],
  //   );
  // }


}



class TitleWidget extends StatelessWidget {
  final String? title;
  final Function? onTap;

  const TitleWidget({Key? key, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: ResponsiveHelper.isDesktop(context) ? ColorResources.getAppBarHeaderColor(context) : Theme.of(context).canvasColor,
      padding: EdgeInsets.symmetric(horizontal: ResponsiveView.isDesktop(context) ? 0 : 15, vertical: 16),
      margin: ResponsiveView.isDesktop(context)
          ? const EdgeInsets.symmetric(horizontal: 5, vertical: 10)
          : EdgeInsets.zero,
      child: Text(
        title!,
        style: Styles.inriaSansBold.copyWith(
            fontSize: ResponsiveView.isDesktop(context)
                ? Dimensions.fontSizeExtraLarge
                : Dimensions.fontSizeExtraLarge,
            color: AppColors.black),
      ),
    );
  }
}
