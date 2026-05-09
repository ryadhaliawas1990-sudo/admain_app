import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController search = TextEditingController();
  final TextEditingController year = TextEditingController();

  // بيانات تجريبية (لاحقًا ستصبح من قاعدة بيانات)
  Map<String, List<Map<String, String>>> data = {
    "101": [
      {"month": "يناير", "status": "موجود"},
      {"month": "فبراير", "status": "غائب"},
      {"month": "مارس", "status": "جريح"},
      {"month": "أبريل", "status": "موجود"},
      {"month": "مايو", "status": "دوره"},
    ],
    "102": [
      {"month": "يناير", "status": "موجود"},
      {"month": "فبراير", "status": "موجود"},
      {"month": "مارس", "status": "منتدب"},
      {"month": "أبريل", "status": "مريض"},
      {"month": "مايو", "status": "شهيد"},
    ],
  };

  List<Map<String, String>> result = [];

  void generateReport() {
    String key = search.text.trim();

    setState(() {
      result = data[key] ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("المباينة"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller: search,
              decoration: const InputDecoration(
                labelText: "رقم الفرد",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: year,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "السنة",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: generateReport,
                child: const Text("عرض المباينة"),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: result.isEmpty
                  ? const Center(
                      child: Text(
                        "لا توجد بيانات",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),

                        child: Column(
                          children: [

                            Text(
                              "رقم: ${search.text}  |  سنة: ${year.text}",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Expanded(
                              child: SingleChildScrollView(
                                child: Table(
                                  border: TableBorder.all(),

                                  children: [

                                    const TableRow(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                            "الشهر",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Text(
                                            "الحالة",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),

                                    ...result.map(
                                      (e) => TableRow(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              e["month"] ?? "",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Text(
                                              e["status"] ?? "",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
