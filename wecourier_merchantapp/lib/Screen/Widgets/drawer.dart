// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../Controllers/global-controller.dart';
import '../../utils/responsive.dart';
import '../Frauds/frauds.dart';
import '../Home/home.dart';
// import '../MyWallet/myWalletList.dart';
import '../Parcel/parcel_all_staus.dart';
import '../Parcel/parcel_index.dart';
import '../Payment/AccTransaction/acc_transaction.dart';
import '../Payment/PaymentRequest/invoice_list.dart';
import '../Payment/PaymentRequest/payment_request.dart';
import '../Payment/Statement/date_to_date_statement.dart';
import '../Payment/payment_acc.dart';
import '../Shops/shops.dart';
import '../Support/support.dart';
import '../cod_charges.dart';
import '../delivery_charges.dart';
import 'constant.dart';

class DrawerView extends StatelessWidget implements PreferredSizeWidget {
  const DrawerView({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return
      Drawer(
        backgroundColor: kBgColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50.0),
                Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: kMainColor,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: Get.find<GlobalController>().userImage == null ? 'assets/images/profile.png' : Get.find<GlobalController>().userImage.toString(),
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: 25.0,
                          backgroundImage: imageProvider,
                          backgroundColor: Colors.transparent,
                        ),
                        placeholder: (context, url) => Shimmer.fromColors(
                          child: CircleAvatar(radius: 25.0),
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[400]!,
                        ),
                        errorWidget: (context, url, error) => Icon(
                          CupertinoIcons.person,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (Get.find<GlobalController>().userName != null)
                            Text(
                              Get.find<GlobalController>().userName.toString(),
                              style: kTextStyle.copyWith(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          if (Get.find<GlobalController>().userEmail != null)
                            SizedBox(
                              width: responsiveWidth(context, 0.5),
                              child: Text(
                                Get.find<GlobalController>().userEmail.toString(),
                                style: kTextStyle.copyWith(color: Colors.white,fontSize: 12,),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                ListTile(
                  onTap: (() => const Home().launch(context)),
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 15,
                  leading: const Icon(
                    FontAwesomeIcons.house,
                    color: kTitleColor,
                    size: 18.0,
                  ),
                  title: Text(
                    'dashboard'.tr,
                    style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(FeatherIcons.chevronRight, color: kTitleColor, size: 18),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 15,
                  leading: const Icon(
                    FontAwesomeIcons.shop,
                    color: kTitleColor,
                    size: 18.0,
                  ),
                  onTap: (() => const ShopsPage().launch(context)),
                  title: Text(
                    'shop'.tr,
                    style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(FeatherIcons.chevronRight, color: kTitleColor, size: 18),
                  ),
                ),
                // ListTile(
                //   contentPadding: EdgeInsets.zero,
                //   horizontalTitleGap: 20,
                //   leading: const Icon(
                //     FontAwesomeIcons.wallet,
                //     color: kTitleColor,
                //     size: 18.0,
                //   ),
                //   onTap: (() => const MyWalletPage().launch(context)),
                //   title: Text(
                //     'my_wallet'.tr,
                //     style: kTextStyle.copyWith(fontSize: 16,
                //         color: kTitleColor, fontWeight: FontWeight.bold),
                //   ),
                //   trailing: Container(
                //     padding: const EdgeInsets.all(2.0),
                //     decoration: BoxDecoration(
                //       shape: BoxShape.circle,),
                //     child: const Icon(FeatherIcons.chevronRight,
                //         color: kTitleColor, size: 18),
                //   ),
                // ),
                ListTileTheme(
                  iconColor: kTitleColor,
                  contentPadding: const EdgeInsets.all(0),
                  dense: true,
                  horizontalTitleGap: 20,
                  minLeadingWidth: 0,
                  child: ExpansionTile(
                    leading: const Icon(FontAwesomeIcons.solidFileLines, size: 18.0, color: kTitleColor),
                    title: Text(
                      'parcels'.tr,
                      style: kTextStyle.copyWith(color: kTitleColor,fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(FeatherIcons.chevronDown, color: kTitleColor, size: 18),
                    ),
                    children: [
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'parcels'.tr,
                            style: kTextStyle.copyWith(color: kGreyTextColor,fontSize: 15.0, fontWeight: FontWeight.w600),
                          ),
                        ),
                        onTap: (() => ParcelPage(
                          height: 0.85,
                        ).launch(context)),
                      ),
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Parcel Categories'.tr,
                            style: kTextStyle.copyWith(color: kGreyTextColor,fontSize: 15.0, fontWeight: FontWeight.w600),
                          ),
                        ),
                        onTap: (() => const ParcelAllStatus().launch(context)),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  onTap: (() => const Frauds().launch(context)),
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 15,
                  leading: const Icon(
                    FontAwesomeIcons.boxArchive,
                    color: kTitleColor,
                    size: 18.0,
                  ),
                  title: Text(
                    'fraud_check'.tr,
                    style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(FeatherIcons.chevronRight, color: kTitleColor, size: 18),
                  ),
                ),

                ListTileTheme(
                    iconColor: kTitleColor,
                    contentPadding: const EdgeInsets.all(0),
                    dense: true,
                    horizontalTitleGap: 20,
                    minLeadingWidth: 0,
                    child: ExpansionTile(
                      leading: const Icon(FontAwesomeIcons.users, size: 18.0, color: kTitleColor),
                      title: Text(
                        'Payments'.tr,
                        style: kTextStyle.copyWith(color: kTitleColor,fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(FeatherIcons.chevronDown, color: kTitleColor, size: 18),
                      ),
                      children: [
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'payment_account'.tr,
                              style: kTextStyle.copyWith(color: kGreyTextColor,fontSize: 15.0, fontWeight: FontWeight.w600),
                            ),
                          ),
                          onTap: (() => const PaymentAcc().launch(context)),
                        ),
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'payment_request'.tr,
                              style: kTextStyle.copyWith(color: kGreyTextColor,fontSize: 15.0, fontWeight: FontWeight.w600),
                            ),
                          ),
                          onTap: (() => const PaymentReq().launch(context)),
                        ),
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Payments/Invoices'.tr,
                              style: kTextStyle.copyWith(color: kGreyTextColor,fontSize: 15.0, fontWeight: FontWeight.w600),
                            ),
                          ),
                          onTap: (() => const InvoiceList().launch(context)),
                        ),
                      ],
                    )),
                ListTileTheme(
                  iconColor: kTitleColor,
                  contentPadding: const EdgeInsets.all(0),
                  dense: true,
                  horizontalTitleGap: 20,
                  minLeadingWidth: 0,
                  child: ExpansionTile(
                    leading: const Icon(FontAwesomeIcons.solidFileLines, size: 18.0, color: kTitleColor),
                    title: Text(
                      'reports'.tr,
                      style: kTextStyle.copyWith(color: kTitleColor,fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(FeatherIcons.chevronDown, color: kTitleColor, size: 18),
                    ),
                    children: [
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'account_transaction'.tr,
                            style: kTextStyle.copyWith(color: kGreyTextColor,fontSize: 15.0, fontWeight: FontWeight.w600),
                          ),
                        ),
                        onTap: (() => const AccTransaction().launch(context)),
                      ),
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'statements'.tr,
                            style: kTextStyle.copyWith(color: kGreyTextColor,fontSize: 15.0, fontWeight: FontWeight.w600),
                          ),
                        ),
                        onTap: (() => const DateToDateStatement().launch(context)),
                      ),
                    ],
                  ),
                ),
                ListTileTheme(
                    iconColor: kTitleColor,
                    contentPadding: const EdgeInsets.all(0),
                    dense: true,
                    horizontalTitleGap: 20,
                    minLeadingWidth: 0,
                    child: ExpansionTile(
                      leading: const Icon(FontAwesomeIcons.gears, size: 18.0, color: kTitleColor),
                      title: Text(
                        'setting'.tr,
                        style: kTextStyle.copyWith(color: kTitleColor,fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(FeatherIcons.chevronDown, color: kTitleColor, size: 18),
                      ),
                      children: [
                        ListTile(
                          onTap: (() => const CodChargeList().launch(context)),
                          title: Text(
                            'cod_charges'.tr,
                            style: kTextStyle.copyWith(color: kGreyTextColor,fontSize: 15.0),
                          ),
                        ),
                        ListTile(
                          onTap: (() => const DeliveryChargeList().launch(context)),
                          title: Text(
                            'delivery_charges'.tr,
                            style: kTextStyle.copyWith(color: kGreyTextColor,fontSize: 15.0),
                          ),
                        ),
                      ],
                    )),
                ListTile(
                  onTap: () => {Get.find<GlobalController>().userLogout(), Navigator.of(context).pop()},
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 15,
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: kTitleColor,
                    size: 18.0,
                  ),
                  title: Text(
                    'log_out'.tr,
                    style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(FeatherIcons.chevronRight, color: kTitleColor, size: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}

