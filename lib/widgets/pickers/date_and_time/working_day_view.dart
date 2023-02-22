import 'package:are_you_shipping_me/service_and_utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_styles.dart';

class WorkingDayView extends StatefulWidget {
  final WorkingDayModel workingDayModel;
  final bool isViewOnly;

  const WorkingDayView(
      {Key? key, required this.workingDayModel, this.isViewOnly = false})
      : super(key: key);

  @override
  State<WorkingDayView> createState() => _WorkingDayViewState();
}

class _WorkingDayViewState extends State<WorkingDayView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Row(
        children: [
          Row(
            children: [
              if (!widget.isViewOnly)
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Checkbox(
                    value: widget.workingDayModel.isChecked,
                    onChanged: (value) {
                      widget.workingDayModel.isChecked = value!;
                      setState(() {});
                    },
                  ),
                ),
              if (!widget.isViewOnly) AppStyles.extraSmallBox,
              Text(
                widget.workingDayModel.day,
                style: TextStyle(
                  color: widget.workingDayModel.isChecked
                      ? null
                      : Theme.of(context).colorScheme.onSurface.withOpacity(.5),
                ),
              ),
            ],
          ),
          const Spacer(),
          IgnorePointer(
            ignoring: !widget.workingDayModel.isChecked,
            child: Row(
              children: [
                TimeView(
                  workingDayModel: widget.workingDayModel,
                  isStartingTime: true,
                ),
                AppStyles.smallBox,
                TimeView(
                  workingDayModel: widget.workingDayModel,
                  isStartingTime: false,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TimeView extends StatefulWidget {
  final WorkingDayModel workingDayModel;

  final bool isStartingTime;

  const TimeView(
      {Key? key, required this.workingDayModel, required this.isStartingTime})
      : super(key: key);

  @override
  State<TimeView> createState() => _TimeViewState();
}

class _TimeViewState extends State<TimeView> {
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTimeUtils.timeAndDateToDateTime(
        widget.isStartingTime
            ? widget.workingDayModel.startingTime ??
                const TimeOfDay(hour: 0, minute: 0)
            : widget.workingDayModel.endingTime ??
                const TimeOfDay(hour: 23, minute: 59));

    String text = DateFormat('hh:mm a').format(dateTime).toString();
    return GestureDetector(
      onTap: () async {
        TimeOfDay? timeOfDay = await showTimePicker(
            initialTime: TimeOfDay.now(), context: context);
        if (timeOfDay != null) {
          if (widget.isStartingTime) {
            widget.workingDayModel.startingTime = timeOfDay;
          } else {
            widget.workingDayModel.endingTime = timeOfDay;
          }
          setState(() {});
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
            // color: widget.workingDayModel.isChecked?Colors.white:Colors.grey.shade100,
            border: AppStyles.borderSmallThin,
            borderRadius: BorderRadius.circular(4)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                  color: widget.workingDayModel.isChecked
                      ? null
                      : Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(.5)),
            ),
            AppStyles.extraSmallBox,
            Icon(Icons.access_time,
                size: 16,
                color: widget.workingDayModel.isChecked
                    ? null
                    : Theme.of(context).colorScheme.onSurface.withOpacity(.5))
          ],
        ),
      ),
    );
  }
}

class WorkingDayModel {
  String day;
  TimeOfDay? startingTime, endingTime;
  bool isChecked;
  String startApiKey;
  String endApiKey;

  WorkingDayModel(
      {required this.day,
      this.startingTime,
      this.endingTime,
      required this.startApiKey,
      required this.endApiKey,
      this.isChecked = true});

  WorkingDayModel.clone(WorkingDayModel source)
      : day = source.day,
        isChecked = source.isChecked,
        startApiKey = source.startApiKey,
        endApiKey = source.endApiKey,
        endingTime = source.endingTime,
        startingTime = source.startingTime;
}
