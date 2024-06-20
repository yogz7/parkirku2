import 'package:flutter/material.dart';
// import 'package:qwerty/beranda.dart';
import 'package:parkirku/berandaa.dart';
// import 'package:parkirku/parkir.dart';
import 'package:parkirku/home_page.dart';
import 'package:parkirku/login.dart';
import 'package:parkirku/akun.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // int _page = 0;
  void deleteData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.clear();
    pref.remove("user");
  }

  void navLoginPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const LoginPage();
    }));
  }



  int _selectedTabIndex = 0;

  void _onNavBarTapped(int index){
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _ListPage = <Widget>[
    //const Text('Beranda'),
      const berandaa(),
      // const RiwayatScreen(),
      const HomePage(),
      const akun()
    ];

    final _bottomNavBarItem = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Beranda',
        ),

      const BottomNavigationBarItem(
        icon: Icon(Icons.local_parking_rounded),
        label: 'Sedang Parkir',
        ),

      const BottomNavigationBarItem(
        icon: Icon(Icons.location_history),
        label: 'Akun'
        ),
    ];

    final _bottomNavBar = BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.red[900],
      items: _bottomNavBarItem,
      currentIndex: _selectedTabIndex,
      unselectedItemColor: Colors.white54,
      selectedItemColor: Colors.white,
      onTap: _onNavBarTapped,
    );

    return Scaffold(
      body: Center(
        child: _ListPage[_selectedTabIndex],
      ),
      bottomNavigationBar: _bottomNavBar,
    );
  }
}