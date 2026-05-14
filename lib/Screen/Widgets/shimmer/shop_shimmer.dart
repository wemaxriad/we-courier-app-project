import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant.dart';
import 'package:shimmer/shimmer.dart';

class ShopShimmer extends StatefulWidget {
  const ShopShimmer({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ShopShimmerState();
  }
}

class _ShopShimmerState extends State<ShopShimmer> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 96.h),
      itemCount: 4,
      itemBuilder: (_, index) {
        return Shimmer.fromColors(
          highlightColor: Colors.grey[400]!,
          baseColor: Colors.grey[300]!,
          child: index == 0
              ? Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Row(
                    children: [
                      Expanded(child: _buildSummaryPlaceholder()),
                      SizedBox(width: 12.w),
                      Expanded(child: _buildSummaryPlaceholder()),
                    ],
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: kBgColor,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: kAccentLine),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 18.h,
                        width: 160.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        height: 22.h,
                        width: 72.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      _buildDetailPlaceholder(),
                      SizedBox(height: 8.h),
                      _buildDetailPlaceholder(),
                      SizedBox(height: 14.h),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }

  Widget _buildSummaryPlaceholder() {
    return Container(
      height: 72.h,
      decoration: BoxDecoration(
        color: kAccentLight,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: kAccentLine),
      ),
    );
  }

  Widget _buildDetailPlaceholder() {
    return Row(
      children: [
        Container(
          height: 14.h,
          width: 64.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        const Spacer(),
        Container(
          height: 14.h,
          width: 120.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ],
    );
  }
}
