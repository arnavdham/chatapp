import 'package:chatapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/components/my_button.dart';
import 'package:chatapp/components/my_text_field.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  void signUp() async {
    if (passwordController.text != confirmpasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match!'),
        ),
      );
      return;
    }
    final authService=Provider.of<AuthService>(context,listen:false);
    try {
      await authService.signUpWithEmailandPassword(emailController.text, passwordController.text);
    }
    catch(e)
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()),),);
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
                  "Let's create an account for you!",
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
                const SizedBox(height: 10.0),
                MyTextField(
                    controller: confirmpasswordController,
                    hint: 'Confirm password',
                    obscureText: true),
                const SizedBox(height: 25.0),
                MyButton(onTap: signUp, text: 'Sign Up'),
                const SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already a member?'),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
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
