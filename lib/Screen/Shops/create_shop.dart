import '/Screen/Widgets/button_global.dart';
import '/Screen/Widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart' hide redColor;
import 'package:get/get.dart';

import '../../Controllers/shop_controller.dart';
import '../../utils/size_config.dart';
import '../Widgets/loader.dart';

class CreateShops extends StatefulWidget {
  const CreateShops({Key? key}) : super(key: key);

  @override
  State<CreateShops> createState() => _CreateShopsState();
}

class _CreateShopsState extends State<CreateShops> {
  ShopController shopController = ShopController();
  final _formKey = GlobalKey<FormState>();
  String status = 'active'.tr;
  final List<String> selectStatus = [
    'active'.tr,
    'inactive'.tr,
  ];

  static const double _formHorizontalPadding = 20;
  static const double _fieldSpacing = 12;
  static const double _fieldRadius = 10;

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

  Widget _buildStatusChips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${'status'.tr}*',
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
          children: selectStatus.map((value) {
            final isActiveStatus = value == 'active'.tr;
            final isSelected = status == value;

            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => setState(() => status = value),
                borderRadius: BorderRadius.circular(20.r),
                child: Ink(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (isActiveStatus
                            ? green.withOpacity(0.12)
                            : kGreyTextColor.withOpacity(0.12))
                        : Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSelected
                          ? (isActiveStatus ? green : kGreyTextColor)
                          : kAccentLine,
                    ),
                  ),
                  child: Text(
                    value,
                    style: kTextStyle.copyWith(
                      color: isSelected
                          ? (isActiveStatus ? green : kGreyTextColor)
                          : kTitleColor,
                      fontSize: 12.sp,
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

  Widget _buildFormFields(ShopController shop) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            showCursor: true,
            controller: shop.nameController,
            validator: (value) {
              if (shop.nameController.text.isEmpty) {
                return "this_field_can_t_be_empty".tr;
              }
              return null;
            },
            cursorColor: kTitleColor,
            textFieldType: TextFieldType.NAME,
            decoration: _fieldDecoration(
              label: '${'name'.tr}*',
              hint: 'enter_name'.tr,
            ),
          ),
          SizedBox(height: _fieldSpacing.h),
          AppTextField(
            showCursor: true,
            controller: shop.phoneController,
            validator: (value) {
              if (shop.phoneController.text.isEmpty) {
                return "this_field_can_t_be_empty".tr;
              }
              return null;
            },
            cursorColor: kTitleColor,
            textFieldType: TextFieldType.PHONE,
            decoration: _fieldDecoration(
              label: '${'mobile'.tr}*',
              hint: 'enter_phone_number'.tr,
            ),
          ),
          SizedBox(height: _fieldSpacing.h),
          TextFormField(
            controller: shop.addressController,
            validator: (value) {
              if (shop.addressController.text.isEmpty) {
                return "this_field_can_t_be_empty";
              }
              return null;
            },
            cursorColor: kTitleColor,
            minLines: 2,
            maxLines: 3,
            style: kTextStyle.copyWith(
              color: kTitleColor,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.start,
            decoration: _fieldDecoration(
              label: '${'address'.tr}*',
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 10.h,
              ),
            ),
          ),
          SizedBox(height: _fieldSpacing.h),
          _buildStatusChips(),
        ],
      ),
    );
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
          'create_shop'.tr,
          style: kTextStyle.copyWith(color: kBgColor),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Icon(
              FeatherIcons.x,
              color: kBgColor,
            ).onTap(() => finish(context)),
          ),
        ],
        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: kBgColor),
      ),
      body: GetBuilder<ShopController>(
        init: ShopController(),
        builder: (shop) => Stack(
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
                      child: _buildFormFields(shop),
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
                    child: ButtonGlobal(
                      buttontext: 'submit'.tr,
                      buttonDecoration: kButtonDecoration,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          shop.shopPost(status);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            if (shop.loader)
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
