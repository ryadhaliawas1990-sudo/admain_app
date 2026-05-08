import 'package:flutter/material.dart';
import '../db/app_db.dart';
import 'add_status_screen.dart';

class HrScreen extends StatefulWidget {
  const HrScreen({super.key});

  @override
  State<HrScreen> createState() => _HrScreenState();
}

class _HrScreenState extends State<HrScreen> {

  List<Map<String, dynamic>> persons = [];

  final name = TextEditingController();
  final number = TextEditingController();

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    persons = await AppDB.getPersons();
    setState(() {});
  }

  Future<void> add() async {
    await AppDB.addPerson(name.text, number.text);
    name.clear();
    number.clear();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الموارد البشرية")),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [

                TextField(controller: name, decoration: const InputDecoration(labelText: "الاسم")),
                TextField(controller: number, decoration: const InputDecoration(labelText: "الرقم")),

                ElevatedButton(
                  onPressed: add,
                  child: const Text("إضافة فرد"),
                ),

              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: persons.length,
              itemBuilder: (c, i) {
                final p = persons[i];

                return ListTile(
                  title: Text(p["name"]),
                  subtitle: Text(p["number"]),

                  trailing: IconButton(
                    icon: const Icon(Icons.edit_calendar),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddStatusScreen(personId: p["id"]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}
