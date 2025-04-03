import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:products/provider/product_provider.dart';
import 'package:products/view/login.dart';
import 'package:products/provider/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          color: Colors.black,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 22.5),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.blue.shade900,
          selectionColor: Colors.blue.shade900,
          selectionHandleColor: Colors.blue.shade900,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedIconTheme: IconThemeData(color: Colors.indigo, size: 25),
          unselectedIconTheme: IconThemeData(color: Colors.grey, size: 25),
          selectedLabelStyle: TextStyle(fontSize: 18, color: Colors.indigo),
          unselectedLabelStyle: TextStyle(fontSize: 18, color: Colors.grey),
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.indigo,
          unselectedItemColor: Colors.grey,
        ),
        splashColor: Colors.black,
        highlightColor: Colors.black,
      ),
      home: Login(),
    );
  }
}