import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:luna/data/constants.dart';
import 'package:luna/data/notifiers.dart';
import 'package:luna/pages/create_a_new_task.dart';
import 'package:luna/widgets/schedule_item.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _currentMonth = DateTime.now();
  DateTime? _selectedDate = DateTime.now();
  double get height => MediaQuery.of(context).size.height;

  List<Widget> _buildWeekDays(bool isDarkMode) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days
        .map(
          (d) => Expanded(
            child: Center(
              child: Text(
                d,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  List<Widget> _buildCalendarDays(bool isDarkMode) {
    final List<Widget> rows = [];

    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);

    final int weekDayOffset = (firstDay.weekday + 6) % 7;

    List<DateTime?> calendarSlots = List.filled(
      weekDayOffset,
      null,
      growable: true,
    );

    for (int i = 1; i <= lastDay.day; i++) {
      calendarSlots.add(DateTime(_currentMonth.year, _currentMonth.month, i));
    }

    while (calendarSlots.length % 7 != 0) {
      calendarSlots.add(null);
    }

    for (int i = 0; i < calendarSlots.length; i += 7) {
      rows.add(
        Row(
          children: calendarSlots
              .sublist(i, i + 7)
              .map(
                (date) => Expanded(
                  child: GestureDetector(
                    onTap: date == null
                        ? null
                        : () {
                            setState(() => _selectedDate = date);
                            _openBottomSheet(date, isDarkMode);
                          },
                    child: Container(
                      margin: const EdgeInsets.all(6),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color:
                            (_selectedDate != null &&
                                date != null &&
                                _selectedDate!.day == date.day &&
                                _selectedDate!.month == date.month)
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            date?.day.toString() ?? "",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
    }

    return rows;
  }

  void _openBottomSheet(DateTime date, bool isDarkMode) {
    final key = "${date.day}-${date.month}-${date.year}";

    showModalBottomSheet(
      context: context,
      enableDrag: true,
      barrierColor: Colors.transparent,
      builder: (context) {
        return Container(
          key: Key(key),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          ),
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            height: height * 0.36,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Schedule",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // SCROLLABLE LIST
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: scheduleItems.length,
                        itemBuilder: (context, index) {
                          final item = scheduleItems[index];
                          return ScheduleItem(
                            icon: item["icon"],
                            iconColor: item["color"],
                            title: item["title"],
                            time: item["time"],
                            isDarkMode: isDarkMode,
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),

                Positioned(
                  bottom: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CreateANewTask();
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.white : Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        size: 32,
                        color: isDarkMode ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
  }

  void _prevMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage: AssetImage(
                          isDarkMode
                              ? 'assets/images/logo_light.png'
                              : 'assets/images/logo_dark.png',
                        ),
                        backgroundColor: isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search_rounded, size: 35),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FittedBox(
                          child: Text(
                            DateFormat.yMMMM().format(_currentMonth),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? Colors.white.withValues(alpha: 0.1)
                                    : Colors.black.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.arrow_back_ios_new_rounded),
                                onPressed: _prevMonth,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isDarkMode
                                    ? Colors.white.withValues(alpha: 0.1)
                                    : Colors.black.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                                onPressed: _nextMonth,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Week Day Header
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.black.withValues(alpha: 0.5)
                            : Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(children: _buildWeekDays(isDarkMode)),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: SizedBox(
                      height: height * 0.35,
                      child: Column(children: _buildCalendarDays(isDarkMode)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
