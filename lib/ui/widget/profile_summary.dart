import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:task_manager/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/edit_profile_screen.dart';
import 'package:task_manager/ui/screens/login_screen.dart';

class ProfileSummary extends StatefulWidget {
  const ProfileSummary({
    super.key,
    this.enableOnTap = true,
  });

  final bool enableOnTap;

  @override
  State<ProfileSummary> createState() => _ProfileSummaryState();
}

class _ProfileSummaryState extends State<ProfileSummary> {
  String? imageFormat = AuthController.user?.photo ?? "";

  @override
  Widget build(BuildContext context) {
    if (imageFormat!.startsWith('data:image')) {
      imageFormat =
          imageFormat!.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), " ");
    }
    Uint8List imageBytes = const Base64Decoder().convert(imageFormat!);

    return ListTile(
        onTap: () {
          if (widget.enableOnTap) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const UpdateProfile()));
          }
        },
        tileColor: Colors.green,
        leading: CircleAvatar(
            child: imageBytes.isEmpty
                ? const Icon(Icons.person_2_outlined)
                : CircleAvatar(
              backgroundImage: Image.memory(
                imageBytes,
                fit: BoxFit.cover,
              ).image,
            )),
        title: Text(
          fullName,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        subtitle: Text(
          AuthController.user?.email ?? '',
          style: const TextStyle(color: Colors.white),
        ),
        trailing: IconButton(
          onPressed: showLogOutDialog,
          icon: const Icon(Icons.logout_outlined),
        ));
  }

  String get fullName {
    return '${AuthController.user?.firstName ?? ''} ${AuthController.user?.lastName ?? ''}';
  }

  void showLogOutDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("LogOut"),
            content: const Text("Do you want to Logout?"),
            actions: [
              TextButton(
                  onPressed: () async {
                    await AuthController.clearAuthUser();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                            (route) => false);
                  },
                  child: const Text("Yes")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"))
            ],
          );
        });
  }
}