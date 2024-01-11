import 'package:flutter/material.dart';
import 'package:minimalchatx/components/minimalchatx_buttons.dart';
import 'package:minimalchatx/components/minimalchatx_textfield.dart';
import 'package:minimalchatx/services/auth/auth_service.dart';
class LoginPage extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap,
  });

  void login(BuildContext context)
  async
  {
    //auth services
    final authService =  AuthService();

    // try login
    try{
      await authService.signInWithEmailPassword(_emailController.text, _pwController.text,);
    }
    catch (e){
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text(e.toString()),
      ));
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
        Text('Welcome To Minimalchatx App',
        style: TextStyle(color :Theme.of(context).colorScheme.primary,fontSize: 16),),
          const SizedBox(height: 25,),


        M_textfield(hintText: "Email", obscureText: false, controller:_emailController,),
        const SizedBox(height: 20,),
          M_textfield(hintText: "Password", obscureText: true, controller:_pwController,),

        //login
          M_button(text: "Login", onTap: ()=> login(context),),

        const SizedBox(height: 25,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Not a Member, "),
            GestureDetector(
              onTap: onTap,
                child: const Text("Visit Our Registeration Page",style:TextStyle(fontWeight: FontWeight.bold))),
          ],
        )

        //registernow



      ],),

    );
  }
}
