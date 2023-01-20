import 'package:flutter/material.dart';
import 'package:submission_3/theme.dart';

enum TypeBottomNav { home, favorite, settings }

class BottomNav extends StatefulWidget {
  final TypeBottomNav selected;

  const BottomNav({super.key, required this.selected});

  @override
  State<StatefulWidget> createState() => _BottomNav();
}

class _BottomNav extends State<BottomNav> {
  int _selectedBottomNav = 0;

  void _changeSelectedBottomNav(int index) {
    setState(() {
      _selectedBottomNav = index;

      if (_selectedBottomNav == 0) {
        Navigator.pushNamed(context, '/home_page');
      } else if (_selectedBottomNav == 1) {
        Navigator.pushNamed(context, '/favorite_page');
      } else {
        Navigator.pushNamed(context, '/settings_page');
      }
    });
  }

  @override
  Widget build(BuildContext context) => Theme(
      data: Theme.of(context).copyWith(canvasColor: whiteColor),
      child: Container(
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32), topRight: Radius.circular(32))),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32)),
          child: BottomNavigationBar(
            currentIndex: _selectedBottomNav,
            onTap: _changeSelectedBottomNav,
            items: [
              BottomNavigationBarItem(
                  icon: widget.selected == TypeBottomNav.home
                      ? Icon(Icons.home, color: orangeColor,)
                      : Icon(Icons.home_outlined, color: greyColor,),
              label: ''),
              BottomNavigationBarItem(
                  icon: widget.selected == TypeBottomNav.favorite
                      ?  Icon(Icons.favorite, color: orangeColor,)
                      :  Icon(Icons.favorite_outline, color: greyColor,),
              label: ''),
              BottomNavigationBarItem(icon: widget.selected == TypeBottomNav.settings ?
              Icon(Icons.settings, color: orangeColor,)
              : Icon(Icons.settings_outlined, color: greyColor,),
              label: '')
            ],
          ),
        ),
      ));
}
