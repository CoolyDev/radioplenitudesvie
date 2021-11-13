import 'package:get/get.dart';
import 'package:radioplenitudesvie/home/home_controller.dart';
import 'package:radioplenitudesvie/planning/planning_controller.dart'; 
 

import 'dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<PlanningController>(() => PlanningController());
  }
}
