
import 'package:flutter/material.dart';
import 'package:minimalchatx/components/minimalchatx_textfield.dart';
import 'package:minimalchatx/services/auth/auth_service.dart';
import '../components/minimalchatx_buttons.dart';
class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmpwController = TextEditingController();
  final void Function()? onTap;
   RegisterPage({super.key,
   required this.onTap});
   void register(BuildContext context) {
     // get auth services
     final _auth = AuthService();

     // if password match ->Get user

     if (_pwController.text == _confirmpwController) {
       try{

       _auth.signInWithEmailPassword(_emailController.text, _pwController.text);
     }catch (e) {
         showDialog(context: context, builder:(context) => AlertDialog(
           title:Text(e.toString()),)
         );
       }
     }
     else{showDialog(context: context, builder:(context) => const AlertDialog(
       title:Text('Password Doesnt match!')));
   }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // logo
          Icon(Icons.message,size: 60,
            color:Theme.of(context).colorScheme.primary,),
          const SizedBox(height: 45,),
          // welcome back message
          Text('Lets start to Register ',
            style: TextStyle(color :Theme.of(context).colorScheme.primary,fontSize: 16),),
          const SizedBox(height: 25,),


          M_textfield(hintText: "Email", obscureText: false, controller: _emailController),
          const SizedBox(height: 10,),
          M_textfield(hintText: "Password", obscureText: true, controller: _pwController),
          const SizedBox(height: 10,),
          M_textfield(hintText: "Confirm Password", obscureText: true, controller: _confirmpwController),


          //login
          M_button(text: "Register", onTap:()=>register(context),),

          const SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already Have An Account, "),
              GestureDetector(
                  onTap: onTap,
                  child: const Text("Visit Our Login Page",style:TextStyle(fontWeight: FontWeight.bold))),
            ],
          )

          //registernow



        ],),

    );
  }
}
