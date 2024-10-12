import 'dart:io';

import 'package:flutter/material.dart';
import 'package:platform_converter_app/provider/theme_controller.dart';
import 'package:provider/provider.dart';

import '../../../provider/platform_provider.dart';
import 'my_text_field.dart';

class AddUsers extends StatelessWidget {
  const AddUsers({super.key});

  @override
  Widget build(BuildContext context) {
    var platformProviderTrue = Provider.of<PlatFormProvider>(context);
    var platformProviderFalse =
        Provider.of<PlatFormProvider>(context, listen: false);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.015,
            ),
            GestureDetector(
              onTap: () {
                platformProviderFalse.addProfile();
              },
              child: Consumer<PlatFormProvider>(
                builder: (context, value, child) => CircleAvatar(
                  radius: 50,
                  backgroundImage: (value.profile != '')
                      ? FileImage(
                          File(value.profile),
                        )
                      : const NetworkImage(
                          'https://www.pngkit.com/png/detail/25-258694_cool-avatar-transparent-image-cool-boy-avatar.png'),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            MyTextField(
              controller: platformProviderTrue.txtName,
              label: 'Name',
            ),
            SizedBox(
              height: height * 0.02,
            ),
            MyTextField(
              textInputType: TextInputType.phone,
              controller: platformProviderTrue.txtPhone,
              label: 'Phone',
            ),
            SizedBox(
              height: height * 0.02,
            ),
            MyTextField(
              controller: platformProviderTrue.txtChatConversation,
              label: 'Chat Conversation',
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    platformProviderFalse.addDate(context);
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
                Consumer<PlatFormProvider>(
                  builder: (context, value, child) => Text(
                    (value.date == '') ? 'Pick Date' : value.date,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    platformProviderFalse.addTime(context);
                  },
                  icon: const Icon(Icons.alarm),
                ),
                Consumer<PlatFormProvider>(builder: (context, value, child) {
                  return Text(
                    (value.time == '') ? 'Pick Time' : value.time,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  );
                }),
              ],
            ),
            SizedBox(
              height: height * 0.23,
            ),
            GestureDetector(
              onTap: () async {
                await platformProviderFalse.addUserToDatabase(context);
              },
              child: Container(
                alignment: Alignment.center,
                height: height * 0.06,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: (!Provider.of<ThemeController>(context).isDark)
                      ? Colors.black
                      : Colors.white54,
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
