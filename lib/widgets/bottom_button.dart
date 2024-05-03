import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
