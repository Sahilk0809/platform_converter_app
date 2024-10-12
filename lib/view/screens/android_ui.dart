import 'package:flutter/material.dart';
import 'package:platform_converter_app/provider/platform_change_controller.dart';
import 'package:platform_converter_app/provider/platform_provider.dart';
import 'package:platform_converter_app/provider/theme_controller.dart';
import 'package:platform_converter_app/view/screens/components/add_users.dart';
import 'package:platform_converter_app/view/screens/components/call_screen.dart';
import 'package:platform_converter_app/view/screens/components/chat_screen.dart';
import 'package:provider/provider.dart';

class AndroidUi extends StatelessWidget {
  const AndroidUi({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProviderTrue = Provider.of<ThemeController>(context);
    var themeProviderFalse =
        Provider.of<ThemeController>(context, listen: false);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Platform Converter'),
          actions: [
            Consumer<PlatformChangeProvider>(builder: (context, value, child) {
              return Switch(
                value: value.isIos,
                onChanged: (value) {
                  Provider.of<PlatformChangeProvider>(context, listen: false)
                      .toggleBetweenPlatforms();
                },
              );
            }),
          ],
          bottom: const TabBar(
            tabAlignment: TabAlignment.fill,
            indicatorPadding: EdgeInsets.zero,
            tabs: [
              Tab(
                child: Icon(Icons.account_circle),
              ),
              Tab(text: 'CHATS'),
              Tab(text: 'CALLS'),
              Tab(text: 'SETTINGS'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const AddUsers(),
            const ChatScreen(),
            const CallScreen(),
            ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: const Text('Profile'),
                  subtitle: const Text('Update Profile Data'),
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {},
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.dark_mode_outlined),
                  title: const Text('Theme'),
                  subtitle: const Text('Change Theme'),
                  trailing: Switch(
                    value: themeProviderTrue.isDark,
                    onChanged: (value) {
                      themeProviderFalse.toggleTheme();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
