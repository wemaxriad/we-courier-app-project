import 'dart:convert';
import '../Models/dashboard_model.dart';
import '../Models/news_offers_model.dart';
import '/services/api-list.dart';
import '/services/server.dart';
import '/services/user-service.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  UserService userService = UserService();
  Server server = Server();

  String? userID;

  bool dashboardLoader = true;
  bool commonLoader = false;
  bool loader = false;
  DataDashboard dashboardData = DataDashboard();
  List<NewsOffers> offersList = <NewsOffers>[];


  @override
  void onInit() {
    getDashboard();
    getOfferList();
    super.onInit();
  }

  void getDashboard() {
    _loadDashboardData();
  }

  void getOfferList() {
    _loadOffersData();
  }

  /// Pull-to-refresh: waits for dashboard + offers so the indicator dismisses correctly.
  Future<void> refreshDashboard() async {
    await Future.wait([
      _loadDashboardData(),
      _loadOffersData(),
    ]);
  }

  Future<void> _loadDashboardData() async {
    final response = await server.getRequest(endPoint: APIList.dashboard);
    if (response != null && response.statusCode == 200) {
      dashboardLoader = false;
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      var dashboard = DashboardModel.fromJson(jsonResponse);
      dashboardData = dashboard.data!;
    } else {
      dashboardLoader = false;
    }
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
  }

  Future<void> _loadOffersData() async {
    offersList = <NewsOffers>[];
    final response = await server.getRequest(endPoint: APIList.offerList);
    if (response != null && response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      var offers = NewsOffersModel.fromJson(jsonResponse);
      offersList = offers.data!.newsOffers!;
    } else {
      dashboardLoader = false;
    }
    Future.delayed(const Duration(milliseconds: 10), () {
      update();
    });
  }
}
