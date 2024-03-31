import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'design/home_screen.dart';
import 'design/comic_screen.dart';
import 'design/film_screen.dart';
import 'design/serie_screen.dart';
import 'package:projet/design/search_screen.dart';

void main() {
  runApp(MyApp(index: 0));
}

class MyApp extends StatelessWidget {
  final int index;

  MyApp({required this.index});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(initialIndex: index),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int initialIndex;

  MyHomePage({required this.initialIndex});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ComicsPage(),
    SeriesPage(),
    FilmsPage(),
    SearchPage(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color selectedColor = Color(0xFF6F8FEA);
    Color unselectedColor = Colors.grey;
    Color selectedBgColor = Color(0xFF6F8FEA).withOpacity(0.16);
    Color appBarBackgroundColor = Color(0xFF0F1E2B).withOpacity(0.20);

    return Scaffold(
      body: _pages[_selectedIndex],
      backgroundColor: Color(0xFF0F1E2B),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        child: BottomAppBar(
          color: appBarBackgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List<Widget>.generate(5, (index) {
              return Expanded(
                child: GestureDetector(
                  onTap: () => _onItemTapped(index),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: _selectedIndex == index ? selectedBgColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/images/navbar_${['home', 'comics', 'series', 'movies', 'search'][index]}.svg',
                          color: _selectedIndex == index ? selectedColor : unselectedColor,
                          width: 20, // Largeur des SVG
                        ),
                        Text(
                          ['Accueil', 'Comics', 'Séries', 'Films', 'Recherche'][index],
                          style: TextStyle(
                            color: _selectedIndex == index ? selectedColor : unselectedColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

}
