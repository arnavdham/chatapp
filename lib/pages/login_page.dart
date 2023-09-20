import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_text_field.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    final authService=Provider.of<AuthService>(context,listen: false);
    try{
      await authService.signInWithEmailandPassword(
          emailController.text,
          passwordController.text
      );
    }
    catch(e)
    {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(e.toString(),),));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25.0),
                Icon(
                  Icons.message,
                  size: 100.0,
                ),
                const SizedBox(height: 25.0),
                Text(
                  'Welcome back',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25.0),
                MyTextField(
                    controller: emailController,
                    hint: 'Email',
                    obscureText: false),
                const SizedBox(height: 10.0),
                MyTextField(
                    controller: passwordController,
                    hint: 'Password',
                    obscureText: true),
                const SizedBox(height: 25.0),
                MyButton(onTap: signIn, text: 'Sign in'),
                const SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not a member?'),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
