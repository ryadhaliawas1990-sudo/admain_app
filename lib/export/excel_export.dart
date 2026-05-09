import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import '../db/db_helper.dart';

class ExcelExport {

  static Future<String> exportPeople() async {

    // جلب البيانات من قاعدة البيانات
    final data = await DBHelper.getPeople();

    // إنشاء ملف Excel جديد
    final excel = Excel.createExcel();

    // إنشاء صفحة داخل Excel
    final sheet = excel['People'];

    // إضافة العناوين
    sheet.appendRow([
      TextCellValue("اسم الضابط / الفرد"),
      TextCellValue("الرقم"),
      TextCellValue("الرتبة"),
      TextCellValue("الوحدة"),
      TextCellValue("الحالة"),
    ]);

    // إضافة البيانات
    for (var row in data) {
      sheet.appendRow([
        TextCellValue(row['name'] ?? ""),
        TextCellValue(row['number'] ?? ""),
        TextCellValue(row['rank'] ?? ""),
        TextCellValue(row['unit'] ?? ""),
        TextCellValue(row['status'] ?? ""),
      ]);
    }

    // مسار حفظ الملف
    final dir = await getExternalStorageDirectory();

    final filePath = "${dir!.path}/people.xlsx";

    // حفظ الملف
    final fileBytes = excel.save();

    File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    return filePath;
  }
}
