import 'package:flutter/material.dart';
import '../db/app_db.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {

  final search = TextEditingController();
  final year = TextEditingController();

  List<Map<String, dynamic>> result = [];

  Future<void> searchData() async {
    final db = await AppDB.getDB();

    final person = await db.query(
      "persons",
      where: "name LIKE ?",
      whereArgs: ['%${search.text}%'],
    );

    if (person.isNotEmpty) {
      final id = person.first["id"];

      result = await db.query(
        "status",
        where: "personId=? AND year=?",
        whereArgs: [id, year.text],
      );

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("المباينة")),

      body: Column(
        children: [

          TextField(controller: search, decoration: const InputDecoration(labelText: "بحث")),
          TextField(controller: year, decoration: const InputDecoration(labelText: "السنة")),

          ElevatedButton(
            onPressed: searchData,
            child: const Text("بحث"),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: result.length,
              itemBuilder: (c, i) {
                final r = result[i];

                return ListTile(
                  title: Text(r["month"]),
                  subtitle: Text(r["status"]),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}
