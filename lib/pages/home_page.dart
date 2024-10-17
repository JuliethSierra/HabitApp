import 'package:flutter/material.dart';
import 'package:habits_app/models/habit.dart';
import 'package:habits_app/utils/habits_list.dart';
import 'package:habits_app/utils/icon_list.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  List<Habit> habitList = [
    Habit('Parcial', 'Estudiar', false, Colors.blue, Icons.access_alarm_outlined, [
    DateTime.utc(2024, 10, 1),
    DateTime.utc(2024, 10, 5),
    DateTime.utc(2024, 10, 10),
    ]),
    Habit('Correr', 'Correr 10 min todos los días', false, Colors.green, Icons.run_circle_outlined, [
    DateTime.utc(2024, 10, 1),
    DateTime.utc(2024, 10, 5),
    DateTime.utc(2024, 10, 10),
    ]),
    Habit('Leer un libro', 'Leer 20 paginas a diario', false, Colors.purple, Icons.menu_book_outlined, [
    DateTime.utc(2024, 10, 1),
    DateTime.utc(2024, 10, 5),
    DateTime.utc(2024, 10, 10),
    ]),
  ];

  void checkBoxChanged(int index) {
    setState(() {
      habitList[index].completed = !habitList[index].completed;
    });
  }

  void saveNewHabit() {
    setState(() {
      habitList.add(
        Habit(_nameController.text, _descriptionController.text, false, Colors.purple, Icons.new_label, []));
      _nameController.clear();
      _descriptionController.clear();
    });
    Navigator.of(context).pop();
  }

  void deleteHabit(int index) {
    setState(() {
      habitList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit App'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: habitList.length,
        itemBuilder: (BuildContext context, index) {
          return HabitsList(
            daysCompleted: ' ${habitList[index].completedDays.length} días completados',
            habitName: habitList[index].name,
            habitDescription: habitList[index].description,
            habitCompleted: habitList[index].completed,
            backgroundColor: habitList[index].color,
            icon: habitList[index].icon,
            listDaysComplete: habitList[index].completedDays,
            onChanged: (value) => checkBoxChanged(index),
            deleteFunction: (_) => deleteHabit(index),
            onUpdateDays: (updatedDays) {
              setState(() {
                habitList[index].completedDays = updatedDays; // Actualizamos la lista de días completados
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddHabitDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

// Método para abrir el diálogo y agregar un nuevo hábito
  void openAddHabitDialog() {
    String habitName = '';
    String habitDescription = '';
    Color selectedColor = Colors.blue;
    IconData selectedIcon = Icons.circle;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar Nuevo Hábito'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  habitName = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Nombre del Hábito',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                onChanged: (value) {
                  habitDescription = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Descripción del Hábito',
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Icono: '),
                  const SizedBox(width: 10),
                  DropdownButton<IconData>(
                    value: selectedIcon,
                    items: IconList().iconMap.entries.map((entry) {
                      return DropdownMenuItem(
                        value: entry.value,
                        child: Icon(entry.value),
                      );
                    }).toList(),
                    onChanged: (icon) {
                      setState(() {
                        selectedIcon = icon!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Color Picker Dropdown
              Row(
                children: [
                  const Text('Color: '),
                  const SizedBox(width: 10),
                  DropdownButton<Color>(
                    value: selectedColor,
                    items: [
                      Colors.red,
                      Colors.blue,
                      Colors.green,
                      Colors.yellow,
                      Colors.purple,
                      Colors.orange,
                    ].map((color) {
                      return DropdownMenuItem(
                        value: color,
                        child: Container(
                          width: 24,
                          height: 24,
                          color: color,
                        ),
                      );
                    }).toList(),
                    onChanged: (color) {
                      setState(() {
                        selectedColor = color!;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  habitList.add(
                    Habit(habitName, habitDescription, false, selectedColor, selectedIcon, []),
                    );
                });
                Navigator.of(context).pop();
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }
}
