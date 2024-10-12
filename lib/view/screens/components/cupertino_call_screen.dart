import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../modal/user_modal.dart';
import '../../../provider/platform_provider.dart';

class CupertinoCallScreen extends StatelessWidget {
  const CupertinoCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var platformProviderTrue = Provider.of<PlatFormProvider>(context);
    var platformProviderFalse =
    Provider.of<PlatFormProvider>(context, listen: false);
    return FutureBuilder(
      future: platformProviderFalse.readDataFromDatabase(),
      builder: (context, snapshot) {
        List<UserModal> userData = platformProviderTrue.userData
            .map(
              (e) => UserModal.fromMap(e),
        )
            .toList();

        return ListView.builder(
          itemCount: userData.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: CupertinoListTile(
                leading: CircleAvatar(
                  backgroundImage: (userData[index].profile ==
                      'https://www.pngkit.com/png/detail/25-258694_cool-avatar-transparent-image-cool-boy-avatar.png')
                      ? NetworkImage(userData[index].profile)
                      : FileImage(
                    File(userData[index].profile),
                  ),
                ),
                title: Text(userData[index].name),
                subtitle: Text(userData[index].chatConversation),
                trailing: const Icon(Icons.call),
              ),
            );
          },
        );
      },
    );
  }
}
