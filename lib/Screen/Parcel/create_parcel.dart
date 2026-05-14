import '../../MapAddress/flutter_google_places_web.dart';
import '../../services/api-list.dart';
import '/Screen/Widgets/button_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart' hide redColor;

import '../../Controllers/parcel_controller.dart';
import '../../Models/parcel_crate_model.dart';
import '../../utils/size_config.dart';
import '../Widgets/constant.dart';
import '../Widgets/loader.dart';

class CreateParcel extends StatefulWidget {
  const CreateParcel({Key? key}) : super(key: key);

  @override
  State<CreateParcel> createState() => _CreateParcelState();
}

class _CreateParcelState extends State<CreateParcel> {
  ParcelController parcelController = Get.put(ParcelController());
  final _formKey = GlobalKey<FormState>();

  final List<String> deliveryType = [
    'Same Day',
    'Next Day',
    'Sub City',
    'Outside City',
  ];
  String type = 'Same Day';

  static const double _formHorizontalPadding = 20;
  static const double _fieldSpacing = 12;
  static const double _fieldRadius = 10;
  static const double _selectorHeight = 52;

  InputDecoration _fieldDecoration({
    required String label,
    String? hint,
    EdgeInsetsGeometry? contentPadding,
  }) {
    final borderRadius = BorderRadius.circular(_fieldRadius.r);
    return kInputDecoration.copyWith(
      filled: true,
      fillColor: Colors.white,
      isDense: true,
      labelText: label,
      hintText: hint,
      labelStyle: kTextStyle.copyWith(
        color: kTitleColor,
        fontSize: 12.sp,
      ),
      hintStyle: kTextStyle.copyWith(
        color: kGreyTextColor,
        fontSize: 12.sp,
      ),
      contentPadding: contentPadding ??
          EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 10.h,
          ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: kAccentLine),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: kMainColor, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: redColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: redColor),
      ),
    );
  }

  InputDecoration _selectorDecoration({
    required String label,
    required String hint,
  }) {
    final borderRadius = BorderRadius.circular(_fieldRadius.r);
    return kInputDecoration.copyWith(
      filled: true,
      fillColor: Colors.white,
      isDense: true,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelText: label,
      hintText: hint,
      labelStyle: kTextStyle.copyWith(
        color: kTitleColor,
        fontSize: 12.sp,
      ),
      hintStyle: kTextStyle.copyWith(
        color: kGreyTextColor,
        fontSize: 12.sp,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 8.h,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: kAccentLine),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: const BorderSide(color: kMainColor, width: 1.5),
      ),
    );
  }

  Widget _buildSectionCard({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: _fieldSpacing.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: kAccentLine),
        boxShadow: [
          BoxShadow(
            color: kMainColor.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildDeliveryTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${'select_type'.tr}*',
          style: kTextStyle.copyWith(
            color: kTitleColor,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: deliveryType.map((value) {
            final isSelected = type == value;

            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    type = value;
                    Get.find<ParcelController>().deliveryTypID = type;
                  });
                },
                borderRadius: BorderRadius.circular(20.r),
                child: Ink(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? kMainColor : Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSelected ? kMainColor : kAccentLine,
                    ),
                  ),
                  child: Text(
                    value,
                    style: kTextStyle.copyWith(
                      color: isSelected ? Colors.white : kTitleColor,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  String _selectedCategoryLabel(ParcelController parcel) {
    if (parcel.deliveryChargesList.isEmpty ||
        parcel.deliveryChargesIndex.toString() == 'null') {
      return 'select_category'.tr;
    }

    final value = parcel.deliveryChargesList[parcel.deliveryChargesIndex];
    if (value.id == 0 || value.weight == '0') {
      return value.category.toString();
    }

    return '${value.category} (${value.weight})';
  }

  Widget _buildSummaryStrip(ParcelController parcel) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: kAccentLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: kAccentLine),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              type,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: kTextStyle.copyWith(
                color: kMainColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              _selectedCategoryLabel(parcel),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: kTextStyle.copyWith(
                color: kMainColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmit(BuildContext context, ParcelController parcel) {
    setState(() {
      FocusScope.of(context).requestFocus(FocusNode());
      if (_formKey.currentState!.validate()) {
        if (parcel.deliveryChargesID != '' && parcel.deliveryTypID != '') {
          parcel.customerAddressLatController.text = '';
          parcel.customerAddressLongController.text = '';
          parcel.calculateTotal(context);
        } else if (parcel.deliveryChargesID == '') {
          Get.rawSnackbar(
            message: "Please select category",
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP,
          );
        } else if (parcel.deliveryTypID == '') {
          Get.rawSnackbar(
            message: "Please select delivery type",
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP,
          );
        } else {
          Get.rawSnackbar(
            message: "Please check information",
            backgroundColor: Colors.red,
            snackPosition: SnackPosition.TOP,
          );
        }
      }
    });
  }

  @override
  void initState() {
    parcelController.crateParcel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfigCustom sizeConfig = SizeConfigCustom();
    sizeConfig.init(context);
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'create_parcel'.tr,
          style: kTextStyle.copyWith(color: kBgColor),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
            Get.find<ParcelController>().clearAll();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: kBgColor,
          ),
        ),
        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: kBgColor),
      ),
      body: GetBuilder<ParcelController>(
        init: ParcelController(),
        builder: (parcel) => Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28.0),
                        topRight: Radius.circular(28.0),
                      ),
                      color: kBgColor,
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        _formHorizontalPadding.w,
                        14.h,
                        _formHorizontalPadding.w,
                        14.h,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildSectionCard(
                              children: [
                                if (parcel.shopList.isNotEmpty) ...[
                                  SizedBox(
                                    height: _selectorHeight.h,
                                    child: FormField(
                                      builder: (FormFieldState<dynamic> field) {
                                        return InputDecorator(
                                          decoration: _selectorDecoration(
                                            label: 'shop'.tr,
                                            hint: 'select_shop'.tr,
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<Shops>(
                                              isExpanded: true,
                                              value: parcel.shopIndex.toString() ==
                                                      'null'
                                                  ? null
                                                  : parcel.shopList[
                                                      parcel.shopIndex],
                                              items: parcel.shopList
                                                  .map((Shops value) {
                                                return DropdownMenuItem<Shops>(
                                                  value: value,
                                                  child: Text(
                                                    value.name.toString(),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  parcel.shopIndex = parcel
                                                      .shopList
                                                      .indexOf(newValue!);
                                                  parcel.shopID =
                                                      newValue.id.toString();
                                                  parcel.pickupAddress =
                                                      newValue.address
                                                          .toString();
                                                  parcel.pickupPhone =
                                                      newValue.contactNo
                                                          .toString();
                                                  parcel.pickupLate =
                                                      newValue.merchantLat
                                                          .toString();
                                                  parcel.pickupLong =
                                                      newValue.merchantLong
                                                          .toString();
                                                  parcel.merchantID =
                                                      newValue.merchantId
                                                          .toString();
                                                });
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: _fieldSpacing.h),
                                ],
                                AppTextField(
                                  onChanged: (value) {
                                    setState(() {
                                      parcel.pickupPhone =
                                          parcel.pickupPhoneController.text;
                                    });
                                  },
                                  controller: parcel.pickupPhoneController
                                    ..text = parcel.pickupPhone.toString()
                                    ..selection = TextSelection.collapsed(
                                      offset: parcel
                                          .pickupPhoneController.text.length,
                                    ),
                                  showCursor: true,
                                  validator: (value) {
                                    if (parcel
                                        .pickupPhoneController.text.isEmpty) {
                                      return "this_field_can_t_be_empty".tr;
                                    }
                                    return null;
                                  },
                                  cursorColor: kTitleColor,
                                  textFieldType: TextFieldType.PHONE,
                                  decoration: _fieldDecoration(
                                    label: 'pickup_phone'.tr,
                                    hint: '017XXXXXXXX',
                                  ),
                                ),
                                SizedBox(height: _fieldSpacing.h),
                                AppTextField(
                                  onChanged: (value) {
                                    setState(() {
                                      parcel.pickupAddress =
                                          parcel.pickupAddressController.text;
                                    });
                                  },
                                  controller: parcel.pickupAddressController
                                    ..text = parcel.pickupAddress.toString()
                                    ..selection = TextSelection.collapsed(
                                      offset: parcel.pickupAddressController
                                          .text.length,
                                    ),
                                  showCursor: true,
                                  validator: (value) {
                                    if (parcel.pickupAddressController.text
                                        .isEmpty) {
                                      return "this_field_can_t_be_empty".tr;
                                    }
                                    return null;
                                  },
                                  cursorColor: kTitleColor,
                                  textFieldType: TextFieldType.NAME,
                                  decoration: _fieldDecoration(
                                    label: 'pickup_address'.tr,
                                    hint: 'enter_address'.tr,
                                  ),
                                ),
                              ],
                            ),
                            _buildSectionCard(
                              children: [
                                AppTextField(
                                  controller: parcel.cashCollectionController,
                                  validator: (value) {
                                    if (parcel
                                        .cashCollectionController.text.isEmpty) {
                                      return "this_field_can_t_be_empty".tr;
                                    }
                                    return null;
                                  },
                                  cursorColor: kTitleColor,
                                  textFieldType: TextFieldType.NAME,
                                  decoration: _fieldDecoration(
                                    label: 'cash_collection'.tr,
                                    hint: 'enter_amount'.tr,
                                  ),
                                ),
                                SizedBox(height: _fieldSpacing.h),
                                AppTextField(
                                  controller: parcel.sellingPriceController,
                                  cursorColor: kTitleColor,
                                  textFieldType: TextFieldType.NAME,
                                  decoration: _fieldDecoration(
                                    label: 'selling_price'.tr,
                                    hint: 'selling_price_of_parcel'.tr,
                                  ),
                                ),
                                SizedBox(height: _fieldSpacing.h),
                                AppTextField(
                                  controller: parcel.invoiceController,
                                  cursorColor: kTitleColor,
                                  isValidationRequired: false,
                                  textFieldType: TextFieldType.NAME,
                                  decoration: _fieldDecoration(
                                    label: 'invoice'.tr + '#',
                                    hint: 'enter_invoice_number'.tr,
                                  ),
                                ),
                                if (parcel.deliveryChargesList.isNotEmpty) ...[
                                  SizedBox(height: _fieldSpacing.h),
                                  SizedBox(
                                    height: _selectorHeight.h,
                                    child: FormField(
                                      builder: (FormFieldState<dynamic> field) {
                                        return InputDecorator(
                                          decoration: _selectorDecoration(
                                            label: 'category'.tr + '*',
                                            hint: 'select_category'.tr,
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child:
                                                DropdownButton<DeliveryCharges>(
                                              isExpanded: true,
                                              value: parcel.deliveryChargesIndex
                                                          .toString() ==
                                                      'null'
                                                  ? null
                                                  : parcel.deliveryChargesList[
                                                      parcel
                                                          .deliveryChargesIndex],
                                              items: parcel.deliveryChargesList
                                                  .map((DeliveryCharges value) {
                                                return DropdownMenuItem<
                                                    DeliveryCharges>(
                                                  value: value,
                                                  child: value.id == 0
                                                      ? Text(
                                                          value.category
                                                              .toString(),
                                                        )
                                                      : value.weight == '0'
                                                          ? Text(
                                                              value.category
                                                                  .toString(),
                                                            )
                                                          : Text(
                                                              value.category
                                                                      .toString() +
                                                                  ' (${value.weight.toString()})',
                                                            ),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  parcel.deliveryChargesIndex =
                                                      parcel.deliveryChargesList
                                                          .indexOf(newValue!);
                                                  parcel.deliveryChargesID =
                                                      newValue.id.toString();
                                                  parcel.deliveryChargesValue =
                                                      newValue;
                                                });
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                                SizedBox(height: _fieldSpacing.h),
                                _buildDeliveryTypeSelector(),
                              ],
                            ),
                            _buildSectionCard(
                              children: [
                                AppTextField(
                                  controller: parcel.customerController,
                                  validator: (value) {
                                    if (parcel.customerController.text.isEmpty) {
                                      return "this_field_can_t_be_empty".tr;
                                    }
                                    return null;
                                  },
                                  cursorColor: kTitleColor,
                                  textFieldType: TextFieldType.NAME,
                                  decoration: _fieldDecoration(
                                    label: 'customer_name'.tr + '*',
                                    hint: 'customer_name'.tr,
                                  ),
                                ),
                                SizedBox(height: _fieldSpacing.h),
                                AppTextField(
                                  controller: parcel.customerPhoneController,
                                  validator: (value) {
                                    if (parcel
                                        .customerPhoneController.text.isEmpty) {
                                      return "this_field_can_t_be_empty".tr;
                                    }
                                    return null;
                                  },
                                  cursorColor: kTitleColor,
                                  textFieldType: TextFieldType.PHONE,
                                  decoration: _fieldDecoration(
                                    label: 'customer_phone'.tr + '*',
                                    hint: 'customer_phone'.tr,
                                  ),
                                ),
                                SizedBox(height: _fieldSpacing.h),
                                AppTextField(
                                  controller: parcel.customerAddressController,
                                  validator: (value) {
                                    if (parcel
                                        .customerAddressController.text.isEmpty) {
                                      return "this_field_can_t_be_empty".tr;
                                    }
                                    return null;
                                  },
                                  cursorColor: kTitleColor,
                                  textFieldType: TextFieldType.NAME,
                                  textAlign: TextAlign.start,
                                  decoration: _fieldDecoration(
                                    label: 'customer_address'.tr + '*',
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 10.h,
                                    ),
                                  ),
                                ),
                                // Column(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   mainAxisSize: MainAxisSize.min,
                                //   children: <Widget>[
                                //     FlutterGooglePlacesWeb(apiKey: APIList.mapGoogleApiKey!, required: true, controller: parcel.customerAddressController),
                                //   ],
                                // ),
                                SizedBox(height: _fieldSpacing.h),
                                TextFormField(
                                  controller: parcel.noteController,
                                  cursorColor: kTitleColor,
                                  textAlign: TextAlign.start,
                                  minLines: 2,
                                  maxLines: 3,
                                  style: kTextStyle.copyWith(
                                    color: kTitleColor,
                                    fontSize: 14.sp,
                                  ),
                                  decoration: _fieldDecoration(
                                    label: 'note'.tr,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 10.h,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            _buildSectionCard(
                              children: [
                                Text(
                                  'choose_which_needed_for_parcel'.tr,
                                  style: kTextStyle.copyWith(
                                    color: kTitleColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      activeColor: kMainColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(2.0),
                                      ),
                                      value: parcel.isLiquidChecked,
                                      onChanged: (val) {
                                        setState(() {
                                          parcel.isLiquidChecked = val!;
                                        });
                                      },
                                    ),
                                    Text(
                                      'liquid_fragile'.tr,
                                      style:
                                          kTextStyle.copyWith(color: kTitleColor),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      activeColor: kMainColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(2.0),
                                      ),
                                      value: parcel.isParcelBankCheck,
                                      onChanged: (val) {
                                        setState(() {
                                          parcel.isParcelBankCheck = val!;
                                        });
                                      },
                                    ),
                                    Text(
                                      'is_it_parcel_bank'.tr + '?',
                                      style:
                                          kTextStyle.copyWith(color: kTitleColor),
                                    ),
                                  ],
                                ),
                                if (parcel.packagingList.isNotEmpty) ...[
                                  SizedBox(height: _fieldSpacing.h),
                                  SizedBox(
                                    height: _selectorHeight.h,
                                    child: FormField(
                                      builder: (FormFieldState<dynamic> field) {
                                        return InputDecorator(
                                          decoration: _selectorDecoration(
                                            label: 'packaging'.tr,
                                            hint: 'select_packaging'.tr,
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<Packagings>(
                                              isExpanded: true,
                                              value: parcel.packagingIndex
                                                          .toString() ==
                                                      'null'
                                                  ? null
                                                  : parcel.packagingList[
                                                      parcel.packagingIndex],
                                              items: parcel.packagingList
                                                  .map((Packagings value) {
                                                return DropdownMenuItem<
                                                    Packagings>(
                                                  value: value,
                                                  child: value.id == 0
                                                      ? Text(
                                                          value.name.toString(),
                                                        )
                                                      : Text(
                                                          value.name.toString() +
                                                              ' (${value.price.toString()})',
                                                        ),
                                                );
                                              }).toList(),
                                              onChanged: (newValue) {
                                                setState(() {
                                                  parcel.packagingIndex = parcel
                                                      .packagingList
                                                      .indexOf(newValue!);
                                                  parcel.packagingID =
                                                      newValue.id.toString();
                                                  parcel.packagingPrice =
                                                      newValue.price.toString();
                                                });
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: kBgColor,
                  padding: EdgeInsets.fromLTRB(
                    _formHorizontalPadding.w,
                    0,
                    _formHorizontalPadding.w,
                    14.h,
                  ),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildSummaryStrip(parcel),
                        SizedBox(height: 10.h),
                        ButtonGlobal(
                          buttontext: 'submit'.tr,
                          buttonDecoration: kButtonDecoration,
                          onPressed: () => _handleSubmit(context, parcel),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (parcel.loaderParcel)
              Positioned.fill(
                child: Container(
                  color: Colors.white60,
                  child: const Center(child: LoaderCircle()),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
