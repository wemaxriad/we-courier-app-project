import '/Controllers/parcel_all_status_controller.dart';
import '/Models/parcel_status_model.dart';
import '/Screen/Parcel/status_wise_parcel.dart';
import '/Screen/Widgets/shimmer/parcel_all_status_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Widgets/constant.dart';

class ParcelAllStatus extends StatefulWidget {
  const ParcelAllStatus({Key? key}) : super(key: key);

  @override
  State<ParcelAllStatus> createState() => _ParcelAllStatusState();
}

class _ParcelAllStatusState extends State<ParcelAllStatus> {
  Widget _buildSummarySection(int totalCategories) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: kAccentLight,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: kAccentLine),
        ),
        child: Row(
          children: [
            Text(
              totalCategories.toString(),
              style: kTextStyle.copyWith(
                color: kMainColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'Parcel Categories'.tr,
                style: kTextStyle.copyWith(
                  color: kGreyTextColor,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(ParcelStatusModel category) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () =>
              StatusWiseParcel(parcelStatus: category).launch(context),
          borderRadius: BorderRadius.circular(12.r),
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: kAccentLine),
              boxShadow: [
                BoxShadow(
                  color: kMainColor.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    width: 4.w,
                    decoration: BoxDecoration(
                      color: kMainColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        bottomLeft: Radius.circular(12.r),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 9.h,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36.w,
                            height: 36.w,
                            decoration: BoxDecoration(
                              color: kAccentLight,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Icon(
                              FeatherIcons.package,
                              color: kMainColor,
                              size: 17.sp,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              category.status!,
                              style: kTextStyle.copyWith(
                                color: kTitleColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            color: kGreyTextColor,
                            size: 18.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        title: Text(
          'Parcel Category'.tr,
          style: kTextStyle.copyWith(
            color: kBgColor,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: kBgColor),
      ),
      body: GetBuilder<ParcelAllStatusController>(
        init: ParcelAllStatusController(),
        builder: (controller) {
          return Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28.0),
                topRight: Radius.circular(28.0),
              ),
              color: kBgColor,
            ),
            child: controller.loader
                ? const ParcelAllStatusShimmer()
                : controller.parcelAllStatus.isEmpty
                    ? ListView(
                        padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 16.h),
                        children: [
                          _buildSummarySection(0),
                        ],
                      )
                    : ListView.builder(
                        padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 16.h),
                        itemCount: controller.parcelAllStatus.length + 1,
                        itemBuilder: (_, index) {
                          if (index == 0) {
                            return _buildSummarySection(
                              controller.parcelAllStatus.length,
                            );
                          }

                          return _buildCategoryCard(
                            controller.parcelAllStatus[index - 1],
                          );
                        },
                      ),
          );
        },
      ),
    );
  }
}
