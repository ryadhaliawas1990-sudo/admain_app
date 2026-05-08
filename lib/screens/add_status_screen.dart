import 'package:flutter/material.dart';
import '../db/app_db.dart';
import '../utils/status_list.dart';

class AddStatusScreen extends StatefulWidget {
  final int personId;

  const AddStatusScreen({super.key, required this.personId});

  @override
  State<AddStatusScreen> createState() => _AddStatusScreenState();
}

class _AddStatusScreenState extends State<AddStatusScreen> {

  String? month;
  String? status;
  final year = TextEditingController();

  final months = [
    "يناير","فبراير","مارس","أبريل","مايو","يونيو",
    "يوليو","أغسطس","سبتمبر","أكتوبر","نوفمبر","ديسمبر"
  ];

  Future<void> save() async {
    final db = await AppDB.getDB();

    await db.insert("status", {
      "personId": widget.personId,
      "month": month,
      "year": year.text,
      "status": status,
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إضافة حالة")),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [

            TextField(
              controller: year,
              decoration: const InputDecoration(labelText: "السنة"),
            ),

            DropdownButtonFormField(
              hint: const Text("الشهر"),
              items: months.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
              onChanged: (v) => month = v,
            ),

            DropdownButtonFormField(
              hint: const Text("الحالة"),
              items: StatusList.items.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) => status = v,
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: save,
              child: const Text("حفظ"),
            ),

          ],
        ),
      ),
    );
  }
}
