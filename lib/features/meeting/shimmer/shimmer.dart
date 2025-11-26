
import 'package:shimmer/shimmer.dart';

import '../../../Utill/app_required.dart';


class ShimmerWidget extends StatelessWidget {
  //final String itemstitel;

  // Constructor to pass the items and optional onTap callback
  const ShimmerWidget({
    Key? key,


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Center(
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                headerMedile(),
                Container(
                  height: 83,
                  margin:
                  const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(
                        left: Dimensions.paddingSizeSmall,
                        right: Dimensions.paddingSizeSmall),
                    itemCount: 6,
                    // Number of items
                    separatorBuilder: (context, index) => const SizedBox(width: 0),
                    // Spacing between circles
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Material(
                          elevation: 5,
                          //shape: const CircleBorder(),
                          child:  Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: Colors.grey,child: Container(
                           height: 40,
                            width: 55,
                          ),
                          ),),
                      );

                    },
                  ),
                ),

                const SizedBox(
                  height: Dimensions.paddingSizeExtraLarge,
                ),
                // layoutNewbaner(context),
                // ExploreWidget(items: controller.data),
              ],
            ),
          ),


    );
  }
  Widget headerMedile() {
    return Container(
      decoration: BoxDecoration(color: AppColors.whites, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          offset: const Offset(0.0, 4.0),
          blurRadius: 5.0,
          spreadRadius: 1.0,
        )
      ]),
      child: Column(
        children: [
          /// TODO CIRCLE LIST


          Center(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
              child:  Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.white,child:Container(height: 90,) ,)
            ),
          ),
        ],
      ), // Yellow color
    );
  }



  //
  // Widget layoutNewbaner(BuildContext context) {
  //   final Size size = MediaQuery.sizeOf(context);
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
  //                   const CircularProgressIndicator(),
  //                   errorWidget: (context, url, error) =>
  //                   const Icon(Icons.error),
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
}