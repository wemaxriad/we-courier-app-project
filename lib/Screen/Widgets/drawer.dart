// // ignore_for_file: must_be_immutable, deprecated_member_use
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:shimmer/shimmer.dart';
//
// import '../../Controllers/global-controller.dart';
// import '../../utils/responsive.dart';
// import '../Frauds/frauds.dart';
// import '../Home/home.dart';
// // import '../MyWallet/myWalletList.dart';
// import '../Parcel/parcel_all_staus.dart';
// import '../Parcel/parcel_index.dart';
// import '../Payment/AccTransaction/acc_transaction.dart';
// import '../Payment/PaymentRequest/invoice_list.dart';
// import '../Payment/PaymentRequest/payment_request.dart';
// import '../Payment/Statement/date_to_date_statement.dart';
// import '../Payment/payment_acc.dart';
// import '../Shops/shops.dart';
// import '../Support/support.dart';
// import '../cod_charges.dart';
// import '../delivery_charges.dart';
// import 'constant.dart';
//
// class DrawerView extends StatelessWidget implements PreferredSizeWidget {
//   const DrawerView({super.key});
//
//   @override
//   Size get preferredSize => const Size.fromHeight(70);
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       Drawer(
//         backgroundColor: kBgColor,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 50.0),
//                 Container(
//                   padding: const EdgeInsets.all(5.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.0),
//                     color: kMainColor,
//                   ),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       CachedNetworkImage(
//                         imageUrl: Get.find<GlobalController>().userImage == null ? 'assets/images/profile.png' : Get.find<GlobalController>().userImage.toString(),
//                         imageBuilder: (context, imageProvider) => CircleAvatar(
//                           radius: 25.0,
//                           backgroundImage: imageProvider,
//                           backgroundColor: Colors.transparent,
//                         ),
//                         placeholder: (context, url) => Shimmer.fromColors(
//                           child: CircleAvatar(radius: 25.0),
//                           baseColor: Colors.grey[300]!,
//                           highlightColor: Colors.grey[400]!,
//                         ),
//                         errorWidget: (context, url, error) => Icon(
//                           CupertinoIcons.person,
//                           size: 30,
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           if (Get.find<GlobalController>().userName != null)
//                             Text(
//                               Get.find<GlobalController>().userName.toString(),
//                               style: kTextStyle.copyWith(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
//                             ),
//                           if (Get.find<GlobalController>().userEmail != null)
//                             SizedBox(
//                               width: responsiveWidth(context, 0.5),
//                               child: Text(
//                                 Get.find<GlobalController>().userEmail.toString(),
//                                 style: kTextStyle.copyWith(color: Colors.white,fontSize: 12,),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 ListTile(
//                   onTap: (() => const Home().launch(context)),
//                   contentPadding: EdgeInsets.zero,
//                   horizontalTitleGap: 15,
//                   leading: const Icon(
//                     FontAwesomeIcons.house,
//                     color: kTitleColor,
//                     size: 18.0,
//                   ),
//                   title: Text(
//                     'dashboard'.tr,
//                     style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
//                   ),
//                   trailing: Container(
//                     padding: const EdgeInsets.all(2.0),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(FeatherIcons.chevronRight, color: kTitleColor, size: 18),
//                   ),
//                 ),
//                 ListTile(
//                   contentPadding: EdgeInsets.zero,
//                   horizontalTitleGap: 15,
//                   leading: const Icon(
//                     FontAwesomeIcons.shop,
//                     color: kTitleColor,
//                     size: 18.0,
//                   ),
//                   onTap: (() => const ShopsPage().launch(context)),
//                   title: Text(
//                     'shop'.tr,
//                     style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
//                   ),
//                   trailing: Container(
//                     padding: const EdgeInsets.all(2.0),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(FeatherIcons.chevronRight, color: kTitleColor, size: 18),
//                   ),
//                 ),
//                 // ListTile(
//                 //   contentPadding: EdgeInsets.zero,
//                 //   horizontalTitleGap: 20,
//                 //   leading: const Icon(
//                 //     FontAwesomeIcons.wallet,
//                 //     color: kTitleColor,
//                 //     size: 18.0,
//                 //   ),
//                 //   onTap: (() => const MyWalletPage().launch(context)),
//                 //   title: Text(
//                 //     'my_wallet'.tr,
//                 //     style: kTextStyle.copyWith(fontSize: 16,
//                 //         color: kTitleColor, fontWeight: FontWeight.bold),
//                 //   ),
//                 //   trailing: Container(
//                 //     padding: const EdgeInsets.all(2.0),
//                 //     decoration: BoxDecoration(
//                 //       shape: BoxShape.circle,),
//                 //     child: const Icon(FeatherIcons.chevronRight,
//                 //         color: kTitleColor, size: 18),
//                 //   ),
//                 // ),
//                 ListTileTheme(
//                   iconColor: kTitleColor,
//                   contentPadding: const EdgeInsets.all(0),
//                   dense: true,
//                   horizontalTitleGap: 20,
//                   minLeadingWidth: 0,
//                   child: ExpansionTile(
//                     leading: const Icon(FontAwesomeIcons.solidFileLines, size: 18.0, color: kTitleColor),
//                     title: Text(
//                       'parcels'.tr,
//                       style: kTextStyle.copyWith(color: kTitleColor,fontSize: 16.0, fontWeight: FontWeight.bold),
//                     ),
//                     trailing: Container(
//                       padding: const EdgeInsets.all(2.0),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Icon(FeatherIcons.chevronDown, color: kTitleColor, size: 18),
//                     ),
//                     children: [
//                       ListTile(
//                         title: Padding(
//                           padding: const EdgeInsets.only(left: 20.0),
//                           child: Text(
//                             'parcels'.tr,
//                             style: kTextStyle.copyWith(color: kGreyTextColor,fontSize: 15.0, fontWeight: FontWeight.w600),
//                           ),
//                         ),
//                         onTap: (() => ParcelPage(
//                           height: 0.85,
//                         ).launch(context)),
//                       ),
//                       ListTile(
//                         title: Padding(
//                           padding: const EdgeInsets.only(left: 20.0),
//                           child: Text(
//                             'Parcel Categories'.tr,
//                             style: kTextStyle.copyWith(color: kGreyTextColor,fontSize: 15.0, fontWeight: FontWeight.w600),
//                           ),
//                         ),
//                         onTap: (() => const ParcelAllStatus().launch(context)),
//                       ),
//                     ],
//                   ),
//                 ),
//                 ListTile(
//                   onTap: (() => const Frauds().launch(context)),
//                   contentPadding: EdgeInsets.zero,
//                   horizontalTitleGap: 15,
//                   leading: const Icon(
//                     FontAwesomeIcons.boxArchive,
//                     color: kTitleColor,
//                     size: 18.0,
//                   ),
//                   title: Text(
//                     'fraud_check'.tr,
//                     style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
//                   ),
//                   trailing: Container(
//                     padding: const EdgeInsets.all(2.0),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(FeatherIcons.chevronRight, color: kTitleColor, size: 18),
//                   ),
//                 ),
//
//                 ListTileTheme(
//                     iconColor: kTitleColor,
//                     contentPadding: const EdgeInsets.all(0),
//                     dense: true,
//                     horizontalTitleGap: 20,
//                     minLeadingWidth: 0,
//                     child: ExpansionTile(
//                       leading: const Icon(FontAwesomeIcons.users, size: 18.0, color: kTitleColor),
//                       title: Text(
//                         'Payments'.tr,
//                         style: kTextStyle.copyWith(color: kTitleColor,fontSize: 16.0, fontWeight: FontWeight.bold),
//                       ),
//                       trailing: Container(
//                         padding: const EdgeInsets.all(2.0),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(FeatherIcons.chevronDown, color: kTitleColor, size: 18),
//                       ),
//                       children: [
//                         ListTile(
//                           title: Padding(
//                             padding: const EdgeInsets.only(left: 20.0),
//                             child: Text(
//                               'payment_account'.tr,
//                               style: kTextStyle.copyWith(color: kGreyTextColor,fontSize: 15.0, fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                           onTap: (() => const PaymentAcc().launch(context)),
//                         ),
//                         ListTile(
//                           title: Padding(
//                             padding: const EdgeInsets.only(left: 20.0),
//                             child: Text(
//                               'payment_request'.tr,
//                               style: kTextStyle.copyWith(color: kGreyTextColor,fontSize: 15.0, fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                           onTap: (() => const PaymentReq().launch(context)),
//                         ),
//                         ListTile(
//                           title: Padding(
//                             padding: const EdgeInsets.only(left: 20.0),
//                             child: Text(
//                               'Payments/Invoices'.tr,
//                               style: kTextStyle.copyWith(color: kGreyTextColor,fontSize: 15.0, fontWeight: FontWeight.w600),
//                             ),
//                           ),
//                           onTap: (() => const InvoiceList().launch(context)),
//                         ),
//                       ],
//                     )),
//                 ListTileTheme(
//                   iconColor: kTitleColor,
//                   contentPadding: const EdgeInsets.all(0),
//                   dense: true,
//                   horizontalTitleGap: 20,
//                   minLeadingWidth: 0,
//                   child: ExpansionTile(
//                     leading: const Icon(FontAwesomeIcons.solidFileLines, size: 18.0, color: kTitleColor),
//                     title: Text(
//                       'reports'.tr,
//                       style: kTextStyle.copyWith(color: kTitleColor,fontSize: 16.0, fontWeight: FontWeight.bold),
//                     ),
//                     trailing: Container(
//                       padding: const EdgeInsets.all(2.0),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Icon(FeatherIcons.chevronDown, color: kTitleColor, size: 18),
//                     ),
//                     children: [
//                       ListTile(
//                         title: Padding(
//                           padding: const EdgeInsets.only(left: 20.0),
//                           child: Text(
//                             'account_transaction'.tr,
//                             style: kTextStyle.copyWith(color: kGreyTextColor,fontSize: 15.0, fontWeight: FontWeight.w600),
//                           ),
//                         ),
//                         onTap: (() => const AccTransaction().launch(context)),
//                       ),
//                       ListTile(
//                         title: Padding(
//                           padding: const EdgeInsets.only(left: 20.0),
//                           child: Text(
//                             'statements'.tr,
//                             style: kTextStyle.copyWith(color: kGreyTextColor,fontSize: 15.0, fontWeight: FontWeight.w600),
//                           ),
//                         ),
//                         onTap: (() => const DateToDateStatement().launch(context)),
//                       ),
//                     ],
//                   ),
//                 ),
//                 ListTileTheme(
//                     iconColor: kTitleColor,
//                     contentPadding: const EdgeInsets.all(0),
//                     dense: true,
//                     horizontalTitleGap: 20,
//                     minLeadingWidth: 0,
//                     child: ExpansionTile(
//                       leading: const Icon(FontAwesomeIcons.gears, size: 18.0, color: kTitleColor),
//                       title: Text(
//                         'setting'.tr,
//                         style: kTextStyle.copyWith(color: kTitleColor,fontSize: 16.0, fontWeight: FontWeight.bold),
//                       ),
//                       trailing: Container(
//                         padding: const EdgeInsets.all(2.0),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(FeatherIcons.chevronDown, color: kTitleColor, size: 18),
//                       ),
//                       children: [
//                         ListTile(
//                           onTap: (() => const CodChargeList().launch(context)),
//                           title: Text(
//                             'cod_charges'.tr,
//                             style: kTextStyle.copyWith(color: kGreyTextColor,fontSize: 15.0),
//                           ),
//                         ),
//                         ListTile(
//                           onTap: (() => const DeliveryChargeList().launch(context)),
//                           title: Text(
//                             'delivery_charges'.tr,
//                             style: kTextStyle.copyWith(color: kGreyTextColor,fontSize: 15.0),
//                           ),
//                         ),
//                       ],
//                     )),
//                 ListTile(
//                   onTap: () => {Get.find<GlobalController>().userLogout(), Navigator.of(context).pop()},
//                   contentPadding: EdgeInsets.zero,
//                   horizontalTitleGap: 15,
//                   leading: const Icon(
//                     Icons.exit_to_app,
//                     color: kTitleColor,
//                     size: 18.0,
//                   ),
//                   title: Text(
//                     'log_out'.tr,
//                     style: kTextStyle.copyWith(color: kTitleColor, fontWeight: FontWeight.bold),
//                   ),
//                   trailing: Container(
//                     padding: const EdgeInsets.all(2.0),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(FeatherIcons.chevronRight, color: kTitleColor, size: 18),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//   }
// }
//

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../Controllers/global-controller.dart';
import '../Frauds/frauds.dart';
import '../Home/home.dart';
import '../Parcel/parcel_all_staus.dart';
import '../Parcel/parcel_index.dart';
import '../Payment/AccTransaction/acc_transaction.dart';
import '../Payment/PaymentRequest/invoice_list.dart';
import '../Payment/PaymentRequest/payment_request.dart';
import '../Payment/Statement/date_to_date_statement.dart';
import '../Payment/payment_acc.dart';
import '../Shops/shops.dart';
import '../cod_charges.dart';
import '../delivery_charges.dart';
import 'constant.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    // drawer width কমানো
    return SizedBox(
      width: 260.w,
      child: Drawer(
        backgroundColor: kBgColor,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(24.r),
              bottomRight: Radius.circular(24.r),
            ),
            boxShadow: [
              BoxShadow(
                color: kMainColor.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(4, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildDrawerGeometricHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 4.h), // padding কমানো
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMenuItem(
                        icon: FontAwesomeIcons.house,
                        title: 'dashboard'.tr,
                        onTap: () => const Home().launch(context),
                      ),
                      _buildMenuItem(
                        icon: FontAwesomeIcons.shop,
                        title: 'shop'.tr,
                        onTap: () => const ShopsPage().launch(context),
                      ),
                      _buildExpansionTile(
                        icon: FontAwesomeIcons.solidFileLines,
                        title: 'parcels'.tr,
                        children: [
                          _buildSubMenuItem(
                            title: 'parcels'.tr,
                            onTap: () => ParcelPage(height: 0.85).launch(context),
                          ),
                          _buildSubMenuItem(
                            title: 'Parcel Categories'.tr,
                            onTap: () => const ParcelAllStatus().launch(context),
                          ),
                        ],
                      ),
                      _buildMenuItem(
                        icon: FontAwesomeIcons.boxArchive,
                        title: 'fraud_check'.tr,
                        onTap: () => const Frauds().launch(context),
                      ),
                      _buildExpansionTile(
                        icon: FontAwesomeIcons.users,
                        title: 'Payments'.tr,
                        children: [
                          _buildSubMenuItem(
                            title: 'payment_account'.tr,
                            onTap: () => const PaymentAcc().launch(context),
                          ),
                          _buildSubMenuItem(
                            title: 'payment_request'.tr,
                            onTap: () => const PaymentReq().launch(context),
                          ),
                          _buildSubMenuItem(
                            title: 'Payments/Invoices'.tr,
                            onTap: () => const InvoiceList().launch(context),
                          ),
                        ],
                      ),
                      _buildExpansionTile(
                        icon: FontAwesomeIcons.solidFileLines,
                        title: 'reports'.tr,
                        children: [
                          _buildSubMenuItem(
                            title: 'account_transaction'.tr,
                            onTap: () => const AccTransaction().launch(context),
                          ),
                          _buildSubMenuItem(
                            title: 'statements'.tr,
                            onTap: () => const DateToDateStatement().launch(context),
                          ),
                        ],
                      ),
                      _buildExpansionTile(
                        icon: FontAwesomeIcons.gears,
                        title: 'setting'.tr,
                        children: [
                          _buildSubMenuItem(
                            title: 'cod_charges'.tr,
                            onTap: () => const CodChargeList().launch(context),
                          ),
                          _buildSubMenuItem(
                            title: 'delivery_charges'.tr,
                            onTap: () => const DeliveryChargeList().launch(context),
                          ),
                        ],
                      ),
                      Divider(height: 12.h, thickness: 1, color: kAccentLine), // height কমানো
                      _buildMenuItem(
                        icon: Icons.exit_to_app,
                        title: 'log_out'.tr,
                        onTap: () {
                          Get.find<GlobalController>().userLogout();
                          Navigator.of(context).pop();
                        },
                        isLogout: true,
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // হেডার: ইমেজ উপরে, বাকি তথ্য নিচে (কলাম)
  Widget _buildDrawerGeometricHeader(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    const bodyH = 218.0;
    return SizedBox(
      height: bodyH + topInset,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(color: kMainColor),
            Positioned(
              top: -48 + topInset * 0.15,
              left: -36,
              child: Transform.rotate(
                angle: -0.42,
                child: Container(
                  width: 220,
                  height: 340,
                  color: kMainColor.withOpacity(0.78),
                ),
              ),
            ),
            Positioned(
              top: 28 + topInset * 0.2,
              right: -72,
              child: Transform.rotate(
                angle: 0.42,
                child: Container(
                  width: 260,
                  height: 230,
                  color: Colors.white.withOpacity(0.22),
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              top: topInset + 16,
              bottom: 16,
              child: GetBuilder<GlobalController>(
                builder: (gc) {
                  final name = gc.userName?.trim() ?? '';
                  final email = gc.userEmail?.trim() ?? '';
                  final phone = gc.userPhone?.trim() ?? '';
                  final address = gc.userAddress?.trim() ?? '';
                  final hasImg = gc.userImage != null && gc.userImage!.trim().isNotEmpty;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ইমেজ উপরে
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: hasImg
                            ? _buildProfileImage(imageUrl: gc.userImage, radius: 40)
                            : CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: Text(
                            _drawerInitialsFromName(name),
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              color: kMainColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      // নাম ও অন্যান্য তথ্য সেন্টার অ্যালাইনমেন্ট সহ
                      if (name.isNotEmpty)
                        Text(
                          name.toUpperCase(),
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Colors.white,
                            letterSpacing: 0.4,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      if (email.isNotEmpty) ...[
                        SizedBox(height: 6.h),
                        Text(
                          email,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.95),
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      if (phone.isNotEmpty) ...[
                        SizedBox(height: 4.h),
                        Text(
                          phone,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: Colors.white.withOpacity(0.92),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                      if (address.isNotEmpty) ...[
                        SizedBox(height: 4.h),
                        Text(
                          address,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: Colors.white.withOpacity(0.88),
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // হেল্পার মেথড: প্রোফাইল ইমেজ
  Widget _buildProfileImage({required String? imageUrl, required double radius}) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        width: radius * 2,
        height: radius * 2,
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[400]!,
          child: CircleAvatar(radius: radius),
        ),
        errorWidget: (context, url, error) => CircleAvatar(
          radius: radius,
          backgroundColor: Colors.white,
          child: const Icon(Icons.person, color: kMainColor),
        ),
      ),
    );
  }

  String _drawerInitialsFromName(String name) {
    final parts = name.trim().split(' ');
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  // মেনু আইটেম – gap কমানো (vertical padding 2.h)
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
      leading: Icon(
        icon,
        size: 20.sp,
        color: isLogout ? kDangerColor : kMainColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: isLogout ? kDangerColor : kTitleColor,
        ),
      ),
      trailing: Icon(
        FeatherIcons.chevronRight,
        size: 16.sp,
        color: kGreyTextColor,
      ),
      onTap: onTap,
    );
  }

  Widget _buildExpansionTile({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Theme(
      data: Theme.of(Get.context!).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: Icon(icon, size: 20.sp, color: kMainColor),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: kTitleColor,
          ),
        ),
        trailing: Icon(
          FeatherIcons.chevronDown,
          size: 16.sp,
          color: kGreyTextColor,
        ),
        childrenPadding: EdgeInsets.only(left: 44.w),
        tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
        children: children,
      ),
    );
  }

  Widget _buildSubMenuItem({
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: kGreyTextColor,
        ),
      ),
      onTap: onTap,
    );
  }
}