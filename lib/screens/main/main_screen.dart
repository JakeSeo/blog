import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:news/constants.dart';
import 'package:news/controllers/MenuController.dart';
import 'package:news/screens/home/home_screen.dart';

import 'components/header.dart';

class MainScreen extends StatelessWidget {
  final MenuController _controller = Get.put(MenuController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _controller.scaffoldkey,
      drawer: Drawer(
        child: Container(
          color: kDarkBlackColor,
          child: Obx(
            () => ListView(
              children: [
                DrawerHeader(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultPadding * 3.5,
                    ),
                    child: SvgPicture.asset("assets/icons/logo.svg"),
                  ),
                ),
                ...List.generate(
                  _controller.menuItems.length,
                  (index) => DrawerItem(
                    isActive: index == _controller.selectedIndex,
                    title: _controller.menuItems[index],
                    press: () {
                      _controller.setMenuIndex(index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(),
            Container(
              padding: EdgeInsets.all(kDefaultPadding),
              constraints: BoxConstraints(maxWidth: kMaxWidth),
              child: HomeScreen(),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback press;
  const DrawerItem({
    Key key,
    @required this.title,
    @required this.isActive,
    @required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      selected: isActive,
      selectedTileColor: kPrimaryColor,
      onTap: press,
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
