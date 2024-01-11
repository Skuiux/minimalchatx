import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: Text("Settings"),
      backgroundColor: Colors.transparent,
        foregroundColor: Colors.lightGreen,
        elevation: 2.0,
      ),
      body: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.all(25),
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Dark Mode"),
            CupertinoSwitch(value: true, onChanged: (value)
            {},)
          ],
        ),
      ),
    );
  }
}
