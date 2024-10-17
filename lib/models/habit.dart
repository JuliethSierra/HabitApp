
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

class Habit {
  String name;
  String description;
  bool completed;
  Color color;
  IconData icon;
  List<DateTime> completedDays; // Lista de fechas en las que el hábito fue completado

  Habit(this.name, this.description, this.completed, this.color, this.icon, this.completedDays);

int calculateStreak(List<DateTime> completedDays) {
  if (completedDays.isEmpty) {
    return 0;
  }

  // Ordenamos la lista de días en orden descendente (más recientes primero)
  completedDays.sort((a, b) => b.compareTo(a));

  DateTime today = DateTime.now();
  int streak = 0;

  // Verificamos si hoy está en la lista, si no, empezamos desde ayer
  DateTime currentDay = completedDays.first.isAtSameMomentAs(today)
      ? today
      : today.subtract(const Duration(days: 1));

  for (var day in completedDays) {
    if (isSameDay(day, currentDay)) {
      streak++;
      currentDay = currentDay.subtract(const Duration(days: 1)); // Retrocede un día
    } else {
      break; // Si el día no es consecutivo, salimos del bucle
    }
  }

  return streak;
}

  
}