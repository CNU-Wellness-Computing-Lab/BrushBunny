import 'package:flutter/material.dart';
import 'package:oral_hygiene_habits/do_brushing.dart';
import 'package:oral_hygiene_habits/goal_reward.dart';
import 'package:oral_hygiene_habits/home_mainfeed.dart';
import 'package:oral_hygiene_habits/learning_oral_hygiene.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeMainFeed(),
    LearningOralHygiene(),
    DoBrushing(),
    GoalReward(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        backgroundColor: Colors.yellow[50],
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: const Color.fromARGB(255, 234, 166, 117),
          title: Row(
            children: [
              Text(
                'BRUSH BUNNY',
                style: TextStyle(fontFamily: 'HS-yuji', fontSize: 19.sp),
              ),
              Text(
                '₍ᐢ.ˬ.ᐢ₎',
                style: TextStyle(fontSize: 19.sp),
              )
            ],
          ),
          //로그아웃
          actions: [
            IconButton(
              onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text('로그아웃'),
                        content: const Text('로그아웃 하시겠습니까?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'OK');
                              FirebaseAuth.instance.signOut();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      )),
              icon: const Icon(
                Icons.logout_rounded,
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 234, 166, 117),
              icon: Icon(Icons.home),
              label: '홈',
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xffA8CFBD),
              icon: Icon(Icons.school_rounded),
              label: '배우기',
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xffAEAC9A),
              icon: Icon(Icons.face_retouching_natural),
              label: '양치질',
            ),
            BottomNavigationBarItem(
              backgroundColor: Color.fromARGB(255, 237, 180, 180),
              icon: Icon(Icons.diamond_rounded),
              label: '보상',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      );
    });
  }
}
