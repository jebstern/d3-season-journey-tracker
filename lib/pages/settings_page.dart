import 'package:d3_season_journey/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  final Controller c = Get.find<Controller>();
  SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.white),
            title: const Text("Clear completed challenges"),
            subtitle: const Text("This action can't be undone!"),
            onTap: () async {
              await c.clearCompletedChallenges();
              Get.dialog(
                AlertDialog(
                  title: const Text(
                    "Challenges cleared",
                    style: TextStyle(color: Colors.black),
                  ),
                  content: const Text(
                    "All completed challenges cleared.",
                    style: TextStyle(color: Colors.black),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text("OK"),
                    ),
                  ],
                ),
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
