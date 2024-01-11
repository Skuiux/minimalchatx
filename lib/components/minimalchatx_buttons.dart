import 'package:flutter/material.dart';
class M_button extends StatelessWidget {
  final void Function()? onTap;
  final String text;

   M_button({super.key,
  required this.text,
     required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
      
        ),
      
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        padding: EdgeInsets.all(25),
        child: Center(child: Text('Text'),),
      ),
    );
  }
}
