import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mass_app/repositories/articles/screens/articles_screen.dart';
import 'package:mass_app/repositories/auth/auth_screens/screens/profile_screen.dart';
import 'package:mass_app/repositories/home/screens/drawer_screens/support_us.dart';

import 'package:mass_app/repositories/home/screens/home_blocs.dart';
import 'package:mass_app/repositories/tv/tv_widgets/screens/tv_screen.dart';

import 'package:mass_app/utilities/colors%20and%20doubles/colors.dart';
import 'package:mass_app/utilities/colors%20and%20doubles/doubles.dart';

import '../home_widgets.dart/home_utilities_barrel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.userId}) : super(key: key);

  final String? userId;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      const HomePage(),
      const MassTVScreen(),
      const ArticlesScreen(),
      const ProfilePage()
    ];

    List<TabItem> _bottomItems = [
      const TabItem(icon: Icon(Icons.home, size: 20), title: 'Home'),
      const TabItem(icon: Icon(Icons.tv, size: 20), title: 'MASS TV'),
      const TabItem(
          icon: Icon(Icons.feed_outlined, size: 20), title: 'Articles'),
      const TabItem(icon: Icon(Icons.person, size: 20), title: 'Profile'),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Card(
          elevation: 0,
          color: Colors.transparent,
          margin: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: primaryColor, width: 0.5),
            borderRadius: otherBR,
          ),
          child: Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: FaIcon(
                  Icons.menu,
                  color: primaryColor,
                ));
          }),
        ),
      ),
      drawer: Drawer(
        backgroundColor: primaryColor,
        child: const DrawerWidgets(),
      ),
      floatingActionButton: FloatingActionButton.small(
        tooltip: 'Support us',
        backgroundColor: Colors.orangeAccent,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (c) => const SupportUsPage()),
          );
        },
        child: const FaIcon(FontAwesomeIcons.dollarSign),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: ConvexAppBar(
        curveSize: 0,
        items: _bottomItems,
        initialActiveIndex: 0,
        activeColor: primaryColor,
        color: Colors.grey,
        backgroundColor: Colors.white60,
        curve: Curves.bounceIn,
        style: TabStyle.react,
        onTap: (i) {
          setState(() {
            _index = i;
          });
        },
      ),
      body: HomeBlocs(body: _pages[_index], userId: widget.userId!),
    );
  }
}
