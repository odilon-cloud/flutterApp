import 'package:firebase_auth/firebase_auth.dart';
import 'package:mid_quiz_minapp/pages/widgets/cardDesign.dart';
import 'package:mid_quiz_minapp/pages/AuthService.dart';
import 'package:mid_quiz_minapp/ui/ThemeHolder.dart';
import 'package:flutter/material.dart';
import 'package:mid_quiz_minapp/ui/contacts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:mid_quiz_minapp/ui/CalculatorView.dart';
import 'package:mid_quiz_minapp/ui/profile_avatar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  late bool isDarkMode;
  late PageController _pageController;
  int _selectedTabIndex = 0;
  late ConnectivityResult _connectivityResult;

  @override
  void initState() {
    super.initState();
    _loadTheme();
    _pageController = PageController(initialPage: _selectedTabIndex);
    _checkConnectivity();
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _connectivityResult = result;
        if (_connectivityResult != ConnectivityResult.none) {
          _showSnackbar('Back online');
        }else {_showSnackbar('device offline');}
      });
    });
  }

  Future<void> _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  void _toggleTheme() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // setState(() {
    //   isDarkMode = !isDarkMode;
    //   prefs.setBool('isDarkMode', isDarkMode);
    // });
    ThemeHolder().changeState(!ThemeHolder().getTheme);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedTabIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  Future<void> _checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      _connectivityResult = connectivityResult;
      if (_connectivityResult == ConnectivityResult.none) {
        _showSnackbar('Offline');
      }
    });
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 5),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
          return StreamBuilder<bool>(
            stream: ThemeHolder().getThemeBroadcast(),
            builder: (context, snapshot) {
              return Scaffold(
                backgroundColor: ThemeHolder().getTheme ? Colors.black : Colors.white,
                appBar: AppBar(
                  backgroundColor: ThemeHolder().getTheme ? Colors.black : Colors.white,
                  actions: [
                    Switch(
                      value: ThemeHolder().getTheme,
                      onChanged: (value) {
                        _toggleTheme();
                      },
                    ),
                  ],
                ),
                drawer: Drawer(

                  child: Container(
                    color: ThemeHolder().getTheme ? Colors.black : Colors.white,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      if (user != null) ...[
                        UserAccountsDrawerHeader(
                          accountName: Text(user?.displayName ?? 'Guest'),
                          accountEmail: Text(user?.email ?? 'No Email'),
                          currentAccountPicture: const ProfileAvatar(),
                        ),
                      ] else ...[
                        DrawerHeader(
                          decoration: BoxDecoration(
                            color: ThemeHolder().getTheme ? Colors.black : Colors.white,
                          ),
                          child: ListTile(
                            title: const Text('No Email'),
                            leading: Icon(Icons.email,
                                color: ThemeHolder().getTheme ? Colors.white : Colors.black),
                          ),
                        ),
                      ],


                      ListTile(


                        title: Text('HOME',style: TextStyle(
                            color: ThemeHolder().getTheme ? Colors.white : Colors.black,
                            fontSize: 14),),
                        onTap: () {
                          Navigator.pop(context);
                          _onItemTapped(0);
                        },
                      ),
                      ListTile(
                        title: Text('CALCULATOR',style: TextStyle(
                            color: ThemeHolder().getTheme ? Colors.white : Colors.black,
                            fontSize: 14),),
                        onTap: () {
                          Navigator.pop(context);
                          _onItemTapped(1);
                        },
                      ),


                      ListTile(
                        title: Text('ABOUT',style: TextStyle(
                            color: ThemeHolder().getTheme ? Colors.white : Colors.black,
                            fontSize: 14),),
                        onTap: () {
                          Navigator.pop(context);
                          _onItemTapped(2);
                        },
                      ),
                      ListTile(
                        title: Text('contact',style: TextStyle(
                            color: ThemeHolder().getTheme ? Colors.white : Colors.black,
                            fontSize: 14),),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ContactsPage(email: user?.email ?? 'No Email')),
                          );
                        },
                      ),
                      ListTile(
                        title: Text('quiz finished ',style: TextStyle(
                            color: ThemeHolder().getTheme ? Colors.white : Colors.black,
                            fontSize: 14),),
                        onTap: () {
                          Navigator.pop(context);
                          _onItemTapped(2);
                        },
                      ),
                      ListTile(
                        title: Text('signout',style: TextStyle(
                            color: ThemeHolder().getTheme ? Colors.white : Colors.black,
                            fontSize: 14),),
                        onTap: () async {
                          // Use AuthService to sign out from both Google and Firebase
                          await AuthService().signOut();
                          Navigator.of(context).pushReplacementNamed('/loginPage');
                        },
                      ),
                    ],
                  ),),
                ),
                  /*body: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _selectedTabIndex = index;
                        });
                      },
                      children: const [
                        HomePage(), // Replace this with your own widget or page
                        CalculatorPage(),
                        AboutPage(),
                      ],
                    ),*/
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: _selectedTabIndex,
                  onTap: _onItemTapped,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'HOME',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.calculate),
                      label: 'Calc',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'About',
                    ),
                  ],
                  selectedItemColor: Colors.blue,
                  unselectedItemColor: Colors.grey,
                  backgroundColor: ThemeHolder().getTheme ? Colors.black : Colors.white,
                ),
              );
            }
          );


  }
}

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeHolder().getTheme ? Colors.black : Colors.white,
      body: const Center(
        child: CalculatorView(),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeHolder().getTheme ? Colors.black : Colors.white,
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: const Center(
        child: Text(
          'About Page',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
