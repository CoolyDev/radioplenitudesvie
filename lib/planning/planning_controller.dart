import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:radioplenitudesvie/provider/radio_provider.dart'; 
import 'package:syncfusion_flutter_calendar/calendar.dart';

class PlanningController extends GetxController {
  List<Color> _colorCollection = <Color>[];

  @override
  void onInit() async {
    initCalendar();
 _initializeEventColor();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void _initializeEventColor() {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }

  initCalendar() async {
    await RadioProvider.getPlanningData().then((eventPlanning) {
      final Random random = new Random();
        var eventPlanningList = <Appointment>[].obs;
      for (var event in eventPlanning) {
        Appointment meetingData = Appointment(
            subject: event['subject'],
            startTime: _convertDateFromString(event['starttime']),
            endTime: _convertDateFromString(event['endtime']),
            color: _colorCollection[random.nextInt(9)]);
            //recurrenceRule: event['recurrenceRule']);
        eventPlanningList.add(meetingData);
      }
      return  eventPlanningList;
    });
  }

  DateTime _convertDateFromString(String date) {
    return DateTime.parse(date);
  }
}
