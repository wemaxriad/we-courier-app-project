import '/Models/parcels_model.dart';
import '/Screen/Parcel/create_parcel.dart';
import '/Screen/Parcel/parcel_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../Controllers/global-controller.dart';
import '../../Controllers/parcel_all_status_controller.dart';
import '../../Controllers/parcel_controller.dart';
import '../../Models/parcel_status_model.dart';
import '../Widgets/constant.dart';
import '../Widgets/shimmer/parcel_shimmer.dart';

class ParcelPage extends StatefulWidget {
  final double height;
     ParcelPage({Key? key, required this.height}) : super(key: key);

  @override
  State<ParcelPage> createState() => _ParcelPageState();
}

class _ParcelPageState extends State<ParcelPage> {
  DateTime selectedDate = DateTime.now();
  DateTime pickupDate = DateTime.now();
  ParcelController parcelController = ParcelController();
  int? selectedStatusFilterId;

  List<Parcels> _visibleParcels(
    List<Parcels> parcels,
    List<ParcelStatusModel> statuses,
  ) {
    if (selectedStatusFilterId == null) {
      return parcels;
    }

    ParcelStatusModel? selectedStatus;
    for (final status in statuses) {
      if (status.id == selectedStatusFilterId) {
        selectedStatus = status;
        break;
      }
    }

    if (selectedStatus == null) {
      return parcels;
    }

    return parcels.where((parcel) {
      return parcel.status == selectedStatus!.id ||
          parcel.statusName == selectedStatus.status;
    }).toList();
  }

