import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' show basename;

// تطبيق بسيط لاضافه صوره من الجهاز او تصوير صوره من الكاميره واضافتها في الاسكرين
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // تحميل الصور اله الشاشه الخاصه بنا اللي هيا الاسكرين
  File? imgPath;
  uploadImage() async {
    //  بتحدد عوز لما تضغط علي الزر يفتح ايه ImageSource
    // اللي هو الصور من الجهاز gallery او camera لو عوز يفتح الكاميره بتكتب
    final pickedImg =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    try {
      if (pickedImg != null) {
        setState(() {
          // مكان الصوره
          imgPath = File(pickedImg.path);
        });
        // للحصول علي اسم الصوره فقط
        String imgName = basename(pickedImg.path);
        // إنشاء إسم فريد لكل صورة
        int random = Random().nextInt(9999999);
        // imgName هنا بيجمع اسم الصوره + الرقم عشوائي ويغير قيمه
        imgName = '$random$random';
        print("ــــــــــــــــــــــــــــــــــ");
        // طباعه مكان الصوره كامل بالملفات
        print('imgPath: $imgPath');
        print("ــــــــــــــــــــــــــــــــــ");
        // طباعه اسم الصوره
        print('imgName: $imgName');
        print("ــــــــــــــــــــــــــــــــــ");
        // طباعه رقم عشوائي
        print('random: $random');
        print("ــــــــــــــــــــــــــــــــــ");
        // اسم الصوره + الرقم عشوائي
        print('$random$imgName');
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await uploadImage();
        },
      ),
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: Center(
          child: (imgPath == null)
              //  في حاله ان الصوره لسه مش موجودها
              ? const Text('NO img selected')
              //  بعد ما يحصل علي القيمه بنجاح يعرض الصوره في الاسكرين
              : Image.file(imgPath!)),
    );
  }
}
