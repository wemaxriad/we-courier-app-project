import '/Screen/Shops/create_shop.dart';
import '/Screen/Shops/edit_shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart' hide redColor;
import '../../Controllers/shop_controller.dart';
import '../../Models/shop_model.dart';
import '../Widgets/constant.dart';
import 'package:get/get.dart';

import '../Widgets/shimmer/shop_shimmer.dart';

class ShopsPage extends StatefulWidget {
  const ShopsPage({Key? key}) : super(key: key);

  @override
  State<ShopsPage> createState() => _ShopsState();
}

class _ShopsState extends State<ShopsPage> {
  ShopController shopController = ShopController();

  void showPopUp(id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10.0),
                  Text(
                    'do_you_want_to_delete_the_shops'.tr,
                    style: kTextStyle.copyWith(
                        color: kTitleColor, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.0),
                                  color: kMainColor),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'yes'.tr,
                                  style:
                                      kTextStyle.copyWith(color: kTitleColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ).onTap(() => shopController.shopDelete(id))),
                        const SizedBox(width: 10.0),
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              color: kGreyTextColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                'cancel'.tr,
                                style: kTextStyle.copyWith(color: kTitleColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ).onTap(
                            () => Get.back(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  int _activeShopCount(List<ShopsData> shops) {
    return shops.where((shop) => shop.status == 1).length;
  }

  bool _isDefaultShop(ShopsData shop) {
    final value = shop.defaultShop?.toLowerCase();
    return value == '1' || value == 'true' || value == 'yes';
  }

  bool _isActiveShop(ShopsData shop) {
    return shop.status == 1;
  }

  Widget _buildSummarySection(List<ShopsData> shops) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryTile(
              value: shops.length.toString(),
              label: 'shops'.tr,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _buildSummaryTile(
              value: _activeShopCount(shops).toString(),
              label: 'active'.tr,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryTile({required String value, required String label}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: kAccentLight,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: kAccentLine),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: kTextStyle.copyWith(
              color: kMainColor,
              fontSize: 22.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: kTextStyle.copyWith(
              color: kGreyTextColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShopCard(ShopsData shop) {
    final isActive = _isActiveShop(shop);

    return Container(
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  shop.name.toString(),
                  style: kTextStyle.copyWith(
                    color: kTitleColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (_isDefaultShop(shop)) ...[
                SizedBox(width: 8.w),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'Default',
                    style: kTextStyle.copyWith(
                      color: kSecondaryColor,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: isActive
                  ? green.withOpacity(0.12)
                  : kGreyTextColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              shop.statusName.toString(),
              style: kTextStyle.copyWith(
                color: isActive ? green : kGreyTextColor,
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          _buildDetailRow('contact'.tr, shop.contactNo.toString()),
          SizedBox(height: 8.h),
          _buildDetailRow('address'.tr, shop.address.toString()),
          SizedBox(height: 14.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () =>
                      EditShops(shop: shop).launch(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: kMainColor,
                    side: const BorderSide(color: kMainColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                  ),
                  child: Text(
                    'edit'.tr,
                    style: kTextStyle.copyWith(
                      color: kMainColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: TextButton(
                  onPressed: () => showPopUp(shop.id.toString()),
                  style: TextButton.styleFrom(
                    backgroundColor: redColor.withOpacity(0.1),
                    foregroundColor: redColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                  ),
                  child: Text(
                    'delete'.tr,
                    style: kTextStyle.copyWith(
                      color: redColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: kTextStyle.copyWith(
            color: kTitleColor,
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: kTextStyle.copyWith(
              color: kGreyTextColor,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'shops'.tr,
          style: kTextStyle.copyWith(
              color: kBgColor, fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: kBgColor),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => const CreateShops().launch(context),
        backgroundColor: kMainColor,
        elevation: 4,
        child: const Icon(
          FeatherIcons.plus,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: GetBuilder<ShopController>(
        init: ShopController(),
        builder: (shop) => Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28.0),
              topRight: Radius.circular(28.0),
            ),
            color: Colors.white,
          ),
          child: shop.loader
              ? const ShopShimmer()
              : shop.shopList.isNotEmpty
                  ? ListView.builder(
                      padding:
                          EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 96.h),
                      itemCount: shop.shopList.length + 1,
                      itemBuilder: (_, index) {
                        if (index == 0) {
                          return _buildSummarySection(shop.shopList);
                        }
                        return _buildShopCard(shop.shopList[index - 1]);
                      },
                    )
                  : Center(child: Text("No data found!")),
        ),
      ),
    );
  }
}
