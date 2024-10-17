import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HabitDetailPage extends StatefulWidget {
  final String habitName;
  final List<DateTime> completedDays;
  final Function(List<DateTime>) onUpdateDays; // Recibimos el callback para actualizar los días completados

  const HabitDetailPage({
    super.key,
    required this.habitName,
    required this.completedDays,
    required this.onUpdateDays,
  });

  @override
  _HabitDetailPageState createState() => _HabitDetailPageState();
}

class _HabitDetailPageState extends State<HabitDetailPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  late List<DateTime> _completedDays;

  @override
  void initState() {
    super.initState();
    _completedDays = List.from(widget.completedDays);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.habitName),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  if (_completedDays.any((d) => isSameDay(d, day))) {
                    return Container(
                      margin: const EdgeInsets.all(6.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (!_completedDays.any((day) => isSameDay(day, _selectedDay))) {
                    _completedDays.add(_selectedDay);
                  }
                });
              },
              child: const Text('Marcar Día Completado'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.onUpdateDays(_completedDays); // Usamos el callback para devolver la lista actualizada
          Navigator.pop(context);
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
