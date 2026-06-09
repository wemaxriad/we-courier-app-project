import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nb_utils/nb_utils.dart' hide redColor;
import 'package:shimmer/shimmer.dart';

import '../Payment/PaymentRequest/create_payment_request.dart';
import '/Controllers/balance_controller.dart';
import '/Controllers/dashboard_controller.dart';
import '/Screen/Frauds/frauds.dart';
import '/Screen/Parcel/parcel_index.dart';
import '/Screen/Shops/shops.dart';
import '/utils/image.dart';
import '../../Controllers/global-controller.dart';
import '../../Controllers/language_controller.dart';
import '../../Models/dashboard_model.dart';
import '../../Models/language_model.dart';
import '../Parcel/create_parcel.dart';
import '../Payment/PaymentRequest/invoice_list.dart';
import '../Payment/balance_details.dart';
import '../Profile/profile.dart';
import '../Support/support.dart';
import '../Widgets/constant.dart';
import '../Widgets/drawer.dart';
import '../Widgets/shimmer/dashboard_shimmer.dart';
import 'widgets/dashboard_charts_section.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  LanguageController languageController = Get.put(LanguageController());
  DashboardController dashboard = Get.put(DashboardController());
  GlobalController globalController = Get.put(GlobalController());
  BalanceController balanceController = Get.put(BalanceController());

  Language? selectedLang;
  int _carouselPage = 0;

  final List<String> imageList = [
    Images.banner1,
    Images.banner2,
    Images.banner3,
  ];

  @override
  Widget build(BuildContext context) {
    selectedLang = languageController.languageList[languageController.languageList
        .indexWhere((i) => i.locale == Get.locale)];

    return Scaffold(
      backgroundColor: kBgColor,
      drawer: DrawerView(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shadowColor: kMainColor.withOpacity(0.06),
        iconTheme: IconThemeData(color: kTitleColor),
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: Icon(Icons.menu_rounded, color: kTitleColor, size: 24.sp),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        titleSpacing: 8.w,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${Get.find<GlobalController>().siteName}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: kMainColor,
                fontSize: 17.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              '${'welcome'.tr}, ${Get.find<GlobalController>().userName}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: kGreyTextColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          _languageAction(),
          SizedBox(width: 4.w),
          _notificationAction(),
          SizedBox(width: 4.w),
          _profileAction(),
          SizedBox(width: 10.w),
        ],
      ),
      body: GetBuilder<DashboardController>(
        builder: (dashboard) => dashboard.dashboardLoader
            ? DashboardShimmer()
            : RefreshIndicator(
                color: kMainColor,
                backgroundColor: Colors.white,
                displacement: 48,
                onRefresh: () => dashboard.refreshDashboard(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (dashboard.offersList.isNotEmpty) ...[
                        _buildOfferCarousel(dashboard),
                        SizedBox(height: 8.h),
                        _carouselDots(dashboard),
                        SizedBox(height: 16.h),
                      ],
                      _PayoutSummaryCard(d: dashboard.dashboardData),
                      SizedBox(height: 20.h),
                      Text(
                        'quick_actions'.tr,
                        style: TextStyle(
                          color: kTitleColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      _quickActionsGrid(),
                      SizedBox(height: 20.h),

                      Text(
                        'merchant_dashboard'.tr,
                        style: TextStyle(
                          color: kTitleColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      _parcelMetricsGrid(dashboard),
                      SizedBox(height: 16.h),
                      DashboardChartsSection(
                        cod: dashboard.dashboardData.tCodAmount ?? 0,
                        deliveryCharge: dashboard.dashboardData.tDeliveryCharge ?? 0,
                        packing: dashboard.dashboardData.tPackaging ?? 0,
                        liquidFragile: dashboard.dashboardData.tLiquidFragile ?? 0,
                      ),
                      SizedBox(height: 16.h),
                      _financialSixGrid(dashboard),
                      SizedBox(height: 12.h),
                      _cashPaymentGrid(dashboard),
                      SizedBox(height: 12.h),
                      _wideStat(
                        FontAwesomeIcons.boxesStacked,
                        'total_parcel_bank_item'.tr,
                        dashboard.dashboardData.tParcelBank.toString(),
                      ),
                      SizedBox(height: 8.h),
                      _wideStat(
                        FontAwesomeIcons.userSlash,
                        'total_fraud_customer'.tr,
                        dashboard.dashboardData.tFraud.toString(),
                      ),
                      SizedBox(height: 20.h),
                      // Text(
                      //   'quick_actions'.tr,
                      //   style: TextStyle(
                      //     color: kTitleColor,
                      //     fontWeight: FontWeight.w800,
                      //     fontSize: 16.sp,
                      //   ),
                      // ),
                      // SizedBox(height: 12.h),
                      // _quickActionsGrid(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _languageAction() {
    return CircleAvatar(
      radius: 18.r,
      backgroundColor: kAccentLight,
      child: PopupMenuButton<Language>(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(6.r),
          child: Image.asset(
            selectedLang?.langName == 'English'
                ? Images.flagEn
                : selectedLang?.langName == 'Bangla'
                    ? Images.flagBd
                    : selectedLang?.langName == 'Spanish'
                        ? Images.flagEs
                        : Images.flagAr,
            width: 22.w,
            height: 16.h,
            fit: BoxFit.cover,
          ),
        ),
        onSelected: (newValue) {
          setState(() {
            selectedLang = newValue;
            if (newValue.langName == 'English') {
              languageController.changeLanguage('en');
            } else if (newValue.langName == 'Bangla') {
              languageController.changeLanguage('bn');
            } else if (newValue.langName == 'हिन्दी') {
              languageController.changeLanguage('hi');
            } else if (newValue.langName == 'عربي') {
              languageController.changeLanguage('ar');
            } else if (newValue.langName == 'Spanish') {
              languageController.changeLanguage('es');
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
      ),
    );
  }

  Widget _notificationAction() {
    return IconButton(
      onPressed: () {},
      icon: Badge(
        isLabelVisible: true,
        label: Text('0', style: TextStyle(color: textWhiteColor, fontSize: 10.sp)),
        child: CircleAvatar(
          radius: 18.r,
          backgroundColor: kAccentLight,
          child: SvgPicture.asset(
            Images.notification,
            width: 18.w,
            colorFilter: const ColorFilter.mode(kMainColor, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }

  Widget _profileAction() {
    return InkWell(
      onTap: () => Get.to(() => Profile()),
      borderRadius: BorderRadius.circular(40.r),
      child: CircleAvatar(
        radius: 18.r,
        backgroundColor: kAccentLight,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: Get.find<GlobalController>().userImage.toString(),
            width: 36.w,
            height: 36.w,
            fit: BoxFit.cover,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[400]!,
              child: const SizedBox.expand(),
            ),
            errorWidget: (context, url, error) => Image.asset(
              Images.user,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  int _carouselItemCount(DashboardController dashboard) {
    return dashboard.offersList.isNotEmpty ? dashboard.offersList.length : imageList.length;
  }

  Widget _buildOfferCarousel(DashboardController dashboard) {
    const bannerAspect = 16 / 9;
    const viewportFraction = 0.88;
    final slideWidth = (1.sw - 32.w) * viewportFraction;
    final carouselHeight = slideWidth / bannerAspect;
    final count = _carouselItemCount(dashboard);
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: carouselHeight,
        viewportFraction: viewportFraction,
        enlargeCenterPage: true,
        enlargeFactor: 0.12,
        autoPlay: count > 1,
        autoPlayInterval: const Duration(seconds: 4),
        onPageChanged: (index, reason) {
          setState(() => _carouselPage = index);
        },
      ),
      itemCount: count,
      itemBuilder: (context, index, realIndex) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: SizedBox(
            width: slideWidth,
            height: carouselHeight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: dashboard.offersList.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: dashboard.offersList[index].image.toString(),
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[400]!,
                            child: const ColoredBox(color: Colors.white),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            imageList[index % imageList.length],
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        )
                      : Image.asset(
                          imageList[index % imageList.length],
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: 48.h,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.35),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _carouselDots(DashboardController dashboard) {
    final n = _carouselItemCount(dashboard);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        n,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          height: 7.h,
          width: i == _carouselPage ? 18.w : 7.w,
          decoration: BoxDecoration(
            color: i == _carouselPage ? kMainColor : kGreyTextColor.withOpacity(0.28),
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
    );
  }

  Widget _parcelMetricsGrid(DashboardController dashboard) {
    final d = dashboard.dashboardData;

    // Null‑safe ভ্যালু বের করা (ধরে নিচ্ছি সব fields num বা int)
    final tParcel = d.tParcel ?? 0;
    final tDelivered = d.tDelivered ?? 0;
    final tReturn = d.tReturn ?? 0;
    final tShop = d.tShop ?? 0;
    final tRequest = d.tRequest ?? 0;

    final transit = tParcel - (tDelivered + tReturn);

    final items = <_MetricSpec>[
      _MetricSpec('total_parcel'.tr, tParcel.toString(), FontAwesomeIcons.boxOpen, kAccentLight, kMainColor),
      _MetricSpec('total_delivered'.tr, tDelivered.toString(), FontAwesomeIcons.circleCheck, const Color(0xFFE8F8EF), green),
      _MetricSpec('total_return'.tr, tReturn.toString(), FontAwesomeIcons.rotateLeft, const Color(0xFFFDEBE9), redColor),
      _MetricSpec('total_transit'.tr, transit.toString(), MdiIcons.truckFast, const Color(0xFFFFF8E6), const Color(0xFFB8860B)),
      _MetricSpec('total_shop'.tr, tShop.toString(), FontAwesomeIcons.store, kDashboardPurpleTint, kMainColor),
      _MetricSpec('total_payment_request'.tr, tRequest.toString(), FontAwesomeIcons.fileInvoice, itembg, kMainColor),
    ];

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10.h,
      crossAxisSpacing: 10.w,
      childAspectRatio: 0.92,
      children: items.map((e) => _MetricTile(spec: e)).toList(),
    );
  }

  // Widget _parcelMetricsGrid(DashboardController dashboard) {
  //   final d = dashboard.dashboardData;
  //   final transit = d.tParcel! - (d.tDelivered! + d.tReturn!);
  //   final items = <_MetricSpec>[
  //     _MetricSpec('total_parcel'.tr, d.tParcel.toString(), FontAwesomeIcons.boxOpen, kAccentLight, kMainColor),
  //     _MetricSpec('total_delivered'.tr, d.tDelivered.toString(), FontAwesomeIcons.circleCheck, const Color(0xFFE8F8EF), green),
  //     _MetricSpec('total_return'.tr, d.tReturn.toString(), FontAwesomeIcons.rotateLeft, const Color(0xFFFDEBE9), redColor),
  //     _MetricSpec('total_transit'.tr, '$transit', MdiIcons.truckFast, const Color(0xFFFFF8E6), const Color(0xFFB8860B)),
  //     _MetricSpec('total_shop'.tr, d.tShop.toString(), FontAwesomeIcons.store, kDashboardPurpleTint, kMainColor),
  //     _MetricSpec('total_payment_request'.tr, d.tRequest.toString(), FontAwesomeIcons.fileInvoice, itembg, kMainColor),
  //   ];
  //
  //   return GridView.count(
  //     crossAxisCount: 3,
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     mainAxisSpacing: 10.h,
  //     crossAxisSpacing: 10.w,
  //     childAspectRatio: 0.92,
  //     children: items.map((e) => _MetricTile(spec: e)).toList(),
  //   );
  // }
  Widget _financialSixGrid(DashboardController dashboard) {
    final d = dashboard.dashboardData;
    // সেফলি কারেন্সি বের করা (null থাকলে খালি স্ট্রিং অথবা ডিফল্ট)
    final currency = Get.find<GlobalController>().currency ?? '';

    // টাকার পরিমাণগুলো safely parse করা
    final tSale = double.tryParse(d.tSale?.toString() ?? '0') ?? 0;
    final tDeliveryFee = double.tryParse(d.tDeliveryFee?.toString() ?? '0') ?? 0;
    final netProfit = tSale - tDeliveryFee;

    // merchant null হলে ডিফল্ট মান বসানো
    final merchant = d.merchant;
    final currentBalance = merchant?.currentBalance ?? 0;
    final openingBalance = merchant?.openingBalance ?? 0;
    final vat = merchant?.vat ?? 0;

    final items = <_MetricSpec>[
      _MetricSpec('total_sales_amount'.tr, '$currency ${d.tSale ?? 0}', FontAwesomeIcons.chartColumn, kAccentLight, kMainColor),
      _MetricSpec('total_delivery_fees_paid'.tr, '$currency ${d.tDeliveryFee ?? 0}', FontAwesomeIcons.truck, deleveryColor.withOpacity(0.35), kTitleColor),
      _MetricSpec('net_profit_amount'.tr, '$currency ${netProfit.toStringAsFixed(2)}', FontAwesomeIcons.chartLine, const Color(0xFFFCE4EC), kSecondaryColor),
      _MetricSpec('current_balance'.tr, '$currency $currentBalance', FontAwesomeIcons.wallet, const Color(0xFFE8F8EF), green),
      _MetricSpec('opening_balance'.tr, '$currency $openingBalance', FontAwesomeIcons.buildingColumns, const Color(0xFFFFF8E6), const Color(0xFFB8860B)),
      _MetricSpec('vat'.tr, '$currency $vat', FontAwesomeIcons.percent, itembg, kMainColor),
    ];

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10.h,
      crossAxisSpacing: 10.w,
      childAspectRatio: 0.88,
      children: items.map((e) => _MetricTile(spec: e, compactValue: true)).toList(),
    );
  }
  // Widget _financialSixGrid(DashboardController dashboard) {
  //   final d = dashboard.dashboardData;
  //   final c = Get.find<GlobalController>().currency!;
  //   final netProfit =
  //       (double.tryParse(d.tSale.toString()) ?? 0) - (double.tryParse(d.tDeliveryFee.toString()) ?? 0);
  //
  //   final items = <_MetricSpec>[
  //     _MetricSpec('total_sales_amount'.tr, '$c ${d.tSale}', FontAwesomeIcons.chartColumn, kAccentLight, kMainColor),
  //     _MetricSpec('total_delivery_fees_paid'.tr, '$c ${d.tDeliveryFee}', FontAwesomeIcons.truck, deleveryColor.withOpacity(0.35), kTitleColor),
  //     _MetricSpec('net_profit_amount'.tr, '$c ${netProfit.toStringAsFixed(2)}', FontAwesomeIcons.chartLine, const Color(0xFFFCE4EC), kSecondaryColor),
  //     _MetricSpec('current_balance'.tr, '$c ${d.merchant!.currentBalance}', FontAwesomeIcons.wallet, const Color(0xFFE8F8EF), green),
  //     _MetricSpec('opening_balance'.tr, '$c ${d.merchant!.openingBalance}', FontAwesomeIcons.buildingColumns, const Color(0xFFFFF8E6), const Color(0xFFB8860B)),
  //     _MetricSpec('vat'.tr, '$c ${d.merchant!.vat}', FontAwesomeIcons.percent, itembg, kMainColor),
  //   ];
  //
  //   return GridView.count(
  //     crossAxisCount: 3,
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     mainAxisSpacing: 10.h,
  //     crossAxisSpacing: 10.w,
  //     childAspectRatio: 0.88,
  //     children: items.map((e) => _MetricTile(spec: e, compactValue: true)).toList(),
  //   );
  // }

  Widget _cashPaymentGrid(DashboardController dashboard) {
    final d = dashboard.dashboardData;
    final c = Get.find<GlobalController>().currency!;
    final items = <_MetricSpec>[
      _MetricSpec('total_cash_collection'.tr, '$c ${d.tCashCollection}', FontAwesomeIcons.moneyBill1, const Color(0xFFE8F8EF), green),
      _MetricSpec('total_selling_price'.tr, '$c ${d.tSellingPrice}', FontAwesomeIcons.tag, const Color(0xFFFCE4EC), kSecondaryColor),
      _MetricSpec('payment_processing'.tr, '$c ${d.tBalanceProc}', FontAwesomeIcons.creditCard, deleveryColor.withOpacity(0.45), kTitleColor),
      _MetricSpec('paid_amount'.tr, '$c ${d.tBalancePaid}', FontAwesomeIcons.circleCheck, kAccentLight, kMainColor),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10.h,
      crossAxisSpacing: 10.w,
      childAspectRatio: 1.35,
      children: items.map((e) => _MetricTile(spec: e, compactValue: true)).toList(),
    );
  }

  Widget _wideStat(IconData icon, String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: kAccentLine.withOpacity(0.6)),
        boxShadow: [
          BoxShadow(
            color: kMainColor.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: kMainColor, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: kTitleColor,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w800,
              color: kMainColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickActionsGrid() {
    final actions = <ServiceItem>[

      //ServiceItem('parcel_planner'.tr, 'parcel_planner', iconData: FontAwesomeIcons.calendarWeek),
      ServiceItem('pickup_point'.tr, 'pick_drop', iconPath: 'assets/images/pick_drop.png'),
      ServiceItem('create_order'.tr, 'pickup_request', iconPath: 'assets/images/pickup.png'),
      ServiceItem('parcels'.tr, 'parcels', iconPath: 'assets/images/parcel.png'),
      ServiceItem('payments'.tr, 'payments', iconPath: 'assets/images/payment.png'),
      ServiceItem('support'.tr, 'support', iconPath: 'assets/images/support.png'),
      ServiceItem('fraud'.tr, 'fraud', iconPath: 'assets/images/fraud.png'),
      ServiceItem('check_balance'.tr, 'check_balance', iconData: Icons.account_balance_wallet_rounded),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 10.w,
        childAspectRatio: 0.78,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) => ServiceCard(service: actions[index]),
    );
  }
}

class _MetricSpec {
  _MetricSpec(this.label, this.value, this.icon, this.bg, this.iconColor);
  final String label;
  final String value;
  final IconData icon;
  final Color bg;
  final Color iconColor;
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.spec, this.compactValue = false});
  final _MetricSpec spec;
  final bool compactValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: kAccentLine.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: kMainColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: spec.bg,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(spec.icon, size: 18.sp, color: spec.iconColor),
          ),
          const Spacer(),
          Text(
            spec.label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: kGreyTextColor,
              height: 1.2,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            spec.value,
            maxLines: compactValue ? 2 : 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: compactValue ? 11.sp : 13.sp,
              fontWeight: FontWeight.w800,
              color: kTitleColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _PayoutSummaryCard extends StatelessWidget {
  const _PayoutSummaryCard({required this.d});
  final DataDashboard d;

  @override
  Widget build(BuildContext context) {
    final c = Get.find<GlobalController>().currency!;
    final payable = d.tCurrentPayable ?? 0;
    final canRequestPayout = payable > 0;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: kAccentLine.withOpacity(0.7)),
        boxShadow: [
          BoxShadow(
            color: kMainColor.withOpacity(0.07),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 4.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
              gradient: const LinearGradient(
                colors: kPrimaryGradientColors,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 14.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// LEFT SIDE
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        'total_current_payable_amount'.tr,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: kGreyTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(height: 4.h),

                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '$c ${d.tCurrentPayable}',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                            color: kMainColor,
                          ),
                        ),
                      ),

                      SizedBox(height: 10.h),

                      Text(
                        'total_delivery_amount'.tr,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: kGreyTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(height: 2.h),

                      Text(
                        '$c ${d.tDeliveryAmount}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: kTitleColor,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 8.w),

                /// RIGHT SIDE FIXED WIDTH
                SizedBox(
                  width: 130.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      /// TRUCK IMAGE
                      SizedBox(
                        width: 125.w,
                        height: 68.h,
                        child: Image.asset(
                          'assets/images/truck.png',
                          fit: BoxFit.cover,
                        ),
                      ),

                      SizedBox(height: 6.h),

                      /// PAYOUT BUTTON
                      SizedBox(
                        width: 120.w,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: !canRequestPayout ||
                                    Get.find<BalanceController>().loader
                                ? null
                                : () {
                                    CreatePaymentRequest(
                                      balanceDetails: Get.find<BalanceController>()
                                          .balanceDetails,
                                    ).launch(context);
                                  },
                            borderRadius: BorderRadius.circular(30.r),
                            child: Ink(
                              decoration: canRequestPayout
                                  ? BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: kPrimaryGradientColors,
                                      ),
                                      borderRadius: BorderRadius.circular(30.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: kMainColor.withOpacity(0.18),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    )
                                  : BoxDecoration(
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(30.r),
                                    ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10.h,
                                ),
                                child: Center(
                                  child: Text(
                                    'request_payout'.tr,
                                    style: TextStyle(
                                      color: canRequestPayout
                                          ? textWhiteColor
                                          : Colors.white.withOpacity(0.75),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}

class ServiceItem {
  ServiceItem(
    this.title,
    this.subtitle, {
    this.iconPath,
    this.iconData,
  }) : assert(iconPath != null || iconData != null);

  final String title;
  final String subtitle;
  final String? iconPath;
  final IconData? iconData;
}

class ServiceCard extends StatelessWidget {
  const ServiceCard({Key? key, required this.service}) : super(key: key);
  final ServiceItem service;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTap(context),
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: kAccentLine.withOpacity(0.45)),
          boxShadow: [
            BoxShadow(
              color: kMainColor.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (service.iconData != null)
              Icon(service.iconData, size: 26.sp, color: kMainColor)
            else
              Image.asset(service.iconPath!, width: 36.w, height: 36.h),
            SizedBox(height: 6.h),
            Text(
              service.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: kTitleColor,
                height: 1.15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    if (service.subtitle == 'pickup_request') {
      Get.to(() => CreateParcel());
    } else if (service.subtitle == 'express_delivery') {
      // preserved from original; route if used later
    } else if (service.subtitle == 'pick_drop') {
      Get.to(() => ShopsPage());
    } else if (service.subtitle == 'parcels') {
      Get.to(() => ParcelPage(height: 0.85));
    } else if (service.subtitle == 'payments') {
      Get.to(() => InvoiceList());
    } else if (service.subtitle == 'support') {
      Get.to(() => Support());
    } else if (service.subtitle == 'fraud') {
      Get.to(() => Frauds());
    } else if (service.subtitle == 'check_balance') {
      const BalanceDetails().launch(context);
    } else if (service.subtitle == 'parcel_planner') {
      // Routing added later
    }
  }
}
