import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter_app/provider/platform_change_controller.dart';
import 'package:platform_converter_app/provider/platform_provider.dart';
import 'package:platform_converter_app/provider/task1_provider.dart';
import 'package:platform_converter_app/provider/theme_controller.dart';
import 'package:platform_converter_app/view/screens/android_ui.dart';
import 'package:platform_converter_app/view/screens/iOS_ui.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isDark = false;
bool isIos = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  isDark = sharedPreferences.getBool("theme") ?? false;
  isIos = sharedPreferences.getBool("platform") ?? false;

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => Task1Provider(),
    ),
    ChangeNotifierProvider(
      create: (context) => PlatFormProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ThemeController(isDark),
    ),
    ChangeNotifierProvider(
      create: (context) => PlatformChangeProvider(isIos),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var providerTheme = Provider.of<ThemeController>(context);
    return (!Provider.of<PlatformChangeProvider>(context).isIos)
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: (providerTheme.isDark)
                ? providerTheme.themeDark
                : providerTheme.themeLight,
            home: const AndroidUi(),
          )
        : CupertinoApp(
            debugShowCheckedModeBanner: false,
            theme: (providerTheme.isDark)
                ? providerTheme.cupertinoThemeDark
                : providerTheme.cupertinoThemeLight,
            home: const IosUi(),
          );
  }
}
