import 'package:flutter/material.dart';
class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({super.key,required this.text,required this.onTap

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.symmetric(vertical: 5,horizontal: 25),
        padding: EdgeInsets.all(25),
        child: Row(
          children: [
            const Icon(Icons.person),
            const SizedBox(width: 25.0,),

            Text('text')
          ],
        ),
      ),

    );
  }
}
