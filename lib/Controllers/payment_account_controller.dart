import 'dart:convert';
import 'package:flutter/material.dart';
import '../Models/payment_account_list_model.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import '/services/user-service.dart';
import 'package:get/get.dart';

class PaymentAccountController extends GetxController {
  UserService userService = UserService();
  Server server = Server();
  bool loader = true;
  TextEditingController bankNameController = TextEditingController();
  TextEditingController holderNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController branchNameController = TextEditingController();
  TextEditingController routingNumberController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  List<Accounts> accountList = <Accounts>[];
  List<BankData> bankList = <BankData>[];
  List<BankData> mobileBankList = <BankData>[];
  List<Accounts> accountData = <Accounts>[];
  List<String> methodsList = <String>[];
  List<DropdownMenuItem<String>> dropdownAccountTypeItem = <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> dropdownPaymentMethodItem = <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> dropdownBankItem = <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> dropdownMobileBankItem = <DropdownMenuItem<String>>[];
  RxString paymentMethod = '0'.obs;
  RxString accountType = 'Personal'.obs;
  RxString selectBank = '0'.obs;
  RxString selectMobileBank = '0'.obs;

  @override
  void onInit() {
    getPaymentAccount();
    getPaymentMethod();
    getAccountTypeDropDown();
    super.onInit();
  }

  getPaymentAccountList() async {
    loader = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    getPaymentAccount();
  }

  getPaymentAccount() {
    paymentMethod.value = '0';
    accountType.value = 'Personal';
    selectBank.value = '0';
    selectMobileBank.value = '0';
    holderNameController.text = '';
    accountNumberController.text = '';
    branchNameController.text = '';
    routingNumberController.text = '';
    mobileController.text = '';

    server.getRequest(endPoint: APIList.paymentAccountList).then((response) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (response != null && response.statusCode == 200) {
        loader = false;

        var accountData = PaymentAccountListModel.fromJson(jsonResponse);
        accountList = <Accounts>[];
        bankList = <BankData>[];
        mobileBankList = <BankData>[];
        methodsList = <String>[];
        if(accountData.data!.banks !='' && accountData.data!.banks !=null){
          bankList.addAll(accountData.data!.banks!.data!);

        }
        if(accountData.data!.banks !='' && accountData.data!.banks !=null){
          mobileBankList.addAll(accountData.data!.mobileBanks!.data!);

        }
        if(accountData.data!.methods !='' && accountData.data!.methods !=null){
          methodsList.addAll(accountData.data!.methods!);
        }
        if(accountData.data!.accounts !='' && accountData.data!.accounts !=null){
          accountList.addAll(accountData.data!.accounts!);
        }


        getBanks();
        getMobileBanks();
        getPaymentMethod();
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        loader = false;
        accountData = <Accounts>[];
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      }
    });
  }

  getPaymentMethod() {
    dropdownPaymentMethodItem = [];
    dropdownPaymentMethodItem.add(
      DropdownMenuItem(
        child: Text(
          'select_payment_method'.tr,
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        value: '0',
      ),
    );
    if(methodsList.isNotEmpty) {
      for (var methods in methodsList) {
        print('methods=================================');
        print(methods);
        dropdownPaymentMethodItem.add(
          DropdownMenuItem(
            child: Text(
              methods.toUpperCase(),
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            value: methods.toString(),
          ),
        );
      }
    }
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });

  }
  getAccountTypeDropDown() {
    dropdownAccountTypeItem = [];
    dropdownAccountTypeItem.add(
      DropdownMenuItem(
        child: Text(
          'Personal'.tr,
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        value: 'Personal',
      ),
    );
    dropdownAccountTypeItem.add(
      DropdownMenuItem(
        child: Text(
          'Merchant'.tr,
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        value: 'Merchant',
      ),
    );

    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });

  }
  getBanks() {
    dropdownBankItem = [];
    dropdownBankItem.add(
      DropdownMenuItem(
        child: Text(
          'select_bank'.tr,
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        value: '0',
      ),
    );
    if(bankList.isNotEmpty) {
      for (var banks in bankList) {
        print(banks);
        dropdownBankItem.add(
          DropdownMenuItem(
            child: Text(
              banks.name.toString(),
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            value: banks.id.toString(),
          ),
        );
      }
    }

    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });

  }

  getMobileBanks() {
    dropdownMobileBankItem = [];
    dropdownMobileBankItem.add(
      DropdownMenuItem(
        child: Text(
          'select_bank'.tr,
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        value: '0',
      ),
    );
    if(mobileBankList.isNotEmpty) {
      for (var banks in mobileBankList) {
        print(banks);
        dropdownMobileBankItem.add(
          DropdownMenuItem(
            child: Text(
              banks.name.toString(),
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            value: banks.id.toString(),
          ),
        );
      }
    }

    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });

  }



  paymentAccountPost(String method,bankName,holderName,accountNumber,branchName,routingNumber,mobile) {
    loader = true;
    Future.delayed(Duration(milliseconds: 10), () {
      update();
    });
    Map body = {
      'bank_name': selectBank.value,
      'holder_name': holderName,
      'account_no': accountNumber,
      'branch_name': branchName,
      'routing_no': routingNumber,
      'status': "1",
      'account_type': accountType.value,
      'mobile_holder_name': holderName,
      'mobile_no': mobile,
      'mobile_company': selectMobileBank.value,
      'payment_method': method.toLowerCase(),
    };
    String jsonBody = json.encode(body);
    print(jsonBody);
    server
        .postRequestWithToken(endPoint: APIList.paymentAccountAdd, body: jsonBody)
        .then((response) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
        getPaymentAccountList();
        Get.back();
        Get.rawSnackbar(
            message: "${jsonResponse['message']}",
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP);
      } else if (response != null && response.statusCode == 422) {
        if (jsonResponse['data']['message']['name'] != null) {
          Get.rawSnackbar(snackPosition:SnackPosition.TOP,message: jsonResponse['data']['message']['name'].toString());
        } else if (jsonResponse['data']['message']['mobile_no'] != null) {
          Get.rawSnackbar(snackPosition:SnackPosition.TOP,message: jsonResponse['data']['message']['mobile_no'].toString());
        } else if (jsonResponse['data']['message']['details'] != null) {
          Get.rawSnackbar(snackPosition:SnackPosition.TOP,message: jsonResponse['data']['message']['details'].toString());
        }
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
      } else {
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
        Get.rawSnackbar(snackPosition:SnackPosition.TOP,message: 'Please enter valid input');
      }
    });
  }


  paymentAccountDelete(id) {
    server
        .deleteRequest(endPoint: APIList.supportRemoveUrl!+id.toString())
        .then((response) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
        getPaymentAccountList();
        Get.back();
        Get.rawSnackbar(
            message: "${jsonResponse['message']}",
            backgroundColor: Colors.green,
            snackPosition: SnackPosition.TOP);
      } else {
        loader = false;
        Future.delayed(Duration(milliseconds: 10), () {
          update();
        });
        Get.rawSnackbar(message: 'Please enter valid input');
      }
    });
  }
}
