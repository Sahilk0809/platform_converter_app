import 'dart:io';
import 'package:flutter/material.dart';
import 'package:platform_converter_app/modal/user_modal.dart';
import 'package:provider/provider.dart';
import '../../../provider/platform_provider.dart';
import 'my_text_field.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var platformProviderTrue = Provider.of<PlatFormProvider>(context);
    var platformProviderFalse =
        Provider.of<PlatFormProvider>(context, listen: false);
    var height = MediaQuery.of(context).size.height;
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
            return Consumer<PlatFormProvider>(builder: (context, value, child) {
              return ListTile(
                onLongPress: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              backgroundImage: (userData[index].profile ==
                                      'https://www.pngkit.com/png/detail/25-258694_cool-avatar-transparent-image-cool-boy-avatar.png')
                                  ? NetworkImage(userData[index].profile)
                                  : FileImage(
                                      File(userData[index].profile),
                                    ),
                              radius: 50,
                            ),
                            SizedBox(
                              height: height * 0.004,
                            ),
                            Text(
                              userData[index].name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.002,
                            ),
                            Text(
                              userData[index].chatConversation,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    value.txtChatConversation.text =
                                        userData[index].chatConversation;
                                    value.txtName.text = userData[index].name;
                                    value.txtPhone.text = userData[index].phone;
                                    value.profile = userData[index].profile;
                                    Navigator.pop(context);
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) =>
                                          SingleChildScrollView(
                                        child: AlertDialog(
                                          title: const Text('Update User'),
                                          actions: [
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    platformProviderFalse
                                                        .addProfile();
                                                  },
                                                  child: Consumer<
                                                      PlatFormProvider>(
                                                    builder: (context, value,
                                                            child) =>
                                                        CircleAvatar(
                                                      radius: 50,
                                                      backgroundImage: (value
                                                                  .profile ==
                                                              'https://www.pngkit.com/png/detail/25-258694_cool-avatar-transparent-image-cool-boy-avatar.png')
                                                          ? NetworkImage(
                                                              value.profile)
                                                          : FileImage(
                                                              File(value
                                                                  .profile),
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.01,
                                                ),
                                                MyTextField(
                                                  controller:
                                                      platformProviderTrue
                                                          .txtName,
                                                  label: 'Name',
                                                ),
                                                SizedBox(
                                                  height: height * 0.01,
                                                ),
                                                MyTextField(
                                                  textInputType:
                                                      TextInputType.phone,
                                                  controller:
                                                      platformProviderTrue
                                                          .txtPhone,
                                                  label: 'Phone',
                                                ),
                                                SizedBox(
                                                  height: height * 0.01,
                                                ),
                                                MyTextField(
                                                  controller:
                                                      platformProviderTrue
                                                          .txtChatConversation,
                                                  label: 'Chat Conversation',
                                                ),
                                                SizedBox(
                                                  height: height * 0.01,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        value.clearAllVar();
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        value.updateDataInDb(
                                                          value.txtName.text,
                                                          value.txtPhone.text,
                                                          value
                                                              .txtChatConversation
                                                              .text,
                                                          value.profile,
                                                          userData[index].id!,
                                                        );
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text('OK'),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    value.deleteUserFromDb(index);
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                leading: CircleAvatar(
                  backgroundImage: (value.userData[index]['profile'] ==
                          'https://www.pngkit.com/png/detail/25-258694_cool-avatar-transparent-image-cool-boy-avatar.png')
                      ? NetworkImage(value.userData[index]['profile'])
                      : FileImage(
                          File(value.userData[index]['profile']),
                        ),
                ),
                title: Text(value.userData[index]['name']),
                subtitle: Text(value.userData[index]['chatConversation']),
                trailing: Text(
                    '${value.userData[index]['date']}, ${value.userData[index]['time']}'),
              );
            });
          },
        );
      },
    );
  }
}
