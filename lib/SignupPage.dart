import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mid_quiz_minapp/LoginPage.dart';
import 'package:mid_quiz_minapp/pages/widgets/TextField.dart';
import 'package:mid_quiz_minapp/pages/widgets/my_button.dart';


class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void showErrorMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> signUpUser(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // Navigate to HomePage or another relevant page upon successful sign-up
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()), // Adjust destination as needed
      );
    } on FirebaseAuthException catch (e) {
      // Handle different Firebase Auth exceptions
      String errorMessage = "An error occurred. Please try again.";
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'An account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      }
      showErrorMessage(context, errorMessage);
    } catch (e) {
      showErrorMessage(context, "An unexpected error occurred. Please try again.");
    }
  }
  @override
  Widget build(BuildContext context) {
    // Dynamically adapt colors and styles based on the theme
    Color backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    Color iconColor = Theme.of(context).iconTheme.color ?? Colors.black;
    Color textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    //TextStyle buttonTextStyle = Theme.of(context).textTheme.button ?? TextStyle();

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: iconColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(height: 50),
                Icon(Icons.person_add, size: 100, color: iconColor),
                const SizedBox(height: 50),
                Text('Create Account', style: TextStyle(color: textColor, fontSize: 16)),
                const SizedBox(height: 25),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      MyTextField(
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false,
                        style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.grey),
                        validator: (value) {
                          if (value == null || value.isEmpty || !value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                        style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.grey),
                        validator: (value) {
                          if (value == null || value.isEmpty || value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      MyTextField(
                        controller: confirmPasswordController,
                        hintText: 'Confirm Password',
                        obscureText: true,
                        style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.grey),
                        validator: (value) {
                          if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),
                      MyButton(
                        onTap: () => signUpUser(context),
                        buttonText: 'Sign Up',

                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

mixin context {
}