  Widget _buildHeaderBanner(int count) {
    return Container(
      width: double.infinity,
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
              border: Border.all(color: kAccentLine),
            ),
            child: Icon(
              FeatherIcons.package,
              color: kMainColor,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'parcel_list'.tr,
                  style: kTextStyle.copyWith(
                    color: kMainColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '$count ${'total_parcel'.tr}',
                  style: kTextStyle.copyWith(
                    color: kGreyTextColor,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChips(List<ParcelStatusModel> statuses) {
    return SizedBox(
      height: 38.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildStatusChip(
            label: 'All',
            isSelected: selectedStatusFilterId == null,
            onTap: () => setState(() => selectedStatusFilterId = null),
          ),
          ...statuses.map(
            (status) => _buildStatusChip(
              label: status.status ?? '',
              isSelected: selectedStatusFilterId == status.id,
              onTap: () => setState(() => selectedStatusFilterId = status.id),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.r),
          child: Ink(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected ? kMainColor : Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isSelected ? kMainColor : kAccentLine,
              ),
            ),
            child: Text(
              label,
              style: kTextStyle.copyWith(
                color: isSelected ? Colors.white : kTitleColor,
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildParcelCard(Parcels parcel) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => ParcelDetails(
            parcel: parcel,
            id: parcel.id,
          ).launch(context),
          borderRadius: BorderRadius.circular(12.r),
          child: Ink(
            decoration: BoxDecoration(
              color: kBgColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: kAccentLine),
            ),
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: kTextStyle.copyWith(
                              color: kTitleColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(text: '${'trackingId'.tr} '),
                              TextSpan(
                                text: '#${parcel.trackingId}',
                                style: kTextStyle.copyWith(
                                  color: kTitleColor,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: deleveryColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          parcel.statusName ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: kTextStyle.copyWith(
                            color: kTitleColor,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    parcel.customerName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kTextStyle.copyWith(
                      color: kTitleColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          parcel.customerPhone ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: kTextStyle.copyWith(
                            color: kGreyTextColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        '${Get.find<GlobalController>().currency}${parcel.cashCollection}',
                        style: kTextStyle.copyWith(
                          color: kMainColor,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    parcel.customerAddress ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: kTextStyle.copyWith(
                      color: kGreyTextColor,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _pickupDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: pickupDate, firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
    if (picked != null && picked != pickupDate) {
      setState(() {
        pickupDate = picked;
      });
    }
  }

  List<String> date = [
    'Today',
    'Yesterday',
    'Last 7 Days',
    'Last 30 Days',
    'This Month',
    'Last Month',
    'Custom Range',
  ];
  String selectDate = 'Today';

  DropdownButton<String> setDate() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in date) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(des),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      items: dropDownItems,
      value: selectDate,
      onChanged: (value) {
        setState(() {
          selectDate = value!;
        });
      },
    );
  }

  List<String> status = [
    'pending'.tr,
    'pickup_assign'.tr,
    'pickup_assign_cancel'.tr,
    'pickup_re_schedule_cancel'.tr,
    'pickup_re_schedule'.tr,
  ];
  String selectStatus = 'pending'.tr;

  DropdownButton<String> setStatus() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in status) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(des),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      items: dropDownItems,
      value: selectStatus,
      onChanged: (value) {
        setState(() {
          selectStatus = value!;
        });
      },
    );
  }

  void showPopUp(Parcels parcel) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        elevation: 10,
                        color: kSecondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'Invoice: #1232',
                            style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Card(
                        elevation: 10,
                        color: kSecondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            '${parcel.statusName}',
                            style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'merchant'.tr,
                    style: kTextStyle.copyWith(color: kTitleColor, fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: kGreyTextColor.withOpacity(0.5),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Text(
                        'shop_name'.tr + ':',
                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '${parcel.merchantName}',
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Text(
                        'phone'.tr + ':',
                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '${parcel.merchantMobile}',
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Text(
                        'pickup_address'.tr + ':',
                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '${parcel.merchantAddress}',
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Text(
                    'parcel_info'.tr,
                    style: kTextStyle.copyWith(color: kTitleColor, fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: kGreyTextColor.withOpacity(0.5),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Text(
                        'tracking_id'.tr + ':',
                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '${parcel.trackingId}',
                        style: kTextStyle.copyWith(color: Colors.blue),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Text(
                        'delivery_type'.tr + ':',
                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '${parcel.deliveryType}',
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Text(
                        'pickup_time'.tr + ':',
                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '${parcel.pickupDate}',
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Text(
                        'delivery_time'.tr + ':',
                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '${parcel.deliveryDate}',
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Text(
                        'total_charge_amount'.tr + ':',
                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '${parcel.totalDeliveryAmount}',
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Text(
                        'vat_amount'.tr + ':',
                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '${parcel.vatAmount}',
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Text(
                        'current_payable'.tr + ':',
                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '${parcel.currentPayable}',
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Text(
                        'cash_collection'.tr + ':',
                        style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '${parcel.cashCollection}',
                        style: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  Center(
                    child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(color: kMainColor, shape: BoxShape.circle),
                        child: const Icon(
                          FontAwesomeIcons.x,
                          color: kTitleColor,
                        )).onTap(
                      () => finish(context),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void showFilterPopUp() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 550,
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    InputDecorator(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 10.0),
                        labelText: 'date'.tr,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2.0, color: kGreyTextColor.withOpacity(0.15))),
                      ),
                      child: ListTile(
                        title: DropdownButtonHideUnderline(
                          child: setDate(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    InputDecorator(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 10.0),
                        labelText: 'pickup_date'.tr,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: kGreyTextColor.withOpacity(0.15))),
                      ),
                      child: ListTile(
                        onTap: (() => _selectDate(context)),
                        title: Text(
                          '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                          style: kTextStyle.copyWith(color: kTitleColor),
                        ),
                        trailing: const Icon(
                          FeatherIcons.calendar,
                          color: kTitleColor,
                        ),
                        contentPadding: const EdgeInsets.only(right: 10),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    InputDecorator(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 10.0),
                        labelText: 'delivery_date'.tr,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: kGreyTextColor.withOpacity(0.15))),
                      ),
                      child: ListTile(
                        onTap: (() => _pickupDate(context)),
                        title: Text(
                          '${pickupDate.day}/${pickupDate.month}/${pickupDate.year}',
                          style: kTextStyle.copyWith(color: kTitleColor),
                        ),
                        trailing: const Icon(
                          FeatherIcons.calendar,
                          color: kTitleColor,
                        ),
                        contentPadding: const EdgeInsets.only(right: 10),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    InputDecorator(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(left: 10.0),
                        labelText: 'status'.tr,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2.0, color: kGreyTextColor.withOpacity(0.15))),
                      ),
                      child: ListTile(
                        title: DropdownButtonHideUnderline(
                          child: setStatus(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    AppTextField(
                      showCursor: true,
                      cursorColor: kTitleColor,
                      textFieldType: TextFieldType.NAME,
                      decoration: kInputDecoration.copyWith(
                        labelText: 'customer_name'.tr,
                        labelStyle: kTextStyle.copyWith(color: kTitleColor),
                        hintText: 'customer_name'.tr,
                        hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    AppTextField(
                      showCursor: true,
                      cursorColor: kTitleColor,
                      textFieldType: TextFieldType.NAME,
                      decoration: kInputDecoration.copyWith(
                        labelText: 'customer_phone'.tr,
                        labelStyle: kTextStyle.copyWith(color: kTitleColor),
                        hintText: 'customer_phone'.tr,
                        hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 10,
                          color: kMainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                            child: Text(
                              'submit'.tr,
                              style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ).onTap(
                          () =>  ParcelPage(height: widget.height,).launch(context),
                        ),
                        const SizedBox(width: 5.0),
                        Card(
                          elevation: 10,
                          color: kMainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              color: kSecondaryColor,
                            ),
                            child: Text(
                              'cancel'.tr,
                              style: kTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ).onTap(
                          () =>  ParcelPage(height:widget.height).launch(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
 double heightValue = 0.78;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        title: Text(
          'parcel_list'.tr,
          style: kTextStyle.copyWith(color: kBgColor),
        ),
        actions: [
          Card(
            elevation: 0,
            color: kMainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.plus,
                    color: kBgColor,
                    size: 16.0,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    'add'.tr,
                    style: kTextStyle.copyWith(
                      color: kBgColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ).onTap(
              () => Get.to(() => CreateParcel()),
            ),
          ),
        ],
        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: kBgColor),
      ),
      body: GetBuilder<ParcelController>(
        init: ParcelController(),
        builder: (parcel) => GetBuilder<ParcelAllStatusController>(
          init: ParcelAllStatusController(),
          builder: (statusController) {
            final visibleParcels = _visibleParcels(
              parcel.parcelList,
              statusController.parcelAllStatus,
            );

            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28.0),
                  topRight: Radius.circular(28.0),
                ),
                color: kBgColor,
              ),
              child: parcel.loader
                  ? const ParcelShimmer()
                  : Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 8.h),
                          child: Column(
                            children: [
                              _buildHeaderBanner(visibleParcels.length),
                              SizedBox(height: 10.h),
                              _buildStatusChips(
                                statusController.parcelAllStatus,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: visibleParcels.isEmpty
                              ? Center(
                                  child: Text(
                                    'No data found!',
                                    style: kTextStyle.copyWith(
                                      color: kGreyTextColor,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.fromLTRB(
                                    12.w,
                                    0,
                                    12.w,
                                    16.h,
                                  ),
                                  itemCount: visibleParcels.length,
                                  itemBuilder: (_, index) {
                                    return _buildParcelCard(
                                      visibleParcels[index],
                                    );
                                  },
                                ),
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
