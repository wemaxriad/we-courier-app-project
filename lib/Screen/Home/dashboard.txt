import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../Parcel/create_parcel.dart';
import '../Parcel/parcel_all_staus.dart';
import '../Payment/AccTransaction/acc_transaction.dart';
import '../Payment/PaymentRequest/invoice_list.dart';
import '../Payment/PaymentRequest/payment_request.dart';
import '../Payment/Statement/date_to_date_statement.dart';
import '../Payment/balance_details.dart';
import '../Payment/payment_acc.dart';
import '../Profile/profile.dart';
import '../Support/support.dart';
import '../Widgets/button_global.dart';
import '../Widgets/drawer.dart';
import '/Controllers/dashboard_controller.dart';
import '/Screen/Frauds/frauds.dart';
import '/Screen/Home/home.dart';
import '/Screen/Parcel/parcel_index.dart';
import '/Screen/Shops/shops.dart';
import '/Screen/delivery_charges.dart';
import '/utils/image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';

import '../../Controllers/global-controller.dart';
import '../../Controllers/language_controller.dart';
import '../../Models/language_model.dart';
import '../../utils/style.dart';
import '../Widgets/constant.dart';
import '../Widgets/shimmer/dashboard_shimmer.dart';
import '../cod_charges.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  LanguageController languageController = Get.put(LanguageController());
  DashboardController dashboard = Get.put(DashboardController());
  GlobalController globalController = Get.put(GlobalController());

  final box = GetStorage();
  Language? selectedLang;
  List<String> reportList = [
    'total_parcel'.tr,
    'total_delivered'.tr,
    'total_return'.tr,
    'total_transit'.tr,
  ];

  final iconList = <IconData>[
    FontAwesomeIcons.boxOpen,
    MdiIcons.truckFast,
    FontAwesomeIcons.dna,
    FontAwesomeIcons.dolly,
  ];

  List<Color> colorList = [
    const Color(0xFFEFFBF8),
    const Color(0xFFFDF9EE),
    const Color(0xFFFBEBF1),
    const Color(0xFFEFF5FA),
  ];
  List<String> imageList = [
    Images.banner1,
    Images.banner2,
    Images.banner3,
  ];


  @override
  void initState() {
    // FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {});
    //
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   Get.rawSnackbar(
    //     snackPosition: SnackPosition.TOP,
    //     title: message.notification?.title,
    //     message: message.notification?.body,
    //     backgroundColor: kMainColor.withOpacity(.9),
    //     maxWidth: ScreenSize(context).mainWidth / 1.007,
    //     margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
    //   );
    // });

    // TODO: implement initState
    super.initState();
  }

  final List<ServiceItem> services = [
    ServiceItem("pickup_point".tr, "pick_drop", "assets/images/pick_drop.png"),
    ServiceItem("create_order".tr, "pickup_request", "assets/images/pickup.png"),
    ServiceItem("parcels".tr, "parcels", "assets/images/parcel.png"),
    // ServiceItem("wallet".tr, "express_delivery", "assets/images/wallet.png"),
    ServiceItem("payments".tr, "payments", "assets/images/payment.png"),
    ServiceItem("support".tr, "support", "assets/images/support.png"),
    ServiceItem("fraud".tr, "fraud", "assets/images/fraud.png"),

  ];

  @override
  Widget build(BuildContext context) {
    selectedLang = languageController.languageList[languageController.languageList.indexWhere((i) => i.locale == Get.locale)];

    return Scaffold(
      backgroundColor: kBgColor,
      drawer:DrawerView(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        titleSpacing: 0,
        backgroundColor: kMainColor,
        elevation: 0.0,
        title: ListTile(
          horizontalTitleGap: 0,
          contentPadding: const EdgeInsets.all(10.0),
          title: Text(
            '${Get.find<GlobalController>().siteName }',
            style: kTextStyle.copyWith(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child:  CircleAvatar(
                radius:17.r,
                backgroundColor: Colors.white,
                child: PopupMenuButton(
                  icon: Image.asset(
                    selectedLang?.langName == 'English' ?Images.flagEn:selectedLang?.langName == 'Bangla' ? Images.flagBd:selectedLang?.langName == 'Spanish' ? Images.flagEs:Images.flagAr,
                    fit: BoxFit.cover,
                  ),
                  onSelected: (newValue) {
                    setState(() {
                      selectedLang = newValue;
                      if (newValue.langName == 'English') {
                        languageController.changeLanguage("en");
                      } else if (newValue.langName == 'Bangla') {
                        languageController.changeLanguage("bn");
                      } else if (newValue.langName == 'हिन्दी') {
                        languageController.changeLanguage("hi");
                      } else if (newValue.langName == 'عربي') {
                        languageController.changeLanguage("ar");
                      } else if (newValue.langName == 'Spanish') {
                        languageController.changeLanguage("es");
                      }
                    });
                  },
                  itemBuilder: (BuildContext context) {
                    return languageController.languageList.map((Language lang) {
                      return PopupMenuItem<Language>(
                        value: lang,
                        child: Text(
                          lang.langName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList();
                  },
                )
            ),
          ),
          SizedBox(width: 5,),
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: IconButton(
              onPressed: () {

              },
              icon: Badge(
                isLabelVisible:true,
                label:  Text('0',style:  TextStyle(color: textWhiteColor)),
                child:  CircleAvatar(
                  radius:17.r,
                  backgroundColor: Colors.white,
                  child: SvgPicture.asset(
                    Images.notification,
                    width: 20.w,
                    color: kMainColor,
                  ),
                ),
              )
              ,
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(()=>Profile());
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 5,right: 10,top: 10,bottom: 10),
              child: Container(
                  height: 40.h,
                  width: 32.w,
                  decoration: BoxDecoration(
                      color: kBgColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: CachedNetworkImage(
                      imageUrl: Get.find<GlobalController>().userImage.toString(),
                      imageBuilder: (context, imageProvider) => Container(
                          height: 40.h,
                          width: 32.w,
                          decoration: BoxDecoration(
                            color: kBgColor,
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.fill),
                          )),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[400]!,
                        child: const CircleAvatar(radius: 40.0),
                      ),
                      errorWidget: (context, url, error) => Container(
                          height: 40.h,
                          width: 32.w,
                          decoration: BoxDecoration(
                            color: kBgColor,
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                              image: AssetImage(
                                Images.user,
                              ),
                              fit: BoxFit.cover,
                            ),
                          )))),
            ),
          ),
        ],
      ),

      body:  GetBuilder<DashboardController>(
          builder: (dashboard) =>
              SingleChildScrollView(
                  child:dashboard.dashboardLoader
                      ? DashboardShimmer()
                      :
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kMainColor, // Background color
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25.r),  // Bottom-left radius
                            bottomRight: Radius.circular(25.r), // Bottom-right radius
                          ),
                        ),
                        child: Padding(
                          padding:  EdgeInsets.only(left: 20.r,right: 20.r,bottom: 20.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'welcome'.tr,
                                    style: TextStyle(
                                      fontSize: 17.r,
                                      fontWeight: FontWeight.w400,
                                      color: textWhiteColor,
                                    ),
                                  ),
                                  Text(
                                    '${ Get.find<GlobalController>().userName.toString()}',
                                    style: TextStyle(
                                      fontSize: 16.r,
                                      fontWeight: FontWeight.bold,
                                      color: textWhiteColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h,),
                              InkWell(
                                onTap: (){
                                  const BalanceDetails().launch(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(16.w),
                                  decoration: BoxDecoration(
                                    color: kBgColor,
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.account_balance_wallet, size: 30.w, color:kMainColor),
                                      SizedBox(width: 10.w),
                                      Text('check_balance'.tr, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                                      Spacer(),
                                      Icon(Icons.arrow_forward_ios, size: 18.w, color: Colors.grey),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Track your package section
                      Padding(
                        padding:  EdgeInsets.only(top: 0,left: 15.r,bottom: 15.r,right: 15.r),
                        child:
                        Column(
                          children: [
                            CarouselSlider.builder(
                              options: CarouselOptions(
                                height: 200,
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.8,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                onPageChanged: null,
                                scrollDirection: Axis.horizontal,
                              ),
                              // itemCount: imageList.length,
                              itemCount:  dashboard.offersList.isNotEmpty?dashboard.offersList.length:imageList.length,
                              itemBuilder:
                                  (BuildContext context, int index, int realIndex) {
                                return dashboard.offersList.isNotEmpty?
                                CachedNetworkImage(
                                  imageUrl:dashboard.offersList[index].image.toString(),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                          height: 180,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image:imageProvider
                                            ),
                                          )),
                                  placeholder: (context, url) => Shimmer.fromColors(
                                    child: Container(
                                      height: 180,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            imageList[index],
                                          ),
                                        ),
                                      ),
                                    ),
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[400]!,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                        height: 180,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                              imageList[index],
                                            ),
                                          ),
                                        ),
                                      ),
                                )
                                    :Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        imageList[index],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 5),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 0.95,
                                crossAxisSpacing: 9.w,
                                mainAxisSpacing: 15.h,
                              ),
                              itemCount: services.length,
                              itemBuilder: (context, index) {
                                return ServiceCard(service: services[index]);
                              },
                            ),
                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'merchant_dashboard'.tr,
                                    style: kTextStyle.copyWith(
                                        color: kTitleColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                GridView.count(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10.0,
                                  childAspectRatio: 1,
                                  mainAxisSpacing: 10.0,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: List.generate(
                                    4,
                                        (i) {
                                      return
                                        Card(
                                          color: colorList[i],
                                          elevation: 10,
                                          shadowColor: kMainColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(height: 20),
                                                Icon(
                                                  iconList[i],
                                                  size: 40,
                                                  color: kTitleColor,
                                                ),
                                                const SizedBox(height: 10.0),
                                                Text(
                                                  reportList[i],
                                                  style: kTextStyle.copyWith(
                                                      color: kTitleColor,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                const SizedBox(height: 10.0),
                                                Text(
                                                  i == 0? dashboard.dashboardData.tParcel.toString(): i==1?dashboard.dashboardData.tDelivered.toString():i==2?dashboard.dashboardData.tReturn.toString():i==3? "${dashboard.dashboardData.tParcel! - (dashboard.dashboardData.tDelivered! + dashboard.dashboardData.tReturn!)}" :'0',
                                                  style: kTextStyle.copyWith(
                                                      color: kTitleColor,
                                                      fontSize: 20.0,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Card(
                                  elevation: 10,
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.0),
                                        color: Colors.white),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: kGreyTextColor.withOpacity(0.2),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'total_cash_collection'.tr,
                                                    style: kTextStyle.copyWith(
                                                        color: kTitleColor),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    '${Get.find<GlobalController>()
                                                        .currency!} ${dashboard.dashboardData.tCashCollection.toString()}',
                                                    style: kTextStyle.copyWith(
                                                        color: kTitleColor),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'total_selling_price'.tr,
                                                    style: kTextStyle.copyWith(
                                                        color: kTitleColor),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    '${Get.find<GlobalController>()
                                                        .currency!} ${dashboard.dashboardData.tSellingPrice.toString()}',
                                                    style: kTextStyle.copyWith(
                                                        color: kTitleColor),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'net_profit_amount'.tr,
                                                    style: kTextStyle.copyWith(
                                                        color: kTitleColor),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    "${Get.find<GlobalController>()
                                                        .currency!} ${(dashboard.dashboardData.tCashCollection! - dashboard.dashboardData.tSellingPrice!).toStringAsFixed(2)}",
                                                    style: kTextStyle.copyWith(
                                                        color: kTitleColor),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: kGreyTextColor.withOpacity(0.2),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'total_liquid_fragile_amount'.tr,
                                                    style: kTextStyle.copyWith(
                                                        color: kTitleColor),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    "${Get.find<GlobalController>()
                                                        .currency!} ${dashboard.dashboardData.tLiquidFragile.toString()}",
                                                    style: kTextStyle.copyWith(
                                                        color: kTitleColor),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'total_packing_amount'.tr,
                                                    style: kTextStyle.copyWith(
                                                        color: kTitleColor),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    "${Get.find<GlobalController>()
                                                        .currency!} ${dashboard.dashboardData.tPackaging.toString()}",
                                                    style: kTextStyle.copyWith(
                                                        color: kTitleColor),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'total_vat_amount'.tr,
                                                    style: kTextStyle.copyWith(
                                                        color: kTitleColor),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    '${Get.find<GlobalController>()
                                                        .currency!} ${dashboard.dashboardData.tVatAmount.toString()}',
                                                    style: kTextStyle.copyWith(
                                                        color: kTitleColor),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'total_delivery_charge'.tr,
                                                    style: kTextStyle.copyWith(
                                                        color: kTitleColor),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    '${Get.find<GlobalController>()
                                                        .currency!} ${dashboard.dashboardData.tDeliveryCharge.toString()}',
                                                    style: kTextStyle.copyWith(
                                                        color: kTitleColor),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'total_cod_amount'.tr,
                                                    style: kTextStyle.copyWith(
                                                        color: kTitleColor),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    '${Get.find<GlobalController>()
                                                        .currency!} ${dashboard.dashboardData.tCodAmount.toString()}',
                                                    style: kTextStyle.copyWith(
                                                        color: kTitleColor),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: kGreyTextColor.withOpacity(0.2),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'total_delivery_amount'.tr,
                                                    style: kTextStyle.copyWith(
                                                        color: kTitleColor),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    '${Get.find<GlobalController>()
                                                        .currency!} ${dashboard.dashboardData.tDeliveryAmount.toString()}',
                                                    style: kTextStyle.copyWith(
                                                        color: kTitleColor),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'total_current_payable_amount'.tr,
                                                    style: kTextStyle.copyWith(
                                                        color: kTitleColor),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    '${Get.find<GlobalController>()
                                                        .currency!} ${dashboard.dashboardData.tCurrentPayable.toString()}',
                                                    style: kTextStyle.copyWith(
                                                        color: kTitleColor),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'all_reports'.tr,
                                  style: kTextStyle.copyWith(
                                      color: kGreyTextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: const Icon(
                                        FontAwesomeIcons.handHoldingDollar,
                                        color: kTitleColor,
                                      ),
                                      trailing: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'total_sales_amount'.tr,
                                            style: kTextStyle.copyWith(color: kTitleColor),
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            '${Get.find<GlobalController>()
                                                .currency!} ${dashboard.dashboardData.tSale.toString()}',
                                            style: kTextStyle.copyWith(
                                                color: kTitleColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: const Icon(
                                        FontAwesomeIcons.handshakeAngle,
                                        color: kTitleColor,
                                      ),
                                      trailing: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'total_delivery_fees_paid'.tr,
                                            style: kTextStyle.copyWith(color: kTitleColor),
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            '${Get.find<GlobalController>()
                                                .currency!} ${dashboard.dashboardData.tDeliveryFee.toString()}',
                                            style: kTextStyle.copyWith(
                                                color: kTitleColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: const Icon(
                                        FontAwesomeIcons.coins,
                                        color: kTitleColor,
                                      ),
                                      trailing: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'net_profit_amount'.tr,
                                            style: kTextStyle.copyWith(color: kTitleColor),
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            "${Get.find<GlobalController>()
                                                .currency!} ${double.parse(dashboard.dashboardData.tSale.toString()) - double.parse(dashboard.dashboardData.tDeliveryFee.toString())}",
                                            style: kTextStyle.copyWith(
                                                color: kTitleColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: const Icon(
                                        FontAwesomeIcons.creditCard,
                                        color: kTitleColor,
                                      ),
                                      trailing: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'current_balance'.tr,
                                            style: kTextStyle.copyWith(color: kTitleColor),
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            '${Get.find<GlobalController>()
                                                .currency!} ${dashboard.dashboardData.merchant!.currentBalance.toString()}',
                                            style: kTextStyle.copyWith(
                                                color: kTitleColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: const Icon(
                                        FontAwesomeIcons.circleDollarToSlot,
                                        color: kTitleColor,
                                      ),
                                      trailing: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'opening_balance'.tr,
                                            style: kTextStyle.copyWith(color: kTitleColor),
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            '${Get.find<GlobalController>()
                                                .currency!} ${dashboard.dashboardData.merchant!.openingBalance.toString()}',
                                            style: kTextStyle.copyWith(
                                                color: kTitleColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: const Icon(
                                        FontAwesomeIcons.dna,
                                        color: kTitleColor,
                                      ),
                                      trailing: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'vat'.tr,
                                            style: kTextStyle.copyWith(color: kTitleColor),
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            '${Get.find<GlobalController>()
                                                .currency!} ${dashboard.dashboardData.merchant!.vat.toString()}',
                                            style: kTextStyle.copyWith(
                                                color: kTitleColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: const Icon(
                                        FontAwesomeIcons.hourglass,
                                        color: kTitleColor,
                                      ),
                                      trailing: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'payment_processing'.tr,
                                            style: kTextStyle.copyWith(color: kTitleColor),
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            '${Get.find<GlobalController>()
                                                .currency!} ${dashboard.dashboardData.tBalanceProc.toString()}',
                                            style: kTextStyle.copyWith(
                                                color: kTitleColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: const Icon(
                                        FontAwesomeIcons.database,
                                        color: kTitleColor,
                                      ),
                                      trailing: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'paid_amount'.tr,
                                            style: kTextStyle.copyWith(color: kTitleColor),
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            '${Get.find<GlobalController>()
                                                .currency!} ${dashboard.dashboardData.tBalancePaid.toString()}',
                                            style: kTextStyle.copyWith(
                                                color: kTitleColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: const Icon(
                                        FontAwesomeIcons.houseChimney,
                                        color: kTitleColor,
                                      ),
                                      trailing: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'total_shop'.tr,
                                            style: kTextStyle.copyWith(color: kTitleColor),
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            '${dashboard.dashboardData.tShop.toString()}',
                                            style: kTextStyle.copyWith(
                                                color: kTitleColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: const Icon(
                                        FontAwesomeIcons.boxesStacked,
                                        color: kTitleColor,
                                      ),
                                      trailing: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'total_parcel_bank_item'.tr,
                                            style: kTextStyle.copyWith(color: kTitleColor),
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            dashboard.dashboardData.tParcelBank.toString(),
                                            style: kTextStyle.copyWith(
                                                color: kTitleColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: const Icon(
                                        FontAwesomeIcons.clockRotateLeft,
                                        color: kTitleColor,
                                      ),
                                      trailing: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'total_payment_request'.tr,
                                            style: kTextStyle.copyWith(color: kTitleColor),
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            dashboard.dashboardData.tRequest.toString(),
                                            style: kTextStyle.copyWith(
                                                color: kTitleColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: const Icon(
                                        FontAwesomeIcons.users,
                                        color: kTitleColor,
                                      ),
                                      trailing: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'total_fraud_customer'.tr,
                                            style: kTextStyle.copyWith(color: kTitleColor),
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            dashboard.dashboardData.tFraud.toString(),
                                            style: kTextStyle.copyWith(
                                                color: kTitleColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            )
                          ],
                        ),
                      ),

                    ],
                  )
              )),
    );
  }
}

class ServiceItem {
  final String title;
  final String subtitle;
  final String iconPath;

  ServiceItem(this.title, this.subtitle, this.iconPath);
}

class ServiceCard extends StatelessWidget {
  final ServiceItem service;

  ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(service.subtitle == 'pickup_request'){
          Get.to(() => CreateParcel());
        }else if(service.subtitle == 'express_delivery'){
          AccTransaction().launch(context);
        }else if(service.subtitle == 'pick_drop'){
          Get.to(() => ShopsPage());
        }else if(service.subtitle == 'parcels'){
          Get.to(() => ParcelPage(height: 0.85,));
        }else if(service.subtitle == 'payments'){
          Get.to(() => InvoiceList());
        }else if(service.subtitle == 'support'){
          Get.to(() => Support());
        }else if(service.subtitle == 'fraud'){
          Get.to(() => Frauds());
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(service.iconPath, width: 48.w, height: 48.h),
            SizedBox(height: 5.h),
            Text(
              service.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
            ),

          ],
        ),
      ),
    );
  }
}
