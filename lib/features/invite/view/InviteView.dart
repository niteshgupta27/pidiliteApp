
import 'package:flutter_svg/svg.dart';

import '../../../Utill/app_required.dart';
import '../controller/inviteController.dart';

class InviteView extends GetView<InviteController> {
   InviteView({super.key});

  @override
  Widget build(BuildContext context) {
controller.startAnimation();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appBarColorNotifier.value = AppColors.primaryColor;
    });
    return  Scaffold(
      backgroundColor: AppColors.whites,
      appBar: AppBar(
        title:  Text('Calling List', style: Styles.PageTitle),
        elevation: 5.0,
        leading: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.back(result: {"status": "success",});
            },
            icon: SvgPicture.asset(
              Images.backButton,
              height: Dimensions.x24,
            )),
        shadowColor: AppColors.gray.withOpacity(0.5),
        surfaceTintColor: Colors.transparent,
      ),
     body: Obx(() {
  return Column(
    children: [
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
                    'Follow Up',
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
    ],
  );
})
    );
  }
}
