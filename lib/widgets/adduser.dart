import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totalx/model/userdetails.dart';
import 'package:totalx/provider/user_provider.dart';

class AddUserPopup extends StatefulWidget {
  const AddUserPopup({
    super.key,
    required this.names,
    required this.ages,
    required this.provider,
  });

  final TextEditingController names;
  final TextEditingController ages;
  final UserProvider provider;

  @override
  State<AddUserPopup> createState() => _AddUserPopupState();
}

class _AddUserPopupState extends State<AddUserPopup> {
  final _formKey = GlobalKey<FormState>();
  XFile? image;
  bool imageError = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      insetPadding: EdgeInsets.symmetric(horizontal: 10.w),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r)),
      contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 24.h),
      title: Text(
        "Add A New User",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13.sp,
          fontFamily: "Montserrat",
        ),
      ),
      content: Form(
        key: _formKey,
        child: SizedBox(
          height: 270.h,
          width: 340.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    image = await picker.pickImage(source: ImageSource.gallery);
                  },
                  child: Container(
                    height: 80.h,
                    width: 80.w,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: image == null
                          ? Image.asset(
                              "asset/images/camara.png",
                              height: 80.h,
                              width: 85.w,
                            )
                          : Image.file(
                              File(image!.path),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ),
              if (imageError) ...[
                Gap(8.h),
                const Center(
                  child: Text(
                    'Image is required',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
              Gap(16.h),
              Opacity(
                opacity: .6,
                child: Text(
                  "Name",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    fontFamily: "Montserrat",
                  ),
                ),
              ),
              Gap(12.h),
              SizedBox(
                height: 44.h,
                width: 323.w,
                child: TextFormField(
                  controller: widget.names,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(.3),
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ),
              Gap(16.h),
              Opacity(
                opacity: .6,
                child: Text(
                  "Age",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    fontFamily: "Montserrat",
                  ),
                ),
              ),
              Gap(12.h),
              SizedBox(
                height: 44.h,
                width: 323.w,
                child: TextFormField(
                  controller: widget.ages,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Age is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(.3),
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            widget.names.clear();
            widget.ages.clear();
            image = null;
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: const Color(0xffCCCCCC),
            ),
            height: 28.h,
            width: 95.w,
            child: Center(
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  fontFamily: "Montserrat",
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: const Color(0xff1782FF),
          ),
          height: 28.h,
          width: 95.w,
          child: Center(
            child: GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate() && image != null) {
                  setState(() {
                    imageError = false;
                  });
                  widget.provider.addTask(
                    UserData(
                      image: image!,
                      imagePath: '',
                      name: widget.names.text,
                      age: int.parse(widget.ages.text),
                    ),
                  );
                  widget.provider.saveTask();
                  widget.names.clear();
                  widget.ages.clear();
                  image = null;
                  Navigator.pop(context);
                }
                if (image == null) {
                  setState(() {
                    imageError = true;
                  });
                }
              },
              child: Text(
                "Save",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  fontFamily: "Montserrat",
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
