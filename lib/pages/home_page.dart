import 'dart:js';

import 'package:flutter/material.dart';
import 'package:minimalchatx/components/minimalchatx_usertile.dart';
import 'package:minimalchatx/pages/chat_page.dart';
import 'package:minimalchatx/services/auth/auth_service.dart';
import 'package:minimalchatx/components/minimalchatx_drawer.dart';
import 'package:minimalchatx/services/chat/chat_services.dart';
class HomePage extends StatelessWidget {
   HomePage({super.key});
  final Chatservice _chatservice = Chatservice();
  final AuthService _authService = AuthService();
  void logout(){
// get auth services

  final _auth = AuthService();
  _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.lightGreen,
        elevation: 2.0,


      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),

    );
  }
  Widget _buildUserList(){
    return StreamBuilder(
        stream: _chatservice.getUsersStream(),
        builder: (context,snapshot) {
          //error
          if(snapshot.hasError){
            return const Text ("Error");
          }
            //loading
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Text("Loading..");
            }
            return ListView(
              children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData,context)).toList(),
            );
          }

    );
  }
  Widget _buildUserListItem(Map<String,dynamic>userData,BuildContext context){
    // Display All User Except Current user
    if(userData ["email"]!= _authService.getCurrentUser()!.email){
      return UserTile(
        text: userData['email'],
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatPage(

            receiverEmail: userData["email"],
            receiverID: userData["uid"],
          ),));
        },


      );
    }else{
       return Container();
    }
  }
}
