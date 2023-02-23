import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class DailyScheduleScreen extends StatefulWidget {
  const DailyScheduleScreen({
    Key? key,
  }) : super(key: key);

  @override
  DailyScheduleScreenState createState() => DailyScheduleScreenState();
}

class DailyScheduleScreenState extends State<DailyScheduleScreen> {
  CalendarController? _controller;
  DateTime? selectedDateTime;
  static DateTime kToday = DateTime.now();
  static DateTime kFirstDay =
      DateTime(kToday.year, kToday.month - 1, kToday.day);
  static DateTime kLastDay =
      DateTime(kToday.year, kToday.month + 1, kToday.day);

  static TextStyle calendarDateStyle({Color? color}) {
    return TextStyle(
      color: color ?? Color(0xFF291139),
      fontSize: 18,
    );
  }

  static TextStyle upperMedium_18({Color? color, String? fontFamily}) {
    return TextStyle(
      color: color ?? Colors.black,
      fontSize: 188,
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Routes")),
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              _calendarDetailView(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _calendarDetailView() {
    return SfCalendar(
      timeSlotViewSettings: const TimeSlotViewSettings(
          timeIntervalWidth: 60,
          timeIntervalHeight: 52,
          timeRulerSize: 48,
          startHour: 0,
          endHour: 24),
      view: CalendarView.week,
      headerHeight: 60,
      viewNavigationMode: ViewNavigationMode.snap,
      controller: _controller,
      cellEndPadding: 0,
      headerStyle: const CalendarHeaderStyle(
        textStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      ),
      dataSource: MeetingDataSource(_getDataSource()),
      appointmentBuilder: (context, details) {
        final Meeting meeting = details.appointments.first;
        return ColoredBox(
          color: meeting.background,
          child: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/ic_truck.png",
                  width: 20,
                  height: 12,
                ),
                const SizedBox(height: 2),
                Text(
                  meeting.eventName,
                  style: const TextStyle(
                      fontSize: 6,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 2),
                Text(
                  meeting.note,
                  style: const TextStyle(
                      fontSize: 5,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                  maxLines: 3,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Meeting> _getDataSource() {
    List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime startTime2 =
        DateTime(today.year, today.month, today.day - 1, 11);
    final DateTime startTime3 =
        DateTime(today.year, today.month, today.day - 4, 8);
    final DateTime startTime4 =
    DateTime(today.year, today.month, today.day + 4, 8);
    final DateTime startTime5 =
    DateTime(today.year, today.month, today.day + 6, 8);

    final DateTime endTime = startTime.add(const Duration(hours: 1));
    final DateTime endTime2 = startTime2.add(const Duration(hours: 1));
    final DateTime endTime3 = startTime3.add(const Duration(hours: 1));
    final DateTime endTime4 = startTime4.add(const Duration(hours: 1));
    final DateTime endTime5 = startTime5.add(const Duration(hours: 1));
    meetings = [
      Meeting('Delivery', startTime, endTime, const Color(0xFFD8E4BF), false,
          "New york to Loss Angels"),
      Meeting('Pickup', startTime2, endTime2, const Color(0xFFE4BFBF), false,
          "New york to West Fort"),
      Meeting('Delivery', startTime3, endTime3, const Color(0xFFD8E4BF), false,
          "New york to Loss Angels"),
      Meeting('Delivery', startTime4,endTime4, const Color(0xFFD8E4BF), false,
          "New york to Loss Angels"),
      Meeting('Pickup', startTime5,endTime5, const Color(0xFFE4BFBF), false,
          "New york to Florida")
    ];
    return meetings;
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay,
      this.note);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// Event note which is equivalent to subject property of [Appointment].
  String note;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
