import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:totalx/provider/otpprovider.dart';
import 'package:totalx/screens/homepage.dart';
import 'package:totalx/screens/login.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key,});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController otpcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 74.h),
        child: Consumer<OtpProvider>(builder: (context, a, child) {
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
              Gap(31.h),
              Text(
                "OTP Verification",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600),
              ),
              Gap(24.h),
              Opacity(
                opacity: .7,
                child: Text(
                  textAlign: TextAlign.left,
                  "Enter the verification code we just sent to your number +91........21",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Gap(23.h),
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
                        border: Border.all(color: Colors.black, width: 1.sp),
                      ),
                    ),
                    enabled: true,
                    followingPinTheme: PinTheme(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.sp),
                        border: Border.all(color: Colors.black.withOpacity(.3)),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    separatorBuilder: (index) => SizedBox(
                      width: 8.w,
                    ),
                    defaultPinTheme: PinTheme(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18.sp,
                          color: Color(0xffFF5454),
                          fontFamily: "Montserrat"),
                    ),
                    length: 6,
                  ),
                ),
              ),
              Gap(47.h),
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
                            color: Color(0xff2873F0),
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xff2873F0),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Montserrat"),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(17.h),
              bottom_button(
                title: 'Verify',
                click: ()  {
                 
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                },
              )
            ],
          );
        }),
      ),
    );
  }
}
