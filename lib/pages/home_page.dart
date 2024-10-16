import 'package:flutter/material.dart';
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

  List habitList = [
    [
      '0 Días completados',
      'Parcial',
      'Estudiar 30 min para parcial',
      false,
      Colors.blue,
      Icons.access_alarm_outlined
    ],
    [
      '0 Días completados',
      'Correr',
      'Correr 10 min todos los días',
      false,
      Colors.green,
      Icons.run_circle_outlined
    ],
    [
      '0 Días completados',
      'Leer un libro',
      'Leer 20 paginas a diario',
      false,
      Colors.purple,
      Icons.menu_book_outlined
    ],
  ];

  void checkBoxChanged(int index) {
    setState(() {
      habitList[index][3] = !habitList[index][3];
    });
  }

  void saveNewHabit() {
    setState(() {
      habitList.add([
        '0 Días completados',
        _nameController.text,
        _descriptionController.text,
        false
      ]);
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
            daysCompleted: habitList[index][0],
            habitName: habitList[index][1],
            habitDescription: habitList[index][2],
            habitCompleted: habitList[index][3],
            backgroundColor: habitList[index][4],
            icon: habitList[index][5],
            onChanged: (value) => checkBoxChanged(index),
            deleteFunction: (_) => deleteHabit(index),
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
                  habitList.add([
                    '0 Días completados',
                    habitName,
                    habitDescription,
                    false,
                    selectedColor,
                    selectedIcon,
                  ]);
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
