import 'package:flutter/material.dart';
import 'package:datn_project/locker_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Đảm bảo Flutter được khởi tạo
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      home: LockerScreen(), // Chỉ định màn hình chính
    ),
  );
}
