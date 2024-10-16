import 'package:flutter/material.dart';
import 'package:habits_app/utils/habits_list.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  List habitList = [
    ['0 Días completados', 'Parcial', false],
    ['0 Días completados','Correr', false],
    ['0 Días completados','Leer un libro', false],
  ];

  void checkBoxChanged(int index) {
    setState(() {
      habitList[index][2] = !habitList[index][2];
    });
  }

  void saveNewHabit() {
    setState(() {
      habitList.add([_controller.text, false]);
      _controller.clear();
    });
  }

  void deleteHabit(int index) {
    setState(() {
      habitList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200,
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
              habitCompleted: habitList[index][2],
              onChanged: (value) => checkBoxChanged(index),
              deleteFunction: (value) => deleteHabit(index),
            );
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Añadir Nuevo Habito',
                  filled: true,
                  fillColor: Colors.deepPurple.shade100,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            )),
            FloatingActionButton(
              onPressed: saveNewHabit,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
