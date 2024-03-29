import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimalchatx/components/minimalchatx_chat_bubble.dart';
import 'package:minimalchatx/components/minimalchatx_textfield.dart';
import 'package:minimalchatx/services/auth/auth_service.dart';
import 'package:minimalchatx/services/chat/chat_services.dart';
class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiverEmail,
  required this.receiverID
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
 //textcontroller
  final TextEditingController _messageController = TextEditingController();

  // chat & auth services
  final Chatservice _chatservice = Chatservice();

  final AuthService _authService = AuthService();

  //for textfield focus
  FocusNode myFocusNode= FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //add Listener to focus node
    myFocusNode.addListener(() {
      if(myFocusNode.hasFocus){
        //cause a delay to start the keyboard has taken gtime to show up
        Future.delayed(Duration(microseconds: 500),()=>scrollDown());
      }
    });
  Future.delayed(Duration(milliseconds: 500),() => scrollDown());
  }
  @override
  void dispose(){
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();
  void scrollDown(){
    _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);

  }
  void sendMesssage()async{
    // if there is something inside the textfield
    if (_messageController.text.isNotEmpty){
      //send the message
      await _chatservice.sendMessage(widget.receiverID, _messageController.text);

      // clear text controller
      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: Text('receiverEmail'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.lightGreen,
        elevation: 2.0,
      ),
      body: Column(children: [
        // diaplay all messages

        //user input
        Expanded(child: _buildMessageList()
        ),
        // userinput
        _buildUserInput(),
      ],
      ),
    );
  }

  // build message list
Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(stream: _chatservice.getMessages(widget.receiverID, senderID), builder: (context,snapshot)
    {
      if(snapshot.hasError){
        return Text('Error');
      }
       if(snapshot.connectionState == ConnectionState.waiting){
         return Text("Loading...");
       }
       return ListView(
         controller: _scrollController,
         children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),);
    },
    );
}

//build message Item
Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //is current user
bool isCurrentUser = data['senderId'] == _authService.getCurrentUser()!.uid;
    //align message to the right if sender is the current user,otherwise left
    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment: isCurrentUser? CrossAxisAlignment.end:CrossAxisAlignment.start,
          children: [
            ChatBubble(message: data['message'], isCurrentUser: isCurrentUser)
          ],
        ));
}

//build message input
Widget _buildUserInput(){
    return Padding(
      padding: const EdgeInsets.only(bottom:50.0),
      child: Row(
        children: [
          // textfield should take most of the space
          Expanded(child: M_textfield(
            controller: _messageController,
            hintText:"Lets Fire The Chatscreen",
            obscureText:false,
            focusNode: myFocusNode,
          ),
          ),
          //send button
          Container(
            decoration: BoxDecoration(color: Colors.lightGreenAccent,
            shape: BoxShape.circle),
              margin: EdgeInsets.only(right: 25),
              child: IconButton(onPressed: sendMesssage, icon: Icon(Icons.arrow_upward,
              color: Colors.white,
              ),)),
        ],
      ),
    );
}
}
