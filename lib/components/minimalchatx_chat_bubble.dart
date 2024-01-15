import 'package:flutter/material.dart';
import 'package:minimalchatx/themes/themes_provider.dart';
import 'package:provider/provider.dart';
class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

   ChatBubble({super.key ,required this.message,
   required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {

    bool isDarkMode=Provider.of<ThemeProvider>(context,listen: false).isDarkMode;
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser?
        (isDarkMode?Colors.green.shade600:Colors.grey.shade500):
          (isDarkMode?Colors.grey.shade500:Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 25),
      child: Text(message,
      style: TextStyle(color:isCurrentUser?  Colors.white:(isDarkMode?Colors.white:Colors.black)),
      ),
    );
  }
}
