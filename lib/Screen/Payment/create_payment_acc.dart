import '/Controllers/payment_account_controller.dart';
import '/Screen/Widgets/button_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../Widgets/constant.dart';

class CreateAcc extends StatefulWidget {
  const CreateAcc({Key? key}) : super(key: key);

  @override
  State<CreateAcc> createState() => _CreateAccState();
}

class _CreateAccState extends State<CreateAcc> {

  PaymentAccountController paymentAccountController = PaymentAccountController();
  final _bankFormKey = GlobalKey<FormState>();
  final _cashFormKey = GlobalKey<FormState>();
  final _mobileFormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      appBar: AppBar(
        title: Text(
          'create_payment_accounts'.tr,
          style: kTextStyle.copyWith(color: kBgColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: const Icon(
              FeatherIcons.x,
              color: kBgColor,
            ).onTap(
                  () => Navigator.pop(context),
            ),
          ),
        ],
        backgroundColor: kMainColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: kBgColor),
      ),
      body: GetBuilder<PaymentAccountController>(
          init: PaymentAccountController(),
          builder: (account) {
            return account.loader ? Center(child: CircularProgressIndicator(),): SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30.0),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.all(10.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20.0),
                        InputDecorator(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10.0),
                            labelText: 'payment_method'.tr,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2.0, color: kGreyTextColor.withOpacity(0.15))),
                          ),
                          child: ListTile(
                            title: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                // isExpanded: true,
                                // menuMaxHeight: ScreenSize(context).mainHeight / 3,
                                  items: account.dropdownPaymentMethodItem,
                                  value: account.paymentMethod.value,
                                  onChanged: (String? newValue) {
                                    account.paymentMethod.value = newValue!;
                                    (context as Element).markNeedsBuild();
                                  }),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        if(account.paymentMethod.value == 'bank')
                          bankCreate(account),
                        if(account.paymentMethod.value == 'cash')
                          cashCreate(),
                        if(account.paymentMethod.value == 'mobile')
                          mobileCreate(account),
                        const SizedBox(height: 30),
                        ButtonGlobal(
                            buttontext: 'create'.tr,
                            buttonDecoration: kButtonDecoration,
                            onPressed: () {
                              if(account.paymentMethod.value == 'cash' && _cashFormKey.currentState!.validate()) {
                                account.paymentAccountPost(account.paymentMethod.value, account.selectBank.value,account.holderNameController.text,account.accountNumberController.text,account.branchNameController.text,account.routingNumberController.text,account.mobileController.text);
                              }else if(account.paymentMethod.value == 'bank' && _bankFormKey.currentState!.validate()) {
                                account.paymentAccountPost(account.paymentMethod.value, account.selectBank.value,account.holderNameController.text,account.accountNumberController.text,account.branchNameController.text,account.routingNumberController.text,account.mobileController.text);
                              }else if(account.paymentMethod.value == 'mobile' && _mobileFormKey.currentState!.validate()) {
                                account.paymentAccountPost(account.paymentMethod.value, account.selectMobileBank.value,account.holderNameController.text,account.accountNumberController.text,account.branchNameController.text,account.routingNumberController.text,account.mobileController.text);
                              }
                            })
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }

  bankCreate(PaymentAccountController paymentAccount){
    return Form(
        key: _bankFormKey,
        child: Column(
          children: [

            InputDecorator(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 10.0),
                labelText: 'select_bank'.tr + '*',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2.0, color: kGreyTextColor.withOpacity(0.15))),
              ),
              child: ListTile(
                title: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    // isExpanded: true,
                    // menuMaxHeight: ScreenSize(context).mainHeight / 3,
                      items: paymentAccount.dropdownBankItem,
                      value: paymentAccount.selectBank.value,
                      onChanged: (String? newValue) {
                        paymentAccount.selectBank.value = newValue!;
                        (context as Element).markNeedsBuild();
                      }),
                ),
              ),
            ),
            const SizedBox(height: 20),
            AppTextField(
              showCursor: true,
              cursorColor: kTitleColor,
              validator: (value) {
                if (paymentAccount.holderNameController.text.isEmpty) {
                  return "this_field_can_t_be_empty".tr;
                }
                return null;
              },
              controller: paymentAccount.holderNameController,
              textFieldType: TextFieldType.NAME,
              decoration: kInputDecoration.copyWith(
                labelText: 'holder_name'.tr + '*',
                labelStyle: kTextStyle.copyWith(color: kTitleColor),
                hintText: 'enter_holder_name'.tr,
                hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
              ),
            ),
            const SizedBox(height: 20),
            AppTextField(
              showCursor: true,
              controller: paymentAccount.accountNumberController,
              validator: (value) {
                if (paymentAccount.accountNumberController.text.isEmpty) {
                  return "this_field_can_t_be_empty".tr;
                }
                return null;
              },
              cursorColor: kTitleColor,
              textFieldType: TextFieldType.PHONE,
              decoration: kInputDecoration.copyWith(
                labelText: 'account_number'.tr + '*',
                labelStyle: kTextStyle.copyWith(color: kTitleColor),
                hintText: 'enter_acc_no'.tr,
                hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
              ),
            ),
            const SizedBox(height: 20),
            AppTextField(
              showCursor: true,
              controller: paymentAccount.branchNameController,
              validator: (value) {
                if (paymentAccount.branchNameController.text.isEmpty) {
                  return "this_field_can_t_be_empty".tr;
                }
                return null;
              },
              cursorColor: kTitleColor,
              textFieldType: TextFieldType.NAME,
              decoration: kInputDecoration.copyWith(
                labelText: 'branch_name'.tr + '*',
                labelStyle: kTextStyle.copyWith(color: kTitleColor),
                hintText: 'enter_branch_name'.tr,
                hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
              ),
            ),
            const SizedBox(height: 20),
            AppTextField(
              showCursor: true,
              controller: paymentAccount.routingNumberController,
              validator: (value) {
                if (paymentAccount.routingNumberController.text.isEmpty) {
                  return "this_field_can_t_be_empty".tr;
                }
                return null;
              },
              cursorColor: kTitleColor,
              textFieldType: TextFieldType.PHONE,
              decoration: kInputDecoration.copyWith(
                labelText: 'routing_no'.tr + '*',
                labelStyle: kTextStyle.copyWith(color: kTitleColor),
                hintText: 'enter_routing_no'.tr,
                hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
              ),
            ),

          ],
        ));
  }

  mobileCreate(PaymentAccountController paymentAccount){
    return Form(
        key: _mobileFormKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            InputDecorator(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 10.0),
                labelText: 'select_bank'.tr + '*',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2.0, color: kGreyTextColor.withOpacity(0.15))),
              ),
              child: ListTile(
                title: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    // isExpanded: true,
                    // menuMaxHeight: ScreenSize(context).mainHeight / 3,
                      items: paymentAccount.dropdownMobileBankItem,
                      value: paymentAccount.selectMobileBank.value,
                      onChanged: (String? newValue) {
                        paymentAccount.selectMobileBank.value = newValue!;
                        (context as Element).markNeedsBuild();
                      }),
                ),
              ),
            ),

            const SizedBox(height: 20),
            AppTextField(
              showCursor: true,
              cursorColor: kTitleColor,
              validator: (value) {
                if (paymentAccount.holderNameController.text.isEmpty) {
                  return "this_field_can_t_be_empty".tr;
                }
                return null;
              },
              controller: paymentAccount.holderNameController,
              textFieldType: TextFieldType.NAME,
              decoration: kInputDecoration.copyWith(
                labelText: 'holder_name'.tr + '*',
                labelStyle: kTextStyle.copyWith(color: kTitleColor),
                hintText: 'enter_holder_name'.tr,
                hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
              ),
            ),
            const SizedBox(height: 20),
            AppTextField(
              showCursor: true,
              controller: paymentAccount.mobileController,
              validator: (value) {
                if (paymentAccount.mobileController.text.isEmpty) {
                  return "this_field_can_t_be_empty".tr;
                }
                return null;
              },
              cursorColor: kTitleColor,
              textFieldType: TextFieldType.PHONE,
              decoration: kInputDecoration.copyWith(
                labelText: 'account_number'.tr + '*',
                labelStyle: kTextStyle.copyWith(color: kTitleColor),
                hintText: 'enter_acc_no'.tr,
                hintStyle: kTextStyle.copyWith(color: kGreyTextColor),
              ),
            ),
            const SizedBox(height: 20.0),
            InputDecorator(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10.0),
                labelText: 'Account Type'.tr,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2.0, color: kGreyTextColor.withOpacity(0.15))),
              ),
              child: ListTile(
                title: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    // isExpanded: true,
                    // menuMaxHeight: ScreenSize(context).mainHeight / 3,
                      items: paymentAccount.dropdownAccountTypeItem,
                      value: paymentAccount.accountType.value,
                      onChanged: (String? newValue) {
                        paymentAccount.accountType.value = newValue!;
                        (context as Element).markNeedsBuild();
                      }),
                ),
              ),
            ),
          ],
        ));
  }

  cashCreate(){
    return Form(
        key: _cashFormKey,
        child: Column(
          children: [],
        ));
  }
}
