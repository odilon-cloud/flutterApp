import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mid_quiz_minapp/pages/auth_method.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'ui/ThemeHolder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  ThemeHolder().isDarkTheme = await isDarkMode();
  runApp(const MyApp());
}

Future<bool> isDarkMode() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isDarkMode') ?? false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isDarkMode(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: snapshot.data! ? ThemeData.dark() : ThemeData.light(),
            home: const AuthPage(), // Use Auth widget here
          );
        } else {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
