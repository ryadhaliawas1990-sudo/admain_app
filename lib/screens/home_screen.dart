import 'package:flutter/material.dart';

class HrScreen extends StatefulWidget {
  const HrScreen({super.key});

  @override
  State<HrScreen> createState() => _HrScreenState();
}

class _HrScreenState extends State<HrScreen> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final rankController = TextEditingController();
  final unitController = TextEditingController();
  final statusController = TextEditingController();

  List<Map<String, String>> people = [];

  void addPerson() {
    setState(() {
      people.add({
        "name": nameController.text,
        "number": numberController.text,
        "rank": rankController.text,
        "unit": unitController.text,
        "status": statusController.text,
      });

      nameController.clear();
      numberController.clear();
      rankController.clear();
      unitController.clear();
      statusController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الموارد البشرية"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "اسم الضابط / الفرد",
              ),
            ),

            TextField(
              controller: numberController,
              decoration: const InputDecoration(
                labelText: "رقم الضابط / الفرد",
              ),
            ),

            TextField(
              controller: rankController,
              decoration: const InputDecoration(
                labelText: "الرتبة",
              ),
            ),

            TextField(
              controller: unitController,
              decoration: const InputDecoration(
                labelText: "الوحدة",
              ),
            ),

            TextField(
              controller: statusController,
              decoration: const InputDecoration(
                labelText: "الحالة",
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: addPerson,
              child: const Text("إضافة"),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: people.length,
                itemBuilder: (context, index) {
                  final p = people[index];

                  return Card(
                    child: ListTile(
                      title: Text(p["name"] ?? ""),
                      subtitle: Text(
                        "رقم: ${p["number"]} | رتبة: ${p["rank"]} | وحدة: ${p["unit"]} | حالة: ${p["status"]}",
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
