import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radioplenitudesvie/home/home_page.dart';
import 'package:radioplenitudesvie/planning/planning_page.dart'; 
import 'dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
 Future<void>? _launched;
  final String _phone = '+212649019118';

  DashboardPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              //_launched = _makePhoneCall('tel:$_phone');
            },
            child: const Icon(Icons.call),
            backgroundColor: Colors.red,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                HomePage(),
                PlanningPage(),
                //           RecorderHomeView(
                //   title: 'Flutter Voice',
                // ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.redAccent,
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            items: [
              _bottomNavigationBarItem(
                icon: CupertinoIcons.dot_radiowaves_left_right,
                label: 'Radio',
              ),
              _bottomNavigationBarItem(
                icon: Icons.calendar_today,
                label: 'Planning',
              ),
              //  _bottomNavigationBarItem(
              //   icon: Icons.mic,
              //   label: 'Enregistrement',
              // ),
            ],
          ),
        );
      },
    );
  }
//  Future<void> _makePhoneCall(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

  _bottomNavigationBarItem({required IconData icon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
