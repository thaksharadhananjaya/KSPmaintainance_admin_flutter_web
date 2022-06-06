import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gps_admin/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: const FirebaseOptions(
        apiKey: "AIzaSyCW_Isb5j5j4l_U19b3H51glvS9srQ68OA",
        authDomain: "ksp-9a21f.firebaseapp.com",
        projectId: "ksp-9a21f",
        storageBucket: "ksp-9a21f.appspot.com",
        messagingSenderId: "543003869633",
        appId: "1:543003869633:web:8d55e68081707ed110ef40",
        measurementId: "G-16JLS5TH60"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KSPmaintainance | Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Login(),
    );
  }
}
