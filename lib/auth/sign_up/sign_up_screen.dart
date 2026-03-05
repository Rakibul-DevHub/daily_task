import 'package:askfemi/auth/verify/verify_email_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../features/individual_user/widget/date_input_field.dart';
import '../../utils/app_colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final ValueNotifier<bool> _obscurePassword;
  bool _agreeToTerms = false;

  @override
  void initState() {
    super.initState();
    _obscurePassword = ValueNotifier<bool>(true);
  }

  @override
  void dispose() {
    _obscurePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          /// ================= TOP LOGO =================
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.12),
              child: SvgPicture.asset(
                "assets/images/logo.svg",
                height: height * 0.18,
              ),
            ),
          ),

          /// ================= BOTTOM SHEET (FIXED) =================
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height * 0.65,
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(80),
                  topRight: Radius.circular(80),
                ),
                border: Border(
                  top: BorderSide(
                    color: AppColors.primaryColor,
                    width: 1.5,
                  ),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Create an account",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Plus Jakarta Sans',
                      ),
                    ),

                    const SizedBox(height: 24),

                    ///==================================
                    ///============ User Name
                    ///==================================
                    TextField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.grey, width: 2.0),
                        ),
                        prefixIcon: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  CupertinoIcons.person_crop_circle,
                                  color: Colors.grey[700],
                                ),
                                const SizedBox(width: 12),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: VerticalDivider(
                                    color: AppColors.grey,
                                    width: 1,
                                    thickness: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        hintText: 'User Name',
                        hintStyle: const TextStyle(fontFamily: 'Plus Jakarta Sans'),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: AppColors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    ///==================================
                    ///============ E-mail
                    ///==================================
                    TextField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.grey, width: 2.0),
                        ),
                        prefixIcon: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.email_outlined, color: Colors.grey[700]),
                                const SizedBox(width: 12),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: VerticalDivider(
                                    color: AppColors.grey,
                                    width: 1,
                                    thickness: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        hintText: 'E-mail',
                        hintStyle: const TextStyle(fontFamily: 'Plus Jakarta Sans'),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: AppColors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    ///==================================
                    ///============ Phone Number
                    ///==================================
                    TextField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.grey, width: 2.0),
                        ),
                        prefixIcon: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(CupertinoIcons.phone, color: Colors.grey[700]),
                                const SizedBox(width: 12),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: VerticalDivider(
                                    color: AppColors.grey,
                                    width: 1,
                                    thickness: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        hintText: 'Phone number',
                        hintStyle: const TextStyle(fontFamily: 'Plus Jakarta Sans'),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: AppColors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    ///==================================
                    ///============ Gender
                    ///==================================
                    DropdownSearch<String>(
                      items: (filter, infiniteScrollProps) async {
                        return ["Male", "Female", "Other"];
                      },
                      popupProps: PopupProps.menu(
                        showSearchBox: false,
                        fit: FlexFit.loose,
                        menuProps: MenuProps(
                          borderRadius: BorderRadius.circular(10),
                          elevation: 4,
                        ),
                      ),
                      decoratorProps: DropDownDecoratorProps(
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: AppColors.grey, width: 2.0),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    CupertinoIcons.person,
                                    color: Colors.grey[700],
                                  ),
                                  const SizedBox(width: 12),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                                    child: VerticalDivider(
                                      color: AppColors.grey,
                                      width: 1,
                                      thickness: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          hintText: 'Select Gender',
                          hintStyle: const TextStyle(fontFamily: 'Plus Jakarta Sans'),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: AppColors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        print("Selected gender: $value");
                      },
                    ),
                    const SizedBox(height: 24),

                    ///==================================
                    ///============ Date of Birth
                    ///==================================
                    DateOfBirthField(
                      onDateSelected: (dateString) {
                        print('DOB: $dateString');
                      },
                    ),
                    const SizedBox(height: 24),

                    ///==================================
                    ///============ Age
                    ///==================================
                    TextField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: AppColors.grey, width: 2.0),
                        ),
                        prefixIcon: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  CupertinoIcons.person_3_fill,
                                  color: Colors.grey[700],
                                ),
                                const SizedBox(width: 12),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                                  child: VerticalDivider(
                                    color: AppColors.grey,
                                    width: 1,
                                    thickness: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        hintText: 'Age',
                        hintStyle: const TextStyle(fontFamily: 'Plus Jakarta Sans'),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: AppColors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    ///===============================
                    ///========= Password ===========
                    ///===============================
                    ValueListenableBuilder<bool>(
                      valueListenable: _obscurePassword,
                      builder: (context, isObscured, child) {
                        return TextField(
                          obscureText: isObscured,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: AppColors.grey,
                                width: 2.0,
                              ),
                            ),
                            prefixIcon: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.lock_outline, color: Colors.grey[700]),
                                    const SizedBox(width: 12),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                        bottom: 8,
                                      ),
                                      child: VerticalDivider(
                                        color: AppColors.grey,
                                        width: 1,
                                        thickness: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                color: AppColors.grey,
                              ),
                              onPressed: () {
                                _obscurePassword.value = !_obscurePassword.value;
                              },
                            ),
                            hintText: 'Enter Password',
                            hintStyle: const TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: AppColors.grey),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: AppColors.grey),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    ///=========================
                    /// Terms & Conditions Checkbox
                    /// ========================
                    Row(
                      children: [
                        Checkbox(
                          value: _agreeToTerms,
                          activeColor: AppColors.primaryColor,
                          side: const BorderSide(),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                          onChanged: (bool? newValue) {
                            setState(() {
                              _agreeToTerms = newValue ?? false;
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              print("Terms and conditions clicked");
                            },
                            child: const Text(
                              "By creating an account, I accept the Terms & Conditions & Privacy Policy.",
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 14,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    ///=========================
                    /// Sign Up Button
                    /// ========================
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (!_agreeToTerms) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please agree to terms & conditions"),
                              ),
                            );
                            return;
                          }
                          Get.to(() => const VerifyEmailScreen());
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            fontFamily: 'Plus Jakarta Sans',
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    ///=========================
                    /// Sign In Text
                    /// ========================
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'Plus Jakarta Sans',
                            ),
                          ),
                          WidgetSpan(
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                color: AppColors.black,
                                fontFamily: 'Plus Jakarta Sans',
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    ///=========================
                    /// OR Divider
                    /// ========================
                    const Text(
                      "OR",
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Plus Jakarta Sans',
                      ),
                    ),
                    const SizedBox(height: 20),

                    ///=========================
                    /// Google Sign In
                    /// ========================
                    SvgPicture.asset("assets/icons/google.svg"),
                    const SizedBox(height: 20),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}