import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../Controllers/global-controller.dart';
import '../../Widgets/constant.dart';

class _DonutSlice {
  _DonutSlice(
    this.label,
    this.value,
    this.color, {
    this.percent = 0,
    this.isPlaceholder = false,
  });

  final String label;
  final double value;
  final Color color;
  /// Share of total (0–100). Meaningful when total > 0 and not placeholder.
  final double percent;
  final bool isPlaceholder;

  String get percentLabel => '${percent.round()}%';
}

/// Donut chart + legend: COD, delivery charge, packing, liquid fragile.
class DashboardChartsSection extends StatelessWidget {
  const DashboardChartsSection({
    Key? key,
    required this.cod,
    required this.deliveryCharge,
    required this.packing,
    required this.liquidFragile,
  }) : super(key: key);

  final double cod;
  final double deliveryCharge;
  final double packing;
  final double liquidFragile;

  @override
  Widget build(BuildContext context) {
    final raw = <_DonutSlice>[
      _DonutSlice('total_cod_amount'.tr, cod, kMainColor),
      _DonutSlice('total_delivery_charge'.tr, deliveryCharge, kSecondaryColor),
      _DonutSlice('total_packing_amount'.tr, packing, deleveryColor),
      _DonutSlice('total_liquid_fragile_amount'.tr, liquidFragile, yellow),
    ];
    final totalVal = raw.fold<double>(0, (a, b) => a + b.value);

    final slices = raw
        .map(
          (s) => _DonutSlice(
            s.label,
            s.value,
            s.color,
            percent: totalVal > 0 ? (100.0 * s.value / totalVal) : 0,
          ),
        )
        .toList();

    final donutData = totalVal <= 0
        ? <_DonutSlice>[
            _DonutSlice(
              '',
              1,
              kGreyTextColor.withOpacity(0.35),
              percent: 0,
              isPlaceholder: true,
            ),
          ]
        : slices;

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: kMainColor.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'net_profit_trend'.tr,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: kTitleColor,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 150.w,
                height: 150.w,
                child: SfCircularChart(
                  margin: EdgeInsets.zero,
                  legend: const Legend(isVisible: false),
                  series: <CircularSeries<_DonutSlice, String>>[
                    DoughnutSeries<_DonutSlice, String>(
                      innerRadius: '58%',
                      radius: '92%',
                      explode: false,
                      dataSource: donutData,
                      xValueMapper: (_DonutSlice d, _) => d.label,
                      yValueMapper: (_DonutSlice d, _) =>
                          d.isPlaceholder ? 1.0 : d.value,
                      pointColorMapper: (_DonutSlice d, _) => d.color,
                      dataLabelMapper: (_DonutSlice d, _) =>
                          (!d.isPlaceholder && totalVal > 0 && d.value > 0)
                              ? d.percentLabel
                              : '',
                      dataLabelSettings: DataLabelSettings(
                        isVisible: totalVal > 0,
                        labelPosition: ChartDataLabelPosition.outside,
                        textStyle: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w800,
                          color: kTitleColor,
                        ),
                        connectorLineSettings: const ConnectorLineSettings(
                          length: '8%',
                          type: ConnectorType.line,
                          width: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(slices.length, (i) {
                    final s = slices[i];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 6.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 9.w,
                            height: 9.w,
                            margin: EdgeInsets.only(top: 3.h),
                            decoration: BoxDecoration(
                              color: s.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              s.label,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: kTitleColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${Get.find<GlobalController>().currency!} ${s.value.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700,
                                  color: kTitleColor,
                                ),
                              ),
                              if (totalVal > 0)
                                Text(
                                  '(${s.percentLabel})',
                                  style: TextStyle(
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w600,
                                    color: kGreyTextColor,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
