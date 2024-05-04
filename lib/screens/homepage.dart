// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:totalx/model/userdetails.dart';
import 'package:totalx/provider/user_provider.dart';
import 'package:totalx/screens/login.dart';
import 'package:totalx/widgets/adduser.dart';
import 'package:totalx/widgets/sort_bottom.dart';
import 'package:totalx/widgets/userlist.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController names = TextEditingController();
  TextEditingController ages = TextEditingController();
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.loadTask();

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xffEBEBEB),
        appBar: AppBar(
          toolbarHeight: 8.h,
        ),
        floatingActionButton: Consumer<UserProvider>(
          builder: (context, a, chhild) {
            return FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.r),
              ),
              backgroundColor: Colors.black,
              onPressed: () {
                userProvider.saveTask();
                showDialog(
                  context: context,
                  builder: (context) {
                    return AddUserPopup(
                      names: names,
                      ages: ages,
                      provider: userProvider,
                    );
                  },
                );
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 32.sp,
              ),
            );
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 69.h,
                decoration: const BoxDecoration(color: Colors.black),
                child: Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 15.sp,
                            color: Colors.white,
                          ),
                          Gap(4.w),
                          Text(
                            "Nilambur",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Montserrat",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          userProvider.clearData();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Gap(12.h),
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 298.w,
                          height: 44.h,
                          child: TextField(
                            controller: search,
                            onChanged: (value) {
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(36.r),
                              ),
                              hintText: "Search by Name",
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(.4),
                                fontFamily: "Montserrat",
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                size: 18.sp,
                              ),
                            ),
                          ),
                        ),
                        Gap(8.w),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              scrollControlDisabledMaxHeightRatio: .25,
                              context: context,
                              builder: (context) {
                                return SortSheet(provider: userProvider);
                              },
                            );
                          },
                          child: Image.asset(
                            "asset/images/list.png",
                            height: 32.h,
                            width: 32.w,
                          ),
                        ),
                      ],
                    ),
                    Gap(16.h),
                    Opacity(
                      opacity: .7,
                      child: Text(
                        "Users Lists",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Gap(16.h),
                    Consumer<UserProvider>(
                      builder: (context, userProvider, child) {
                        List<UserData> filteredUserData = userProvider.userData;
                        if (userProvider.selectedSort == 1) {
                          filteredUserData = filteredUserData
                              .where((user) => user.age > 60)
                              .toList();
                        } else if (userProvider.selectedSort == 2) {
                          filteredUserData = filteredUserData
                              .where((user) => user.age <= 60)
                              .toList();
                        } else {
                          filteredUserData = userProvider.userData;
                        }

                        if (search.text.isNotEmpty) {
                          filteredUserData = filteredUserData
                              .where((user) => user.name
                                  .toLowerCase()
                                  .contains(search.text.toLowerCase()))
                              .toList();
                        }

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return UsersList(
                              image: filteredUserData[index].imagePath,
                              name: filteredUserData[index].name,
                              age: filteredUserData[index].age,
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 8.h),
                          itemCount: filteredUserData.length,
                        );
                      },
                    ),
                    Gap(18.h),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
