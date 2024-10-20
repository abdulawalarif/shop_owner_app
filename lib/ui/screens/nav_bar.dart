// import 'package:chronoshop/screens/pending_screen.dart';
// import 'package:chronoshop/screens/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_owner_app/ui/constants/assets_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_owner_app/core/view_models/theme_change_provider.dart';
import 'package:shop_owner_app/ui/utils/ui_tools/my_alert_dialog.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import 'login_screen.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String phone = '';
  String name = '';
  String address = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _themeChange = Provider.of<ThemeChangeProvider>(context);

    return SafeArea(
      child: Drawer(
        child: ListView(
          // Remove padding
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(name,
                  style: TextStyle(color: Colors.black87, fontSize: 20)),
              accountEmail:
                  Text(phone, style: TextStyle(color: Colors.black87)),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                    ImagePath.profilePlaceholder,
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      'https://media.istockphoto.com/photos/healthy-food-shopping-concept-picture-id1132266853?k=20&m=1132266853&s=612x612&w=0&h=0GPmf-3NHyy8N-3Gj8mMXNCPYDMsOS0lRWBpH8_MyeM=',
                    )),
              ),
            ),
            ListTile(
              leading: Icon(Icons.pending_actions),
              title: Text('Pending Order'),
              onTap: (() {
                // Get.to(PendingScreen());
              }),
            ),
            ListTile(
              leading: Icon(Icons.account_circle_outlined),
              title: Text('My Profile'),
              onTap: (() {
                // Get.to(ProfileScreen());
              }),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.policy_sharp),
              title: Text('Privacy Policies'),
              onTap: (() async {
                // var url = 'https://sites.google.com/view/solutionpro';
                // if(await canLaunch(url)){
                //   await launch(url);
                // }
                // else
                // {
                //   throw "Cannot load url";
                // }
              }),
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Terms Of Use'),
              onTap: (() async {
                var url = 'https://sites.google.com/view/solutionpro';
                // if(await canLaunch(url)){
                //   await launch(url);
                // }
                // else
                // {
                //   throw "Cannot load url";
                // }
              }),
            ),
            Card(
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Dark Theme'),
                    secondary: _customIcon(Icons.dark_mode),
                    value: _themeChange.isDarkTheme,
                    onChanged: (bool value) {
                      setState(() {
                        _themeChange.isDarkTheme = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sign Out'),
              onTap: (() {
                MyAlertDialog.signOut(context); //    Get.offAll(LoginScreen());
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customIcon(IconData icon) {
    return Icon(
      icon,
      color: Theme.of(context).iconTheme.color,
    );
  }
}