import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '/Controllers/balance_controller.dart';
import '/Screen/Parcel/clearable_parcel.dart';
import '/Screen/Payment/PaymentRequest/create_payment_request.dart';
import '../Widgets/constant.dart';

class BalanceDetails extends StatelessWidget {
  BalanceDetails({Key? key}) : super(key: key);

  final BalanceController balanceController =
  Get.put(BalanceController()); // ✅ single instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        title: Text(
          'Balance Details'.tr,
          style: kTextStyle.copyWith(
            color: kBgColor,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        backgroundColor: kMainColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: kBgColor),
      ),

      // ✅ Body
      body: GetBuilder<BalanceController>(
        builder: (controller) {
          final double balance =
              controller.balanceDetails.currentBalance ?? 0.0;

          final bool isEnabled = balance > 0;
          if (controller.loader) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: controller.getBalanceDetails,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    /// 🔹 Wallet Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kMainColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'My Wallet',
                            style: TextStyle(color: white, fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "৳${controller.balanceDetails.currentBalance?.toStringAsFixed(2) ?? '0.00'}",
                            style: const TextStyle(
                              color: white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'You can request payment for this amount',
                            style: TextStyle(color: white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// 🔹 Summary
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Balance Summary',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 10),

                          _row(
                            "Amount Delivered",
                            controller.balanceDetails.amountDelivered,
                          ),
                          _row(
                            "Payable Delivery Charge",
                            controller.balanceDetails.payableDeliveryCharge,
                          ),
                          _row(
                            "Sub Total",
                            controller.balanceDetails.subTotal,
                          ),
                          _row(
                            "COD Charge",
                            controller.balanceDetails.codCharge,
                          ),

                          const SizedBox(height: 10),
                          const Divider(),

                          _row(
                            "Total",
                            controller.balanceDetails.availableBalance,
                            bold: true,
                          ),

                          const SizedBox(height: 12),

                          /// 🔹 Clearable Consignments
                          InkWell(
                            onTap: () {
                              ClearableParcels().launch(context);
                            },
                            child: DottedBorder(
                              color: const Color(0xFF4DB6AC),
                              strokeWidth: 1.2,
                              dashPattern: const [6, 4],
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              child: Container(
                                width: double.infinity,
                                padding:
                                const EdgeInsets.symmetric(vertical: 12),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE0F2F1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Clearable Consignments: ${controller.balanceDetails.clearableParcels ?? 0}',
                                  style: const TextStyle(
                                    color: Color(0xFF009688),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    // Container(
                    //   height: 60,
                    //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    //   decoration: const BoxDecoration(color: white),
                    //   child: GestureDetector(

                    //       onTap: isEnabled
                    //           ? ()  async {
                    //         await CreatePaymentRequest(
                    //           balanceDetails: balanceController.balanceDetails,
                    //         ).launch(context);

                    //         // 🔁 refresh after payment request
                    //         balanceController.getBalanceDetails();
                    //       }
                    //           : () {
                    //         Get.snackbar(
                    //           'Insufficient Balance',
                    //           'You need a positive balance to request payment',
                    //         );
                    //       },

                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //         color: isEnabled
                    //             ? kMainColor            // ✅ ENABLED color
                    //             : gray.withOpacity(0.6), // ❌ DISABLED color
                    //         borderRadius: BorderRadius.circular(6),
                    //       ),
                    //       // decoration: BoxDecoration(
                    //       //   color: gray.withOpacity(0.6),
                    //       //   borderRadius: BorderRadius.circular(4),
                    //       // ),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Icon(
                    //             isEnabled ? Icons.payment : Icons.lock,
                    //             color: white.withOpacity(isEnabled ? 1 : 0.6),
                    //             size: 18,
                    //           ),
                    //           const SizedBox(width: 6),
                    //           Text('Payment Request', style: TextStyle(color: white))
                    //         ],
                    //       ),

                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 🔹 Reusable Row Widget
  Widget _row(String title, double? value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: grayColor)),
          Text(
            "৳${value?.toStringAsFixed(2) ?? '0.00'}",
            style: TextStyle(
              fontWeight: bold ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
