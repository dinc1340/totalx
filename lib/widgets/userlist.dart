import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class UsersList extends StatelessWidget {
  const UsersList({
    super.key,
    required this.image,
    required this.name,
    required this.age,
  });
  final String image;
  final String name;
  final int age;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.w, top: 8.h, bottom: 8.w),
      height: 76.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r), color: Colors.white),
      child: Center(
        child: Row(
          children: [
            ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(50.r),
              child: Image.file(
                File(image),
                height: 60.h,
                width: 60.w,
                fit: BoxFit.cover,
              ),
            ),
            Gap(10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(8.h),
                Opacity(
                  opacity: .8,
                  child: Text(
                    name,
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Gap(8.h),
                Opacity(
                  opacity: .8,
                  child: Text(
                    age.toString(),
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
