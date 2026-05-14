import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant.dart';
import 'package:shimmer/shimmer.dart';

class ParcelAllStatusShimmer extends StatelessWidget {
  const ParcelAllStatusShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 16.h),
      itemCount: 5,
      itemBuilder: (_, index) {
        return Shimmer.fromColors(
          highlightColor: Colors.grey[400]!,
          baseColor: Colors.grey[300]!,
          child: index == 0
              ? Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Container(
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: kAccentLight,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: kAccentLine),
                    ),
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: kAccentLine),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 4.w,
                        height: 54.h,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        width: 36.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Container(
                          height: 14.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        width: 14.w,
                        height: 14.w,
                        color: Colors.white,
                      ),
                      SizedBox(width: 12.w),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
