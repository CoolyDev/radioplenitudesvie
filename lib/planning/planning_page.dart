import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart'; 
import 'package:radioplenitudesvie/model/mettingdatasource.dart'; 
import 'package:syncfusion_flutter_calendar/calendar.dart'; 
import 'package:http/http.dart' as http;
class PlanningPage extends StatefulWidget {
  @override
  PlanningPageState createState() => PlanningPageState();
}
class PlanningPageState extends State<PlanningPage> {
  @override
  void initState() {
    super.initState();
    _initializeEventColor();
  }
  
  List<Color> _colorCollection = <Color>[];
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
     Future<List<Appointment>> getPlanningData() async {
       final List<Appointment> appointmentData = [];
    final Random random = new Random();
     var data =
        await http.get(Uri.parse("https://api.npoint.io/b0ec90b759d66566d222"));
    var jsonData = json.decode(data.body);
    for (var data in jsonData) {
      
      Appointment meetingData = Appointment(
          subject: data['subject'],
          startTime: _convertDateFromString(data['starttime']),
          endTime: _convertDateFromString(data['endtime']),
          color: _colorCollection[random.nextInt(9)],
          recurrenceRule: data['recurrenceRule']);
      appointmentData.add(meetingData);
    }
    return appointmentData;
    }
  @override
  Widget build(BuildContext context) {
    return (
          Scaffold(
            appBar: AppBar(
        title: Text("Planning Hebdomadaire"),
        backgroundColor: Color(0xFF211414),
      ),
            resizeToAvoidBottomInset: false,
            body: 
            Container(
              padding: EdgeInsets.only(right: 10),
              child: FutureBuilder(
                future: getPlanningData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data != null) {
                    return SafeArea(
                        child: Container(
                      child: SfCalendar(
                        view: CalendarView.schedule,
                          appointmentTimeTextFormat: 'HH:mm',
                        scheduleViewSettings: ScheduleViewSettings(
                          appointmentItemHeight: 70,
                          hideEmptyScheduleWeek: false,
                        ), 
                        dataSource: MeetingDataSource(snapshot.data),
                        initialDisplayDate:DateTime.now().toLocal(),
                      ),
                    ));
                  } else {
                    return Container(
                      child: Center(
                        child: Text('Chargement en cours.....'),
                      ),
                    );
                  }
                },
              ),
            )));
            // Container(
            //   padding: EdgeInsets.only(right: 10),
            //   child: FutureBuilder(
            //     future: getPlanningData(),
            //     builder: (BuildContext context, AsyncSnapshot snapshot) {
 
            //       if (snapshot.data != null) {
            //         return SafeArea(
            //             child: Container(
            //           child: SfCalendar(
            //             view: CalendarView.schedule,
            //             timeZone: 'Morocco Standard Time',
            //             scheduleViewSettings: ScheduleViewSettings(
            //               appointmentItemHeight: 70,
            //               hideEmptyScheduleWeek: false,
            //             ),
            //             timeSlotViewSettings: TimeSlotViewSettings(
            //                 timeFormat: 'HH:mma:ff',
            //                 dateFormat: 'd',
            //                 dayFormat: 'EEE',
            //                 timeRulerSize: 70,
            //                 timeInterval: Duration(minutes: 120),
            //                 startHour: 0,
            //                 endHour: 24),
            //             dataSource: MeetingDataSource(snapshot.data),
            //             initialDisplayDate: snapshot.data[0].startTime,
            //           ),
            //         ));
            //       } else {
            //         return Container(
            //           child: Center(
            //             child: Text('Chargement en cours.....'),
            //           ),
            //         );
            //       }
            //     },
            //   ),
            // ))
}}
 

  DateTime _convertDateFromString(String date) {
    return DateTime.parse(date);
  }

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }}