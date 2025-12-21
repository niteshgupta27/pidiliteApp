
import 'package:get/get_state_manager/src/simple/get_view.dart';


import '../../../Utill/app_required.dart';
import '../../menu/dottedDivider.dart';
import '../../serviceCall.dart';
import '../controller/AttendeeController.dart';
import '../model/Table_Attendee.dart';

class LiveView extends GetView<AttendeeController> {
  const LiveView({super.key});

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
                itemCount:controller.live.length,
                itemBuilder: (context, index) {
                  Table_Attendee order = controller.live[index];
                  return Container(
                    // height: 108,
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(
                        left: Dimensions.paddingSizeSmall,
                        right: Dimensions.paddingSizeSmall,
                        top: Dimensions.paddingSizeSmall,
                        bottom: Dimensions.paddingSizeSmall
                    ),
                    decoration: BoxDecoration(
                      color: order.fldAttendance == 0 && order.fldInvites == 1
                          ? AppColors.attendeBackground
                          : AppColors.whites,
                      borderRadius: BorderRadius.circular(Dimensions.radiusSizeMedium),
                    ),
                    child: Column(//mainAxisSize: MainAxisSize.min,
                      children: [
                        // First Row: Attendee Name, Edit & Delete Icons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align children to start and end
                          children: [
                            Text(
                              order.fldAttendeeName.toString().trim(),
                              style: Styles.headerTitel,
                            ),
                            // if (order.fldAttendance == 1 || order.fldInvites == 1)
                            //   IconButton(
                            //     icon: const Icon(Icons.edit_note_outlined, size: 20),
                            //     onPressed: () => controller.editAttendee(order),
                            //   ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Second Row: Call Icon, Phone Number, Cart Icon, Order Status, Upload Icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start, // Align children to the start
                          children: [
                            InkWell(
                              child: Icon(
                                Icons.phone_in_talk_outlined,
                                color: order.tollfree == 1 ? Colors.green : Colors.red,
                                size: 20,
                              ),
                              onTap: () => CallService.makeDirectCall(order.fldMobile!),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              order.fldMobile,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            // const SizedBox(width: 25),
                            // const Icon(Icons.shopping_cart, size: 24, color: Colors.grey),
                            // const SizedBox(width: 5),
                            // const Text(
                            //   "Order: ",
                            //   style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                            // ),
                            // Text(
                            //   order.fldOrderPlaced == "1" ? "Yes" : "No",
                            //   style: TextStyle(
                            //     fontSize: 12,
                            //     fontWeight: FontWeight.w600,
                            //     color: AppColors.fountGray,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context,index) {
                  return const DottedDivider(
                    width: 1,
                    color: Colors.grey,
                    thickness: 1,
                    gap: 4,
                  );
                },
              ))
            ]
        ))
      ],
    );
  }
}
