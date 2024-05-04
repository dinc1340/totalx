import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:totalx/provider/user_provider.dart';

class SortSheet extends StatefulWidget {
  const SortSheet({super.key, required this.provider});
  final UserProvider provider;

  @override
  State<SortSheet> createState() => _SortSheetState();
}

class _SortSheetState extends State<SortSheet> {
  RadioGroupController controller = RadioGroupController();

  List<String> values = [
    "All",
    "Age: Elder",
    "Age: Younger",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, top: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sort",
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(20.h),
          RadioGroup(
            
            controller: controller,
            decoration: RadioGroupDecoration(
              spacing: 15.h,
              labelStyle: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500),
            ),
            onChanged: (value) {
              widget.provider.setSort(values.indexOf(value));
              Navigator.pop(context);
            },
            values: values,
          ),
        ],
      ),
    );
  }
}
