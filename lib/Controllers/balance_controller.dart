import 'dart:convert';
import 'package:get/get.dart';

import '/Models/balance_detials_model.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import '/services/user-service.dart';

class BalanceController extends GetxController {
  UserService userService = UserService();
  Server server = Server();

  bool loader = true;
  BalanceDetailsModel balanceDetails = BalanceDetailsModel();
  bool isLoading = false;
  @override
  void onInit() {
    super.onInit();
    getBalanceDetails();
  }

  Future<void> getBalanceDetails() async {
    loader = true;
    update();

    final response =
    await server.getRequest(endPoint: APIList.balanceDetails);

    if (response != null && response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      balanceDetails = BalanceDetailsModel.fromJson(jsonResponse);
    }

    loader = false;
    update();
  }

  Future<bool> getBalanceDetailsMenu() async {
    try {
      isLoading = true;
      update();

      final response =
      await server.getRequest(endPoint: APIList.balanceDetails);

      if (response != null && response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        balanceDetails = BalanceDetailsModel.fromJson(jsonResponse);
        isLoading = false;
        update();
        return true; // ✅ success
      }
    } catch (e) {

    }

    isLoading = false;
    update();
    return false; // ❌ failed
  }
}
