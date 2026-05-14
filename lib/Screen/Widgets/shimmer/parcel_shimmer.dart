import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant.dart';
import 'package:shimmer/shimmer.dart';

class ParcelShimmer extends StatelessWidget {
  const ParcelShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 16.h),
      children: [
        Shimmer.fromColors(
          highlightColor: Colors.grey[400]!,
          baseColor: Colors.grey[300]!,
          child: Column(
            children: [
              Container(
                height: 68.h,
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: kAccentLight,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: kAccentLine),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 14.h,
                            width: 120.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            height: 10.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                height: 38.h,
                child: Row(
                  children: List.generate(
                    4,
                    (_) => Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 8.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        ...List.generate(4, (_) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Shimmer.fromColors(
              highlightColor: Colors.grey[400]!,
              baseColor: Colors.grey[300]!,
              child: Container(
                height: 118.h,
                decoration: BoxDecoration(
                  color: kBgColor,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: kAccentLine),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
