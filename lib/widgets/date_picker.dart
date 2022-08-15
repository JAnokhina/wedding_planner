import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:wedding_planner/themes.dart';

class SfDatePicker extends StatefulWidget {
  final ValueChanged<DateTime> onDateTimeChanged;
  const SfDatePicker({Key? key, required this.onDateTimeChanged})
      : super(key: key);

  @override
  State<SfDatePicker> createState() => _SfDatePickerState();
}

class _SfDatePickerState extends State<SfDatePicker> {
  /// Holds string value of DateTime chosen in calendar date picker
  String chosenDay = '';

  @override
  Widget build(BuildContext context) {
    return

        /// Syncfusion Date Picker
        SfDateRangePicker(
            initialSelectedDate: DateTime.now(),
            view: DateRangePickerView.month,
            monthViewSettings: const DateRangePickerMonthViewSettings(
              firstDayOfWeek: 1,
            ),
            onSelectionChanged: updateDate,
            showNavigationArrow: true,
            selectionColor: AppColours.primary,
            todayHighlightColor: AppColours.primary,
            monthCellStyle: DateRangePickerMonthCellStyle(
                todayTextStyle: TextStyle(color: AppColours.primary)));
  }

  /// This method updates the chosenDay variable everytime you tap on a date in the calendar
  /// date picker.
  updateDate(DateRangePickerSelectionChangedArgs newSelection) {
    setState(() {
      chosenDay = newSelection.value.toString();
    });
    widget.onDateTimeChanged(newSelection.value);
  }
}