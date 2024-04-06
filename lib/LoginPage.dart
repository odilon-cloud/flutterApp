
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mid_quiz_minapp/SignupPage.dart';
import 'package:mid_quiz_minapp/pages/widgets/TextField.dart';
import 'package:mid_quiz_minapp/pages/widgets/my_button.dart';
import 'package:mid_quiz_minapp/pages/widgets/square_tile.dart';
import 'package:mid_quiz_minapp/MyHomePage.dart';
import 'package:mid_quiz_minapp/pages/AuthService.dart';
//import 'package:mid_quiz_minapp/pages/auth_method.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  //final _formKey = GlobalKey<FormState>();
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn(BuildContext context) async {
    showDialog(context: context, builder: (context){
      return const Center(
        child: CircularProgressIndicator(),
      );
    },);

    try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
    } on FirebaseAuthException catch (e) {
      // Handle login error
    } finally {
      Navigator.pop(context);// Close the progress dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    // Accessing current theme colors
    var backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    var primaryColor = Theme.of(context).primaryColor;
    var textColor = Theme.of(context).textTheme.bodyText1?.color ?? Colors.black;
    var dividerColor = Theme.of(context).dividerColor;

    return Scaffold(
      backgroundColor: backgroundColor, // Use dynamic background color
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Close button
                IconButton(
                  icon: Icon(Icons.close, color: textColor), // Dynamic icon color
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  alignment: Alignment.topRight,
                ),

                const SizedBox(height: 50),
                Icon(
                  Icons.lock,
                  size: 100,
                  color: primaryColor, // Dynamic icon color
                ),
                const SizedBox(height: 50),
                Text(
                  'Welcome back ',
                  style: TextStyle(
                    color: textColor, // Dynamic text color
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: emailController,
                  hintText: 'email',
                  obscureText: false,
                  style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.grey),
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.grey),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: textColor), // Dynamic text color
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                MyButton(
                    onTap:(){ signUserIn(context);}, buttonText: "Sign In",),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: dividerColor, // Dynamic divider color
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: textColor), // Dynamic text color
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: dividerColor, // Dynamic divider color
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    SquareTile(
                        onTap: () => AuthService().signInWithGoogle(),
                        imagePath: 'lib/images/google.png',),
                    SizedBox(width: 25),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: textColor), // Dynamic text color
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
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
