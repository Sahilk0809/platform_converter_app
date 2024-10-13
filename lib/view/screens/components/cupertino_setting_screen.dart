import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter_app/provider/platform_provider.dart';
import 'package:platform_converter_app/view/screens/components/my_cupertino_text_field.dart';
import 'package:provider/provider.dart';

import '../../../provider/theme_controller.dart';

class CupertinoSettingScreen extends StatelessWidget {
  const CupertinoSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProviderTrue = Provider.of<ThemeController>(context);
    var themeProviderFalse =
        Provider.of<ThemeController>(context, listen: false);
    var platformProviderFalse =
        Provider.of<PlatFormProvider>(context, listen: false);
    var platformProviderTrue = Provider.of<PlatFormProvider>(context);
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: CupertinoListTile(
            leading: const Icon(CupertinoIcons.person_add),
            title: const Text('Profile'),
            subtitle: const Text('Update Profile Data'),
            trailing: CupertinoSwitch(
              value: platformProviderTrue.profileUpdate,
              onChanged: (value) {
                platformProviderFalse.toggleProfileUpdate();
              },
            ),
          ),
        ),
        (platformProviderTrue.profileUpdate)
            ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  children: [
                    Consumer<PlatFormProvider>(
                      builder: (context, value, child) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CupertinoButton(
                            onPressed: () {
                              platformProviderFalse.addProfile();
                            },
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: (value.profile != '')
                                  ? FileImage(
                                      File(value.profile),
                                    )
                                  : const NetworkImage(
                                      'https://www.pngkit.com/png/detail/25-258694_cool-avatar-transparent-image-cool-boy-avatar.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    MyCupertinoTextField(
                      placeholder: 'Name',
                      controller: platformProviderTrue.txtCurrentUserName,
                      icons: CupertinoIcons.person_add,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyCupertinoTextField(
                      placeholder: 'Chat Conversation',
                      controller: platformProviderTrue.txtCurrentUserChat,
                      icons: CupertinoIcons.person_add,
                    ),
                  ],
                ),
            )
            : Container(),
        CupertinoListTile(
          leading: const Icon(CupertinoIcons.moon),
          title: const Text('Theme'),
          subtitle: const Text('Change Theme'),
          trailing: CupertinoSwitch(
            value: themeProviderTrue.isDark,
            onChanged: (value) {
              themeProviderFalse.toggleTheme();
            },
          ),
        ),
      ],
    );
  }
}
