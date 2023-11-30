import 'package:ecommerce/screens/favourite_products.dart';
import 'package:ecommerce/screens/login.dart';
import 'package:ecommerce/screens/search_products.dart';
import 'package:ecommerce/screens/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedTab = 0;

  final List<Widget> _tabs = const [
    SearchProducts(),
    FavouriteProducts(),
    ShoppingCart(),
  ];

  _changeTab(int index) {
    _selectedTab = index;
    setState(() {
      _selectedTab = _selectedTab;
    });
  }

  navigateTo() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const Login();
    }));
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLogged');
    navigateTo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        actions: [
          IconButton(
              onPressed: () {
                logout();
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: _tabs[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_rounded), label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Shopping cart'),
        ],
        currentIndex: _selectedTab,
        onTap: (index) {
          _changeTab(index);
        },
      ),
    );
  }
}
