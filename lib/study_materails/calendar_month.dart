import 'package:are_you_shipping_me/constants/app_colors.dart';
import 'package:are_you_shipping_me/constants/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class MonthWiseCalendar extends StatefulWidget {
  const MonthWiseCalendar({
    Key? key,
  }) : super(key: key);

  @override
  MonthWiseCalendarState createState() => MonthWiseCalendarState();
}

class MonthWiseCalendarState extends State<MonthWiseCalendar> {
  CalendarController? _controller;
  DateTime? selectedDateTime;
  static DateTime kToday = DateTime.now();
  static DateTime kFirstDay =
      DateTime(kToday.year, kToday.month - 1, kToday.day);
  static DateTime kLastDay =
      DateTime(kToday.year, kToday.month + 1, kToday.day);

  static TextStyle calendarDateStyle({Color? color}) {
    return TextStyle(
      color: color ?? const Color(0xFF291139),
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
      backgroundColor: AppColors.primaryBgColor,
      appBar: AppBar(title: const Text("Routes")),
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 8),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.white,
        border: Border.all(width: 1,color: Colors.white54),
          boxShadow: AppStyles.shadowMedium
        ),
        child: _calendarDetailView());
  }

  Widget _calendarDetailView() {
    return SfCalendar(viewHeaderStyle:ViewHeaderStyle(backgroundColor: Colors.grey.shade300, ) ,
      timeSlotViewSettings: const TimeSlotViewSettings(
          timeIntervalWidth: 60,
          timeIntervalHeight: 52,
          timeRulerSize: 48,
          startHour: 0,
          endHour: 24),
      view: CalendarView.month,
      headerHeight: 60,
      viewNavigationMode: ViewNavigationMode.snap,
      controller: _controller,
      cellEndPadding: 0,
      headerStyle: const CalendarHeaderStyle(textAlign: TextAlign.center,
        textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 16,),
      ),
      dataSource: MeetingDataSource(_getDataSource()),
      monthCellBuilder: monthCellBuilder,
      monthViewSettings: MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.none),
      appointmentBuilder: (context, details) {
        final Meeting meeting = details.appointments.first;
        return Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "assets/ic_truck.png",
                width: 20,
                height: 12,
              ),
              const SizedBox(height: 2),
              Text(
                meeting.note,
                style: const TextStyle(
                    fontSize: 6,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.left,
                maxLines: 3,
                softWrap: true,
              ),
            ],
          ),
        );
      },
    );
  }
  Widget monthCellBuilder(BuildContext context, MonthCellDetails details) {
    if (details.appointments.isNotEmpty) {
      if(details.appointments.first is Meeting){
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(0),color: Colors.white,
              border: Border.all(width: .2,color: Colors.grey),
              boxShadow: AppStyles.shadowSmall
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                details.date.day.toString(),
                textAlign: TextAlign.end,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Image.asset(
                      "assets/ic_truck.png",
                      width: 20,
                      height: 12,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      (details.appointments.first as Meeting).note,
                      style: const TextStyle(
                          fontSize: 6,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left,
                      maxLines: 3,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }

    }
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(0),color: Colors.white,
          border: Border.all(width: .2,color: Colors.grey),
          boxShadow: AppStyles.shadowSmall
      ),
      child: Text(
        details.date.day.toString(),
        textAlign: TextAlign.end,
      ),
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
