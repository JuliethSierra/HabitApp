import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habits_app/pages/habit_detail_page.dart';

class HabitsList extends StatelessWidget {
  const HabitsList({
    super.key,
    required this.daysCompleted,
    required this.habitName,
    required this.habitDescription,
    required this.habitCompleted,
    required this.onChanged,
    required this.deleteFunction,
    required this.icon,
    required this.backgroundColor,
    required this.listDaysComplete,
    required this.onUpdateDays, // Nuevo callback para actualizar días completados
  });

  final String daysCompleted;
  final String habitName;
  final String habitDescription;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;
  final IconData icon;
  final Color backgroundColor;
  final List<DateTime> listDaysComplete;
  final Function(List<DateTime>) onUpdateDays; // Callback para pasar la lista actualizada

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(15),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            // Abrimos la página de detalles y pasamos el callback para actualizar la lista
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HabitDetailPage(
                  habitName: habitName,
                  completedDays: listDaysComplete,
                  onUpdateDays: (updatedDays) {
                    onUpdateDays(updatedDays); // Devolvemos la lista actualizada al callback
                  },
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  daysCompleted,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      icon,
                      color: Colors.white,
                      size: 28,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            habitName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            habitDescription,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
