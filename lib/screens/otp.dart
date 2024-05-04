// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:totalx/provider/otpprovider.dart';
import 'package:totalx/widgets/bottom_button.dart';


class OtpPage extends StatefulWidget {
  const OtpPage({super.key, required this.phone});
  final String phone;
  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController otpcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var otpProvider = Provider.of<OtpProvider>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 74.h),
        child: Consumer<OtpProvider>(
          builder: (context, a, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "asset/images/otp.png",
                    height: 140.h,
                    width: 140.w,
                  ),
                ),
                Gap(32.h),
                Text(
                  "OTP Verification",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(24.h),
                Opacity(
                  opacity: .7,
                  child: Text(
                    textAlign: TextAlign.left,
                    "Enter the verification code we just sent to your number ${widget.phone}",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Gap(22.h),
                Center(
                  child: SizedBox(
                    width: 304.w,
                    height: 44.h,
                    child: Pinput(
                      controller: otpcontroller,
                      focusedPinTheme: PinTheme(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.sp),
                          border: Border.all(
                            color: Colors.black,
                            width: 1.sp,
                          ),
                        ),
                      ),
                      enabled: true,
                      followingPinTheme: PinTheme(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.sp),
                          border: Border.all(
                            color: Colors.black.withOpacity(.3),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      separatorBuilder: (index) => SizedBox(width: 8.w),
                      defaultPinTheme: PinTheme(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18.sp,
                          color: const Color(0xffFF5454),
                          fontFamily: "Montserrat",
                        ),
                      ),
                      length: 6,
                    ),
                  ),
                ),
                Gap(48.h),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Don't Get OTP? ",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Montserrat",
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = () {},
                          text: " Resend",
                          style: TextStyle(
                            color: const Color(0xff2873F0),
                            decoration: TextDecoration.underline,
                            decorationColor: const Color(0xff2873F0),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(18.h),
                bottom_button(
                  title: 'Verify',
                  click: () async {
                    if (otpcontroller.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Enter OTP!'),
                        ),
                      );
                    } else {
                      otpProvider.verifyOtp(context, otpcontroller.text);
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
