import 'dart:convert';
import 'dart:math';

import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;
class RadioProvider {
  static  Future<List<dynamic>> getPlanningData() async {
    var data =
        await http.get(Uri.parse("http://192.168.100.45:8080/event/all"));
    var jsonData = json.decode(data.body);
    // final List<Appointment> appointmentData = [];
    // final Random random = new Random();
    // for (var data in jsonData) {
       
    //   Appointment meetingData = Appointment(
    //       subject: data['subject'],
    //       startTime: _convertDateFromString(data['starttime']),
    //       endTime: _convertDateFromString(data['endtime']),
    //       color: _colorCollection[random.nextInt(9)],
    //       recurrenceRule: data['recurrenceRule']);
    //   appointmentData.add(meetingData);
 
    // }
    return jsonData;
  }
static DateTime _convertDateFromString(String date) {
    return DateTime.parse(date);
  }
}