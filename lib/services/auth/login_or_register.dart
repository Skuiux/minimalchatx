import 'package:flutter/material.dart';
import 'package:minimalchatx/pages/login_page.dart';
import 'package:minimalchatx/pages/register_page.dart';
class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  // initioally show login page
  bool showLoginPage=true;

  // toggle button with register and login page

  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {

        if(showLoginPage){
          return LoginPage(
            onTap: togglePages,
          );
        }
        else{
          return
          RegisterPage(
            onTap: togglePages,
          );
          }
  }
}
