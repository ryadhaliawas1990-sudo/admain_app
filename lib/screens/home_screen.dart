import 'package:flutter/material.dart';
import 'hr_screen.dart';
import 'report_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("النظام الإداري")),

      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(12),

        children: [

          _card(context, "الموارد البشرية", Icons.people, const HrScreen()),
          _card(context, "المباينة", Icons.search, const ReportScreen()),
          _card(context, "الفنية", Icons.build, null),
          _card(context, "الإمداد", Icons.local_shipping, null),

        ],
      ),

      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(8),
        child: Text("م/رياض عواس - 781927044", textAlign: TextAlign.center),
      ),
    );
  }

  Widget _card(BuildContext c, String t, IconData i, Widget? p) {
    return Card(
      child: InkWell(
        onTap: p == null ? null : () {
          Navigator.push(c, MaterialPageRoute(builder: (_) => p));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(i, size: 40),
            Text(t),
          ],
        ),
      ),
    );
  }
}
