import 'package:flutter/material.dart';
import '../cloud-country/index.dart';
import '../find/index.dart';
import '../fllow/index.dart';
import '../play-client/index.dart';
import '../profile/index.dart';

class Index extends StatefulWidget {
  Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _currentIndex = 0;
  final pages = [
    FindPage(),
    PlayCilentPage(),
    ProfilePage(),
    FllowPage(),
    CloudCountryPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      // 底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
        // 允许多个item
        type: BottomNavigationBarType.fixed,
        // 当前页面组件的index 与pages配合切换页面
        currentIndex: _currentIndex,
        fixedColor: Colors.red,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.find_in_page),
            label: '发现',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_filled),
            label: '播客',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '关注',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_circle),
            label: '云村',
          ),
        ],
        // 此处进行点击操作
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
