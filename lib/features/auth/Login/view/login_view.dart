import 'package:pidilite/Utill/app_required.dart';

import '../controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var controller = Get.find<LoginController>();

  var _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    //bool isKeyboardOpen = bottomInsets != 0;
    print(bottomInsets);
    return Scaffold(
      backgroundColor: AppColors.whites,
      resizeToAvoidBottomInset: true,
      // Adjusts when the keyboard is opened
      // body: Stack(
      //   children: [
      //     // Background Ellipse Image
      //     Positioned(
      //       top: 0,
      //       left: 0,
      //       right: 0,
      //       child: Image.asset(
      //         Images.ellipse,
      //         width: double.infinity,
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //     // App Logo
      //     Positioned(
      //       top: 120,
      //       left: 80,
      //       right: 80,
      //       child: Image.asset(Images.AppLogo),
      //     ),
      //
      //     // Form Container
      //     Positioned(
      //       top: (MediaQuery.of(context).size.height * 0.4)-bottomInsets, // Adjust this based on your UI
      //       left: 0,
      //       right: 0,
      //       bottom: 0,
      //       // Ensures that the form takes up all available space
      //       child:
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.whites,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Obx(
                () => controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          const SizedBox(height: Dimensions.x30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: 250,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(Images.arabicFlag),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.x20),
                          // Login or Signup title
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    thickness: 1.5,
                                    color: AppColors.black.withOpacity(0.2),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Text(
                                    AppConstants.appName,
                                    style: Styles.inriaSansBold.copyWith(
                                      fontSize: Dimensions.fontSizeExtraLarge,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 1.5,
                                    color: AppColors.black.withOpacity(0.2),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: Dimensions.x34),

                          // Phone number input field
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Container(
                              // width: 330,
                              height: 60,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFF2F2F2),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(width: 0.5),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      bottom: 0,
                                    ),
                                    child: Icon(Icons.account_circle),
                                  ),

                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        bottom: 5,
                                      ),
                                      child: TextFormField(
                                        controller: phoneController,
                                        keyboardType: TextInputType.name,
                                        style: Styles.inriaSansBold.copyWith(
                                          fontSize: Dimensions.fontSizeMedium,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                vertical: 0,
                                                horizontal: 0,
                                              ),
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          hintStyle: Styles.inriaSansBold
                                              .copyWith(
                                                fontSize: Dimensions
                                                    .fontSizeExtraLarge,
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w400,
                                              ),
                                          prefixIconConstraints:
                                              const BoxConstraints(
                                                minWidth: 40,
                                              ),
                                          hintText: 'Enter username',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.x20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Container(
                              // width: 330,
                              height: 60,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFF2F2F2),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(width: 0.5),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      bottom: 0,
                                    ),
                                    child: Icon(Icons.lock),
                                  ),

                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        bottom: 5,
                                      ),
                                      child: TextFormField(
                                        obscureText: true,
                                        controller: passwordController,
                                        keyboardType: TextInputType.text,
                                        style: Styles.inriaSansBold.copyWith(
                                          fontSize: Dimensions.fontSizeMedium,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                vertical: 0,
                                                horizontal: 0,
                                              ),
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          hintStyle: Styles.inriaSansBold
                                              .copyWith(
                                                fontSize: Dimensions
                                                    .fontSizeExtraLarge,
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w400,
                                              ),
                                          prefixIconConstraints:
                                              const BoxConstraints(
                                                minWidth: 40,
                                              ),
                                          hintText: 'Enter Password',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.x30),

                          // Continue button
                          Container(
                            height: 60,
                            width: double.maxFinite,
                            margin: const EdgeInsets.symmetric(horizontal: 100),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 4.0,
                                backgroundColor: AppColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed: () {
                                controller.validateAndProcess(
                                  phoneController.text.toString().trim(),
                                  passwordController.text.toString(),
                                );
                              },
                              child: Text(
                                'Login',
                                style: Styles.inriaSansBold.copyWith(
                                  fontSize: Dimensions.fontSizeOverLarge,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
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
                            child: Image.asset(Images.poweredby),
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
            ),
          ),
        ),
      ),
    );
    //     ],
    //   ),
    // );
  }
}
