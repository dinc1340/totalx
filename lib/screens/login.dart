// ignore_for_file: unused_local_variable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:totalx/provider/otpprovider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var otpProvider = Provider.of<OtpProvider>(context, listen: false);
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 92.h),
          child: Consumer(builder: (context, a, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "asset/images/login.png",
                    height: MediaQuery.of(context).size.width * .25,
                    width: MediaQuery.of(context).size.width * .35,
                  ),
                ),
                Gap(50.h),
                Text(
                  "Enter Phone Number",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(16.h),
                SizedBox(
                  height: 44.h,
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: phonecontroller,
                    decoration: InputDecoration(
                      hintText: "Enter Phone Number * ",
                      hintStyle: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(width: 1.sp),
                      ),
                    ),
                  ),
                ),
                Gap(16.h),
                RichText(
                  text: TextSpan(
                    text: "By Continuing, I agree to TotalX’s  ",
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Montserrat",
                      color: Colors.black.withOpacity(.5),
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap = () {},
                        text: " Terms and Condition",
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Montserrat",
                          color: const Color(0xff2873F0).withOpacity(.5),
                        ),
                      ),
                      TextSpan(
                        text: "  & ",
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Montserrat",
                        ),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap = () {},
                        text: " Privacy Policy",
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Montserrat",
                          color: const Color(0xff2873F0).withOpacity(.5),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(24.h),
                bottom_button(
                  title: "Get OTP",
                  click: () {
                    if (phonecontroller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Enter Mobile Number'),
                        ),
                      );
                    } else {
                      otpProvider.sendOtp(
                        "+91${phonecontroller.text}",
                        context,
                      );
                    }
                  },
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
class bottom_button extends StatelessWidget {
  const bottom_button({super.key, required this.title, this.click});
  final String title;
  final void Function()? click;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
          onPressed: click,
          child: Text(
            title,
            style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          )),
    );
  }
}
