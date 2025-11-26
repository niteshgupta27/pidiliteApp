
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../Utill/app_required.dart';
import '../InviteesModal.dart';
import '../controller/inviteController.dart';

class FollowView extends GetView<InviteController> {
  const FollowView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        SliverList(delegate: SliverChildListDelegate(
            [
              Obx(() =>   ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: Dimensions.paddingSizeLarge,right: Dimensions.paddingSizeLarge,
                    bottom: Dimensions.paddingSizeMoreExtraLarge
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemCount:controller.followlist.length,
                itemBuilder: (context, index) {
                  Datum order = controller.followlist[index];
                  return Container(
                    height: 58,
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(
                        left: Dimensions.paddingSizeLarge,right:Dimensions.paddingSizeLarge,
                        top: Dimensions.paddingSizeSmall
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.whites,
                        borderRadius: BorderRadius.circular(Dimensions.radiusSizeMedium)
                    ),
                    child: Column(
                      children: [
                        // First part: Row with Image, Order Details, and Status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // Order Number
                                      Text("${index+1}. ${order.fldName!}",
                                        style: Styles.inriaSansBold.copyWith(
                                            fontSize: Dimensions.fontSizeLarge,
                                            color: AppColors.black
                                        ),
                                      ),
                                      // 8422922959
                                      IconButton(onPressed:(){CallService.makeDirectCall(order.fldNumber!);} , icon: const Icon(Icons.call, size: 25),)
                                    ],
                                  ),


                                ],
                              ),
                            ),
                          ],
                        ),


                      ],
                    ),
                  );
                },
                separatorBuilder: (context,index) {
                  return const SizedBox(height: Dimensions.x0_6);
                },
              ))
            ]
        ))
      ],
    );
  }
}
