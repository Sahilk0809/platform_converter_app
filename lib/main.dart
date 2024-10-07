import 'package:flutter/material.dart';
import 'package:platform_converter_app/provider/task1_provider.dart';
import 'package:platform_converter_app/view/screens/task1.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Task1Provider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          datePickerTheme: const DatePickerThemeData(),
          colorScheme: const ColorScheme.light(
            primary: Colors.black,
            onSurface: Colors.black,
          ),
        ),
        home: const Task1(),
      ),
    );
  }
}
