import 'dart:math';

import 'package:final_project_2025/common/main_navigation/widgets/nav_tab.dart';
import 'package:final_project_2025/constants/sizes.dart';
import 'package:final_project_2025/features/home/views/home_screen.dart';
import 'package:final_project_2025/features/post/views/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class MainNavigationScreen extends ConsumerStatefulWidget {
  static const String routeName = "mainNaviation";
  final String tab;
  const MainNavigationScreen({required this.tab, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState extends ConsumerState<MainNavigationScreen> {
  final List<String> _tabs = ["home", "post"];
  late int _selectedIndex = max(_tabs.indexOf(widget.tab), 0);

  void _indexCheck() {
    if (_selectedIndex != _tabs.indexOf(widget.tab)) {
      _selectedIndex = max(_tabs.indexOf(widget.tab), 0);
      setState(() {});
    }
  }

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _indexCheck();
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Offstage(offstage: _selectedIndex != 0, child: HomeScreen()),
          Offstage(offstage: _selectedIndex != 1, child: PostScreen()),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.only(top: Sizes.size28, bottom: Sizes.size12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NavTab(
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.houseUser,
                text: "Home",
                isSelected: _selectedIndex == 0,
                onTap: () => _onTap(0),
              ),
              NavTab(
                icon: FontAwesomeIcons.pen,
                selectedIcon: FontAwesomeIcons.penToSquare,
                text: "Post",
                isSelected: _selectedIndex == 1,
                onTap: () => _onTap(1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
