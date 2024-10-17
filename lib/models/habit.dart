
import 'package:flutter/widgets.dart';

class Habit {
  String name;
  String description;
  bool completed;
  Color color;
  IconData icon;
  List<DateTime> completedDays; // Lista de fechas en las que el hábito fue completado

  Habit(this.name, this.description, this.completed, this.color, this.icon, this.completedDays);
}